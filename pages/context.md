- [golang context实现： 简单理解就是一个链表，不管什么类型的ctx，ctx不变都是复制，不停的加value... done特性等](https://bd-doc-id-{change}?from=message_bot&sender_type=101&message_id=7361620719779430450#KRsJdj58ooEMElxMsL6cMfvlnyh)
	- ![image.png](../assets/image_1714128072905_0.png)
- ---
- ## 定义
	- context严格来说不等于"上下文"，和通常所说的进程现场切换所保存的堆栈、寄存器、函数指针等信息不完全等价。golang里的context可以理解为把多个goroutine需要的信息打包放在一起，具体内容是啥是由使用者来丢进去，甚至可以理解为一个变量
	- 看下官方的定义：
		- Go1.7加入了一个新的标准库context，它定义了Context类型，专门用来简化 对于处理单个请求的多个 goroutine 之间与请求域的数据、取消信号、截止时间等相关操作，这些操作可能涉及多个 API 调用。
		- 对服务器传入的请求应该创建上下文，而对服务器的传出调用应该接受上下文。它们之间的函数调用链必须传递上下文，或者可以使用WithCancel、WithDeadline、WithTimeout或WithValue创建的派生上下文。当一个上下文被取消时，它派生的所有上下文也被取消。
- 可取消的context
	- ```go
	  // 官方实例
	  func main() {
	  	// gen generates integers in a separate goroutine and
	  	// sends them to the returned channel.
	  	// The callers of gen need to cancel the context once
	  	// they are done consuming generated integers not to leak
	  	// the internal goroutine started by gen.
	  	gen := func(ctx context.Context) <-chan int {
	  		dst := make(chan int)
	  		n := 1
	  		go func() {
	  			for {
	  				select {
	  				case <-ctx.Done():
	  					return // returning not to leak the goroutine
	  				case dst <- n:
	  					n++
	  				}
	  			}
	  		}()
	  		return dst
	  	}
	  
	  	ctx, cancel := context.WithCancel(context.Background())
	  	defer cancel() // cancel when we are finished consuming integers
	  
	  	for n := range gen(ctx) {
	  		fmt.Println(n)
	  		if n == 5 {
	  			break
	  		}
	  	}
	  }
	  ```
- 实现
	- ```apl
	  type Context interface {
	      Deadline() (deadline time.Time, ok bool)
	  
	      Done() <-chan struct{}
	  
	      Err() error
	  
	      Value(key interface{}) interface{}
	  }
	  
	  
	  type valueCtx struct {
	      Context // 匿名
	      key, val interface{}
	  }
	  
	  
	  # withValue实现
	  func WithValue(parent Context, key, val interface{}) Context {
	      if key == nil {
	         panic("nil key")
	      }
	      if !reflect.TypeOf(key).Comparable() {
	         panic("key is not comparable")
	      }
	      return &valueCtx{parent, key, val} // 返回的ctx和parent关系？ 只是复制了parent，并没修改
	      // WithValue一次，就会阐释一个新的ctx，旧的parent没变，形成了一个链表式ctx
	  }
	  
	  // 从ctx读取value时，找parent逐次获取查询
	  // c1 <-- c2([c1] k2, v2) <-- c3([c2], k3, v3) <-- c4([c3], k4, v4) 
	  func (c *cancelCtx) Value(key any) any {
	  	if key == &cancelCtxKey {
	  		return c
	  	}
	  	return value(c.Context, key); 
	  }
	  
	  // ctx因为有传递性，需找到valueContext，然后去处，for会便利从当前ctx，向后找到parent一直到找到或结束
	  func value(c Context, key any) any {
	  	for {
	  		switch ctx := c.(type) {
	  		case *valueCtx:
	  			if key == ctx.key {
	  				return ctx.val
	  			}
	  			c = ctx.Context
	  		case *cancelCtx:
	  			if key == &cancelCtxKey {
	  				return c
	  			}
	  			c = ctx.Context
	  		case withoutCancelCtx:
	  			if key == &cancelCtxKey {
	  				// This implements Cause(ctx) == nil
	  				// when ctx is created using WithoutCancel.
	  				return nil
	  			}
	  			c = ctx.c
	  		case *timerCtx:
	  			if key == &cancelCtxKey {
	  				return &ctx.cancelCtx
	  			}
	  			c = ctx.Context
	  		case backgroundCtx, todoCtx:
	  			return nil
	  		default:
	  			return c.Value(key)
	  		}
	  	}
	  }
	  
	  ```
	- [[draws/2024-06-03-17-38-55.excalidraw]]
- 关键的是withCancel这个
	- ```go
	  type canceler interface {
	      cancel(removeFromParent bool, err error)
	      Done() <-chan struct{}
	  }
	  
	  type cancelCtx struct {
	  	Context
	  	mu       sync.Mutex            // protects following fields
	  	done     atomic.Value          // of chan struct{}, created lazily, closed by first cancel call
	  	children map[canceler]struct{} // set to nil by the first cancel call
	  	err      error                 // set to non-nil by the first cancel call
	  	cause    error                 // set to non-nil by the first cancel call
	  }
	  
	  
	  func (c *cancelCtx) Done() <-chan struct{} {
	      c.mu.Lock()
	      if c.done == nil {
	         c.done = make(chan struct{})
	      }
	      d := c.done
	      c.mu.Unlock()
	      return d
	  }
	  
	  
	  // 关键的是要找一个parent，必须也是可以cancel的，不能放在withValue的，所以有个propaganda传播找父节点
	  func WithCancel(parent Context) (ctx Context, cancel CancelFunc) {
	      c := newCancelCtx(parent) // 生成一个新的可取消节点
	      propagateCancel(parent, &c) // 找到可取消祖先并记录自己到祖先的 children
	      return &c, func() { c.cancel(true, Canceled) }
	  }
	  
	  // newCancelCtx returns an initialized cancelCtx.
	  func newCancelCtx(parent Context) cancelCtx {
	      return cancelCtx{Context: parent}
	  }
	  
	  // propagateCancel arranges for child to be canceled when parent is.
	  // It sets the parent context of cancelCtx.
	  func propagateCancel(parent Context, child canceler) {
	      if parent.Done() == nil {
	         return // 这里尤其注意，parent.Done() 返回 nil，表示整个链上都没有可取消/可超时的 context。因为新的 Context 在包含父节点的时候，都是采用匿名字段，也就是说，如果新的 Context 本身没有某个函数，但是它的匿名字段上有那个函数，那么该函数是可以直接被新的 Context 调用的。如此就可以一直追溯到 background 节点，而正好这个根节点是有 Done() 这个函数，并且返回 nil。另外，不可能出现中间一个可取消 context 调用 Done() 返回 nil，看实现便知。
	      }
	      if p, ok := parentCancelCtx(parent); ok {  // parentCancelCtx 拿到他最近可取消的parent
	         p.mu.Lock()
	         if p.err != nil {
	            // parent has already been canceled
	            child.cancel(false, p.err)
	         } else {
	            if p.children == nil {
	               p.children = make(map[canceler]struct{})  //  设置给跑p， canceler就是p的children cancel
	            }
	            p.children[child] = struct{}{}
	         }
	         p.mu.Unlock()
	      } else {       go func() {
	            select {
	            case <-parent.Done():
	               child.cancel(false, parent.Err())
	            case <-child.Done():
	            }
	         }()
	      }
	  }
	  
	  // parentCancelCtx 获取最近可cancel的parent
	  // cancellctx1 <---  cancellCtx2 <---- withValueCtx <--- withValueCtx <----  cancelCtx
	  //                       |______________________________________________________|
	  func parentCancelCtx(parent Context) (*cancelCtx, bool) {
	      for { 
	         switch c := parent.(type) {
	         case *cancelCtx:
	            return c, true
	         case *timerCtx:
	            return &c.cancelCtx, true
	         case *valueCtx:
	            parent = c.Context  // 继续找他的parent --> cancellCtx2
	         default:
	            return nil, false
	         }
	      }
	  }
	  ```
	- ```
	  					backgroupCtx
	  						|
	  					/cacnelCtx\ --> 他是他们的parent，只有他可cancel
	  				  /     |      \
	  	valueCtx    /	 valueCtx    \   valueCtx
	  	   |      /         |         \    |
	     cancelCtx /       valueCtx       \cancelCtx
	  ```
- 建议
	- 不要将上下文存储在结构类型中；
		- 结构体在多个goroutine中传递，对goroutine来说是全局的，context希望的是调用栈之间传递一些信号局部变量等
	- 将 Context 显式传递给每个需要它的函数。 Context 应该是第一个参数，通常命名为 ctx
	- 即使函数允许，也不要传递 nil 上下文。如果您不确定要使用哪个 Context，请传递 context.TODO。
	- 仅将上下文值用于传输进程和 API 的请求范围数据，而不是用于将可选参数传递给函数。
	- 并发安全：相同的 Context 可以传递给在不同 goroutine 中运行的函数；上下文对于多个 goroutine 同时使用是安全的。
		- immutable的，他在传递过程中都是复制！
