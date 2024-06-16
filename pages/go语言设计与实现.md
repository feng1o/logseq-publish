- [online-book-go语言设计与实现](https://draveness.me/golang/docs/part3-runtime/ch06-concurrency/golang-context/)
-
- #### 基础点
	- 5.3 defer[#](https://draveness.me/golang/docs/part2-foundation/ch05-keyword/golang-defer/#53-defer)
		- `defer` 的实现一定是由编译器和运行时共同完成的。
		- 后调用的 `defer` 函数会先执行：
			- 后调用的 `defer` 函数会被追加到 Goroutine `_defer` 链表的最前面；
			- 运行 [`runtime._defer`](https://draveness.me/golang/tree/runtime._defer) 时是从前到后依次执行；
		- 函数的参数会被预先计算；
			- 调用 [`runtime.deferproc`](https://draveness.me/golang/tree/runtime.deferproc) 函数创建新的延迟调用时就会立刻拷贝函数的参数，函数的参数不会等到真正执行时计算,（为何直接defer传值是初试的)
- 第六章：并发编程
  background-color:: #978626
	- 1.context
	  background-color:: #787f97
		- 1.1 设计原理：
		  在 Goroutine 构成的树形结构中对信号进行同步以减少计算资源的浪费是 [ `context.Context` ](https://draveness.me/golang/tree/context.Context) 的最大作用
		  ```go
		  func main() {
		  	ctx, cancel := context.WithTimeout(context.Background(), 1*time.Second)
		  	defer cancel()
		  
		  	go handle(ctx, 500*time.Millisecond)
		  	select {
		  	case <-ctx.Done():
		  		fmt.Println("main", ctx.Err())
		  	}
		  }
		  
		  func handle(ctx context.Context, duration time.Duration) {
		  	select {
		  	case <-ctx.Done():
		  		fmt.Println("handle", ctx.Err())
		  	case <-time.After(duration):
		  		fmt.Println("process request with", duration)
		  	}
		  }
		  ```
		- 1.2 默认context
			- [ `context` ](https://github.com/golang/go/tree/master/src/context) 包中最常用的方法还是 [ `context.Background` ](https://draveness.me/golang/tree/context.Background)、[ `context.TODO` ](https://draveness.me/golang/tree/context.TODO)，
			- contex层级关系 ![image.png](../assets/image_1658829608614_0.png){:height 128, :width 443}
				- [ `context.Background` ](https://draveness.me/golang/tree/context.Background) 是上下文的默认值，所有其他的上下文都应该从它衍生出来；
				- [ `context.TODO` ](https://draveness.me/golang/tree/context.TODO) 应该仅在不确定应该使用哪种上下文时使用；
		- 1.3 [取消信号](https://draveness.me/golang/docs/part3-runtime/ch06-concurrency/golang-context/#613-%e5%8f%96%e6%b6%88%e4%bf%a1%e5%8f%b7)
			- [ `context.WithCancel` ](https://draveness.me/golang/tree/context.WithCancel) 函数能够从 [ `context.Context` ](https://draveness.me/golang/tree/context.Context) 中衍生出一个新的子上下文并返回用于取消该上下文的函数
		-
-
-