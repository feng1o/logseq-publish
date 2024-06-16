- #interview
- {{renderer :tocgen2, [[]], auto, 2}}
- ##### map <span class=" bg-green white  subw hblack hover"> [[2023-02-20 Mon]] </span>  [#](https://golang.design/go-questions/map/principal/#map-%e5%86%85%e5%ad%98%e6%a8%a1%e5%9e%8b)
  background-color:: blue
  > 最主要的数据结构有两种：`哈希查找表（Hash table）`、`搜索树（Search tree） avl或rb树`。  碰撞解决`链表法`和`开放地址法`
  > Go 语言采用的是[[$red]]==哈希查找表==，并且使用[[$red]]==链表解决哈希冲突==。  1.9.2
	- ##### map 内存模型 [#](https://golang.design/go-questions/map/principal/)
		- 【引申1】slice 和 map 分别作为函数参数时有什么区别？    --   slice返回的是结构体   map是指针
		- `bmap` 就是我们常说的“桶”，桶里面会最多装 8 个 key，这些 key 之所以会落入同一个桶，第九个就会新加通过overflow连起来
			- Go 语言采用一个 bucket 里装载 8 个 key，定位到某个 bucket 后，还需要再定位到具体的 key，这实际上又用了时间换空间。
		- 扩容[过程？](https://golang.design/go-questions/map/extend/)
			- 还记得前面讲过的扩容过程吗？扩容过程不是一个原子的操作，它每次最多只搬运 2 个 bucket，所以如果触发了扩容操作，那么在很长时间里，map 的状态都是处于一个中间态：有些 bucket 已经搬迁到新家，而有些 bucket 还待在老地方。
			- bucket数量要有一个度，不然所有的 key 都落在了同一个 bucket 里，直接退化成了链表，各种操作的效率直接降为 O(n)，是不行的。
			- 因此，需要有一个指标来衡量前面描述的情况，这就是`装载因子`。Go 源码里这样定义 `装载因子`
			- 会触发扩容：
				- 装载因子超过阈值，源码里定义的阈值是 6.5。
				- overflow 的 bucket 数量过多：当 B 小于 15，也就是 bucket 总数 2^B 小于 2^15 时，如果 overflow
				   的 bucket 数量超过 2^B；当 B >= 15，也就是 bucket 总数 2^B 大于等于 2^15，如果 overflow 的
				   bucket 数量超过 2^15。
				-
		- 每个bucket内部key 和value是分开放的，不是一组一组放
		- map在扩容的时候，要搬迁部分bucket，可能存在中间状态， 什么时候扩容？ 壮哉因子超过 阈值6.5， overflow的bucket过多
		- key为什么是无序的？ 扩容后会搬，key位置会变动很大； 还一个每次for 遍历时go也是从一个随机序号开始的
		- map不是线程安全的、遍历过程删除加都可能有问题 sync.RWMutex
		- 无法对map的key value取地址，即时通过unsafe.pointer拿到，也可能会变了
		-
- ##### interface[#](http://golang.design/go-questions/interface/duck-typing/)
  background-color:: blue
	- card-last-interval:: 8.32
	  card-repeats:: 3
	  card-ease-factor:: 2.08
	  card-next-schedule:: 2024-05-05T23:04:30.420Z
	  card-last-reviewed:: 2024-04-27T16:04:30.420Z
	  card-last-score:: 3
	  > go的接口有什么特点:  引入了[[#green]]==动态语言的便利==，同时又会进行静态语言的[[#green]]==类型检查==，写起来是非常 Happy 的。Go 采用了折中的做法：[[#red]]==不要求类型显示地声明实现了某个接口，只要实现了相关的方法即可== #card
		- `iface` 和 `eface` 都是 Go 中描述接口的底层结构体，区别在于 `iface` 描述的接口包含方法，而 `eface` 则是不包含任何方法的空接口：`interface{}`
			- `iface` 内部维护两个指针，`tab` 指向一个 `itab` 实体   data指向具体的值
				- `tab` 是接口表指针，指向类型信息；`data` 是数据指针，则指向具体的数据。它们分别被称为`动态类型`和`动态值`。而接口值包括`动态类型`和`动态值` [#](http://golang.design/go-questions/interface/dynamic-typing/)
			- `eface` 就比较简单了。只维护了一个 `_type` 字段，表示空接口所承载的具体的实体类型。`data` 描述了具体的值
		- 编译期自动检测是否实现了接口 [#](http://golang.design/go-questions/interface/detect-impl/)
			- ```
			  var _ io.Writer = (*myWriter)(nil)
			  var _ io.Writer = myWriter{}     // 检查 myWriter 类型是否实现了 io.Writer 接口
			  ```
		- [类型转换和断言区别](http://golang.design/go-questions/interface/assert/)
			- `类型转换`、`类型断言`本质都是把一个类型转换成另外一个类型。不同之处在于，类型断言是对接口变量进行的操作
		- [Go接口和c++接口有和异同  #](http://golang.design/go-questions/interface/compare-to-cpp/)
			- > C++ 通过虚函数表来实现基类调用派生类的函数；而 Go 通过 `itab` 中的 `fun` 字段来实现接口变量调用实体类型的函数
- ##### [[channel]] [#](http://golang.design/go-questions/channel/csp/)
  background-color:: blue
  id:: 641027d6-e2de-4235-94ac-556b58e14f9c
	- card-last-interval:: 8.32
	  card-repeats:: 3
	  card-ease-factor:: 2.08
	  card-next-schedule:: 2024-03-06T10:39:44.187Z
	  card-last-reviewed:: 2024-02-27T03:39:44.187Z
	  card-last-score:: 3
	  > 不要通过共享内存来通信，而要通过[[$red]]==通信来实现内存共享==。  这就是 Go 的并发哲学，它依赖 CSP 模型，基于 channel 实现 [# ](https://golang.design/go-questions/channel/csp/) #card
	- 数据结构 [#](https://golang.design/go-questions/channel/struct/#%e6%95%b0%e6%8d%ae%e7%bb%93%e6%9e%84)
		- `buf` 指向底层循环数组(缓冲channel)， `sendq recvq` 表示被阻塞的goroutine， `sendx recvx` 发送接收msg相对位置
	- [向channel发送数据过程怎么样的?](http://golang.design/go-questions/channel/send/) [[channel]] #card
	  card-last-interval:: 4
	  card-repeats:: 2
	  card-ease-factor:: 2.22
	  card-next-schedule:: 2024-01-19T11:44:28.636Z
	  card-last-reviewed:: 2024-01-15T11:44:28.636Z
	  card-last-score:: 3
		- a.检查接收的channel是否合法、比如nil直接返回fasle，goroutine 挂起
		  b.对于不阻塞的发送操作，如果 channel 未关闭并且没有多余的缓冲空间
			- 如果channel已close，panic
			- 如果能从等待接收队列 recvq 里出队一个 sudog（代表一个 goroutine），说明此时 channel 是空的，没有元素，所以才会有等待接收者。这时会调用 send 函数将元素[[#red]]==直接从发送者的栈拷贝到接收者的栈==，关键操作由 `sendDirect` 函数完成
		- 如果没有命中以上条件的，说明 channel 已经满了，阻塞起来。
		- 这里有一些绑定操作，sudog 通过 g 字段绑定 goroutine，而 goroutine 通过 waiting 绑定 sudog，sudog 还通过 `elem` 字段绑定待发送元素的地址，以及 `c` 字段绑定被“坑”在此处的 channel。
		- 所以，待发送的元素地址其实是存储在 sudog 结构体里，也就是当前 goroutine 里。
	- [从channel读取数据怎么样的？](https://golang.design/go-questions/channel/recv/#%e6%ba%90%e7%a0%81%e5%88%86%e6%9e%90) [[channel]] #card
	  card-last-interval:: 4
	  card-repeats:: 2
	  card-ease-factor:: 2.22
	  card-next-schedule:: 2024-01-27T14:20:53.029Z
	  card-last-reviewed:: 2024-01-23T14:20:53.030Z
	  card-last-score:: 3
		- 如果 channel 是一个空值（nil），在非阻塞模式下，会直接返回
		- 和发送函数一样，接下来搞了一个在非阻塞模式下，不用获取锁，快速检测到失败并且返回的操作。 (没准备好: 非缓冲的发送队列里没goroutine，缓冲性buffer是空的 --- > 都说明没数据可操作)
		- 接下来的操作，首先会上一把锁，粒度比较大。
		- 接下来，如果有等待发送的队列，说明 channel 已经满了，要么是非缓冲型的 channel，要么是缓冲型的 channel，但 buf 满了。这两种情况下都可以正常接收数据。
		- 最后，取出 sudog 里的 goroutine，调用 goready 将其状态改成 “runnable”，待发送者被唤醒，等待调度器的调度。
	- [关闭goroutine过程](http://golang.design/go-questions/channel/close/) #card
	  card-last-interval:: 8.32
	  card-repeats:: 3
	  card-ease-factor:: 2.08
	  card-next-schedule:: 2024-03-06T10:39:59.221Z
	  card-last-reviewed:: 2024-02-27T03:39:59.222Z
	  card-last-score:: 3
		- close 逻辑比较简单，对于一个 channel，recvq 和 sendq 中分别保存了阻塞的发送者和接收者。关闭 channel 
		  后，对于等待接收者而言，会收到一个相应类型的零值。对于等待发送者，会直接 panic。所以，在不了解 channel 
		  还有没有接收者的情况下，不能贸然关闭 channel。
		- <span> <a class=ask>  关闭的chan能读取buffer里的数据，因为读取时判定过程是有buffer的无数据并close的才会立即返回 </a>  <span class=" bg-green white  subw hblack hover"> [[2023-02-28 Tue]] </span></span>
	- [操作channel总结](http://golang.design/go-questions/channel/ops/) [[channel]]  #card
	  card-last-interval:: 8.32
	  card-repeats:: 3
	  card-ease-factor:: 2.08
	  card-next-schedule:: 2024-05-05T23:02:39.451Z
	  card-last-reviewed:: 2024-04-27T16:02:39.452Z
	  card-last-score:: 3
		- 总结一下，发生 panic 的情况有三种：向一个关闭的 channel 进行写操作；关闭一个 nil 的 channel；重复关闭一个 channel。
		- [[$red]]==读、写一个 nil channel 都会被阻塞==。
	- [如何优雅关闭channel](http://golang.design/go-questions/channel/graceful-close/) #card
	  card-last-interval:: 4
	  card-repeats:: 2
	  card-ease-factor:: 2.22
	  card-next-schedule:: 2024-03-02T03:34:15.292Z
	  card-last-reviewed:: 2024-02-27T03:34:15.293Z
	  card-last-score:: 3
		- 有两个不那么优雅地关闭 channel 的方法：
			- 使用 defer-recover 机制，放心大胆地关闭 channel 或者向 channel 发送数据。即使发生了 panic，有 defer-recover 在兜底。
			- 使用 sync.Once 来保证只关闭一次。
		- 引入一个中间者: channel 通知goroutine关闭，最终有一个主close
	- [channel泄露](http://golang.design/go-questions/channel/leak/) [[channel]]
		- 泄漏的原因是 goroutine 操作 channel 后，处于发送或接收阻塞状态，而 channel 处于满或空的状态，一直得不到改变。同时，垃圾回收器也不会回收此类资源，进而导致 gouroutine 会一直处于等待队列中，不见天日。
		- 另外，程序运行过程中，对于一个 channel，如果没有任何 goroutine 引用了，gc 会对其进行回收操作，不会引起内存泄漏
	- ##### channel引用有哪些？ [#](https://golang.design/go-questions/channel/application/#%e5%81%9c%e6%ad%a2%e4%bf%a1%e5%8f%b7) [[channel]]
		- 停止信号
		- 任务定时 [#](https://golang.design/go-questions/channel/application/#%e4%bb%bb%e5%8a%a1%e5%ae%9a%e6%97%b6)
		- 解耦生产方和消费方 [#](https://golang.design/go-questions/channel/application/#%e8%a7%a3%e8%80%a6%e7%94%9f%e4%ba%a7%e6%96%b9%e5%92%8c%e6%b6%88%e8%b4%b9%e6%96%b9)
		- 控制并发数 [#](https://golang.design/go-questions/channel/application/#%e6%8e%a7%e5%88%b6%e5%b9%b6%e5%8f%91%e6%95%b0)
- ---
- ##### [[context]] [#](https://golang.design/go-questions/stdlib/context/what/)
  background-color:: blue
	- card-last-interval:: 4
	  card-repeats:: 2
	  card-ease-factor:: 2.22
	  card-next-schedule:: 2023-07-25T05:08:12.771Z
	  card-last-reviewed:: 2023-07-21T05:08:12.771Z
	  card-last-score:: 3
	  > 准确说它是 goroutine 的上下文，包含 goroutine 的运行状态、环境、现场等信息
	  context 主要用来在 goroutine 之间传递上下文信息，包括：[[$red]]==取消信号、超时时间、截止时间、k-v== 等 #card
	- context 包就是为了解决上面所说的这些问题而开发的：在 一组 goroutine 之间传递共享的值、取消信号、deadline……
	- ##### 传递共享的数据 [#](https://golang.design/go-questions/stdlib/context/why/#%e4%bc%a0%e9%80%92%e5%85%b1%e4%ba%ab%e7%9a%84%e6%95%b0%e6%8d%ae)
	- ##### 取消 goroutine[#](https://golang.design/go-questions/stdlib/context/why/#%e5%8f%96%e6%b6%88-goroutine)
		- ```cpp
		  func Perform(ctx context.Context) {
		      for {
		          calculatePos()
		          sendResult()
		  
		          select {
		          case <-ctx.Done():
		              // 被取消，直接返回
		              return
		          case <-time.After(time.Second):
		              // block 1 秒钟 
		          }
		      }
		  }
		  ```
	- [contex value获取过程](http://golang.design/go-questions/stdlib/context/find-value/)
	- [contex是如何被取消的](http://golang.design/go-questions/stdlib/context/cancel/) #card
	  card-last-interval:: 8.32
	  card-repeats:: 3
	  card-ease-factor:: 2.08
	  card-next-schedule:: 2024-05-05T23:05:48.761Z
	  card-last-reviewed:: 2024-04-27T16:05:48.761Z
	  card-last-score:: 3
		- Context[#](https://golang.design/go-questions/stdlib/context/cancel/#context)
			- Context比较简单:: 就实现了 Err()  Done()-是一个只读的`chan struct{}`， 被关闭时候会读取到0
		- canceler [#](https://golang.design/go-questions/stdlib/context/cancel/#canceler)
			- 源码中有两个类型实现了 canceler 接口：`*cancelCtx` 和 `*timerCtx`。注意是加了 `*` 号的，是这两个结构体的指针实现了 canceler 接口 [理解](https://blog.csdn.net/weixin_42216109/article/details/123694275)
			-
		- cancelCtx[#](https://golang.design/go-questions/stdlib/context/cancel/#cancelctx)
			- 总体来看，`cancel()` 方法的功能就是关闭 channel：c.done；递归地取消它的所有子节点；从父节点从删除自己。达到的效果是通过关闭 channel，将取消信号传递给了它的所有子节点。goroutine 接收到取消信号的方式就是 select 语句中的`读 c.done` 被选中
			- cancel的时候必须 指定err，实际上就是告诉下面的子context为什么cancel了，如果不传painc
			- cancel的时候实际上就是如果done 是nil，就make一个，不是就close：： close的channel读取默认值
			- 还注意到一点，调用子节点 cancel 方法的时候，传入的第一个参数 `removeFromParent` 是 false。
			- 两个问题需要回答：1. 什么时候会传 true？2. 为什么有时传 true，有时传 false？
			- 当 `removeFromParent` 为 true 时，会将当前节点的 context 从父节点 context 中删除：
				- 什么时候会传 true 呢？答案是调用 `WithCancel()` 方法的时候，也就是新创建一个可取消的 context
				   节点时，返回的 cancelFunc 函数会传入 true。这样做的结果是：当调用返回的 cancelFunc 时，会将这个 context 
				  从它的父节点里“除名”，因为父节点可能有很多子节点，你自己取消了，所以我要和你断绝关系，对其他人没影响
		- timerCtx[#](https://golang.design/go-questions/stdlib/context/cancel/#timerctx)
- ##### 反射
  background-color:: blue
	- {{embed [[golang反射]]}}
- ##### unsafe指针  [#](https://golang.design/go-questions/stdlib/unsafe/pointers/)
  background-color:: blue
	- {{embed ((640d674f-4808-4ce6-ac6e-35c69c46eb31))}}
	- golang指针相比c限制较多::  不允许计算、不同类型无法比较互换，不能互相赋值非同类型，
	- 如何实现by[te和slice之间的零拷贝?](http://golang.design/go-questions/stdlib/unsafe/zero-conv/)
- ##### 编译  [#](https://golang.design/go-questions/compile/escape/)
	- 逃逸分析:: 分析指针动态范围的方法称之为逃逸分析。通俗来讲，当一个对象的指针被多个方法或线程引用时，我们称这个指针发生了逃逸。
		- Go语言的[[逃逸分析]]是编译器执行静态代码分析后，对内存管理进行的优化和简化，[[$red]]==它可以决定一个变量是分配到堆还栈上==。
		  id:: 641027d6-0404-4730-a70f-1b1e3f21004b
		- Go语言逃逸分析最基本的原则是：如果一个函数返回对一个变量的引用，那么它就会发生逃逸。Go中的变量只有在编译器可以证明在函数返回后不会再被引用的，才分配到栈上，
	- 编译过程
	- go编译相关命令
		-
- ##### 调度器  [#有比较多深入分析-待看](https://golang.design/go-questions/sched/goroutine-vs-thread/)
	- {{embed [[GMP调度器]]}}
-
- ##### GC[[垃圾回收]]
  background-color:: blue
  id:: 641027d6-eca2-4e26-a264-3403c6768eb0
	- #### 1.基础
		- ##### 2. 根对象到底是什么？[#](https://golang.design/go-questions/memgc/principal/#2-%e6%a0%b9%e5%af%b9%e8%b1%a1%e5%88%b0%e5%ba%95%e6%98%af%e4%bb%80%e4%b9%88) 
		  根对象::  在垃圾回收的术语中又叫做根集合，它是垃圾回收器在标记过程时最先检查的对象，包括：
			- 全局变量：程序在编译期就能确定的那些存在于程序整个生命周期的变量。
			- 执行栈：每个 goroutine 都包含自己的执行栈，这些执行栈上包含[[$red]]==栈上的变量==及[[$red]]==指向分配的堆内存区块的指针==。
			- 寄存器：寄存器的值可能表示一个指针，参与计算的这些指针可能指向某些赋值器分配的堆内存区块。
		- ##### 3. 常见的 GC 实现方式有哪些？Go 语言的 GC 使用的是什么？[#](https://golang.design/go-questions/memgc/principal/#3-%e5%b8%b8%e8%a7%81%e7%9a%84-gc-%e5%ae%9e%e7%8e%b0%e6%96%b9%e5%bc%8f%e6%9c%89%e5%93%aa%e4%ba%9bgo-%e8%af%ad%e8%a8%80%e7%9a%84-gc-%e4%bd%bf%e7%94%a8%e7%9a%84%e6%98%af%e4%bb%80%e4%b9%88)
		  算法:: 其存在形式可以归结为追踪（Tracing）和引用计数（Reference Counting）这两种形式的混合运用,
			- [[追踪式GC]] 
			  特点:: Go 的 GC 目前使用的是==无分代==（对象没有代际之分）、==不整理==（回收过程中不对对象进行移动与整理）、==并发==（与用户代码并发执行）的三色标记清扫算法、
			  id:: 641027d6-a4b0-49ec-a951-a4486cbfce0c
			  > 从根对象出发，根据对象之间的引用信息，一步步推进直到扫描完毕==整个堆==并确定需要保留的对象，从而回收所有可回收的对象。Go、 Java、V8 对 JavaScript 的实现等均为追踪式 GC
			- [[引用计数式GC]]
			  > 每个对象自身包含一个被引用的计数器，当计数器归零时自动得到回收。因为此方法缺陷较多，在追求高性能时通常不被应用。Python、Objective-C 等均为引用计数式 GC，  ==快简单、但每次要计算引用数性能差，需要额外内存记录引用数==
		- ##### 4. 三色标记法是什么？[#](https://golang.design/go-questions/memgc/principal/#4-%e4%b8%89%e8%89%b2%e6%a0%87%e8%ae%b0%e6%b3%95%e6%98%af%e4%bb%80%e4%b9%88)
		  关键:: 理解对象的**三色抽象**以及**波面(wavefront)推进**这两个概念。三色抽象只是一种描述追踪式回收器的方法,
			- 白色::  要被回收的对象，不可达的
			- 灰色:: 中间带的，可能被回收，也可能可达对象
			- 黑色:: 就是可达的，不可回收的
		- ##### 5. STW 是什么意思？ [#](https://golang.design/go-questions/memgc/principal/#5-stw-%e6%98%af%e4%bb%80%e4%b9%88%e6%84%8f%e6%80%9d)
			- 定义:: stop the world，开始gc的时候会停止所有用户代码，导致停止
		- ##### 6. 如何观察 Go GC？[#](https://golang.design/go-questions/memgc/principal/#6-%e5%a6%82%e4%bd%95%e8%a7%82%e5%af%9f-go-gc)
			- > 方式1：  `GODEBUG=gctrace=1`   [#](https://golang.design/go-questions/memgc/principal/#%e6%96%b9%e5%bc%8f1godebuggctrace1)
			- > 方式2..4: go tool、  runtime.memstate、 gcstate信息
				- > [[$red]]==wall clock== 是指开始执行到完成所经历的实际时间，包括其他程序和本程序所消耗的时间；
				  [[$red]]==cpu time== 是指特定程序使用 CPU 的时间
					- wall clock < cpu time:  {{cloze 充分利用多核}}
					- wall clock ≈ cpu time: [[#red]]==未并行执行==
					- wall clock > cpu time: [[#green]]==多核优势不明显==
		- ##### 7. 有了 GC，为什么还会发生内存泄露？[#](https://golang.design/go-questions/memgc/principal/#7-%e6%9c%89%e4%ba%86-gc%e4%b8%ba%e4%bb%80%e4%b9%88%e8%bf%98%e4%bc%9a%e5%8f%91%e7%94%9f%e5%86%85%e5%ad%98%e6%b3%84%e9%9c%b2)
		  严谨的话来说应该::  预期的能很快被释放的内存由于[[$red]]==附着在了长期存活的内存上、或生命期意外地被延长==，导致预计能够立即回收的内存而长时间得不到回收
			- a. 比如把局部变量附着到了全局的变量cache上去了，无法释放
			- b. goroutine leak
				- 例:: 一个 goroutine 尝试向一个没有接收方的无缓冲 channel 发送消息，则该 goroutine 会被永久的休眠，整个 goroutine 及其执行栈都得不到释放
		- ##### 8. 并发标记清除法的难点是什么？ [#](https://golang.design/go-questions/memgc/principal/#8-%e5%b9%b6%e5%8f%91%e6%a0%87%e8%ae%b0%e6%b8%85%e9%99%a4%e6%b3%95%e7%9a%84%e9%9a%be%e7%82%b9%e6%98%af%e4%bb%80%e4%b9%88)
		  简::  如何保证标记与清除的准确性
		- ##### 9. 什么是写屏障、混合写屏障，如何实现？[#](https://golang.design/go-questions/memgc/principal/#9-%e4%bb%80%e4%b9%88%e6%98%af%e5%86%99%e5%b1%8f%e9%9a%9c%e6%b7%b7%e5%90%88%e5%86%99%e5%b1%8f%e9%9a%9c%e5%a6%82%e4%bd%95%e5%ae%9e%e7%8e%b0)
		- ```apl
		  垃圾回收机制是Go一大特(nan)色(dian)。Go1.3采用标记清除法， Go1.5采用三色标记法，Go1.8采用三色标记法+混合写屏障。
		  
		  标记清除法
		    分为两个阶段：标记和清除
		    标记阶段：从根对象出发寻找并标记所有存活的对象。
		    清除阶段：遍历堆中的对象，回收未标记的对象，并加入空闲链表。
		  
		  缺点是需要暂停程序STW。
		  
		  三色标记法：
		    将对象标记为白色，灰色或黑色。
		    白色：不确定对象（默认色）；黑色：存活对象。灰色：存活对象，子对象待处理。
		  
		    标记开始时，先将所有对象加入白色集合（需要STW）。首先将根对象标记为灰色，然后将一个对象从灰色集合取出，遍历其子对象，放入灰色集合。同时将取出的对象放入黑色集合，直到灰色集合为空。最后的白色集合对象就是需要清理的对象。
		    这种方法有一个缺陷，如果对象的引用被用户修改了，那么之前的标记就无效了。因此Go采用了写屏障技术，当对象新增或者更新会将其着色为灰色。
		  
		  一次完整的GC分为四个阶段：
		      准备标记（需要STW），开启写屏障。开始标记标记结束（STW），关闭写屏障清理（并发）
		  基于插入写屏障和删除写屏障在结束时需要STW来重新扫描栈，带来性能瓶颈。混合写屏障分为以下四步：
		      GC开始时，将栈上的全部对象标记为黑色（不需要二次扫描，无需STW）；GC期间，任何栈上创建的新对象均为黑色被删除引用的对象标记为灰色被添加引用的对象标记为灰色
		      
		  总而言之就是确保黑色对象不能引用白色对象，这个改进直接使得GC时间从 2s降低到2us。
		  ```
	- #### 2.GC 的实现细节 [#](https://golang.design/go-questions/memgc/impl/#gc-%e7%9a%84%e5%ae%9e%e7%8e%b0%e7%bb%86%e8%8a%82)
		- ##### 10. Go 语言中 GC 的流程是什么？ [#](https://golang.design/go-questions/memgc/impl/#10-go-%e8%af%ad%e8%a8%80%e4%b8%ad-gc-%e7%9a%84%e6%b5%81%e7%a8%8b%e6%98%af%e4%bb%80%e4%b9%88)
		- ##### 11. 触发 GC 的时机是什么？ [#](https://golang.design/go-questions/memgc/impl/#11-%e8%a7%a6%e5%8f%91-gc-%e7%9a%84%e6%97%b6%e6%9c%ba%e6%98%af%e4%bb%80%e4%b9%88)
			- **主动触发**
			- **被动触发**，分为两种方式：
				- 使用系统监控，当超过两分钟没有产生任何 GC 时，强制触发 GC。
				- 使用步调（Pacing）算法，其核心思想是控制内存增长的比例。
		- ##### 12. 如果内存分配速度超过了标记清除的速度怎么办？ [#](https://golang.design/go-questions/memgc/impl/#12-%e5%a6%82%e6%9e%9c%e5%86%85%e5%ad%98%e5%88%86%e9%85%8d%e9%80%9f%e5%ba%a6%e8%b6%85%e8%bf%87%e4%ba%86%e6%a0%87%e8%ae%b0%e6%b8%85%e9%99%a4%e7%9a%84%e9%80%9f%e5%ba%a6%e6%80%8e%e4%b9%88%e5%8a%9e)
			- > 简单说就是当gc发生时，会标记，让内存分配慢点，达到回收和分配平衡
			- 当 GC 触发后，会首先进入并发标记的阶段。并发标记会设置一个标志，并在 mallocgc 调用时进行检查。当存在新的内存分配时，会暂停分配内存过快的那些 goroutine
	- ##### 3.GC 的优化问题 [#](https://golang.design/go-questions/memgc/optimize/#gc-%e7%9a%84%e4%bc%98%e5%8c%96%e9%97%ae%e9%a2%98)
		- ##### 13. GC 关注的指标有哪些？[#](https://golang.design/go-questions/memgc/optimize/#13-gc-%e5%85%b3%e6%b3%a8%e7%9a%84%e6%8c%87%e6%a0%87%e6%9c%89%e5%93%aa%e4%ba%9b)
			- cpu利用率:: gc会影响多大        GC停顿时间: stw    gc停顿频率::   造成程序停顿频率
		- ##### 14. Go 的 GC 如何调优？ [#](https://golang.design/go-questions/memgc/optimize/#14-go-%e7%9a%84-gc-%e5%a6%82%e4%bd%95%e8%b0%83%e4%bc%98)
			- >  Go 的 GC 被设计为极致简洁，与较为成熟的 Java GC 的数十个可控参数相比，严格意义上来讲，Go 可供用户调整的参数只有 [[$red]]==GOGC 环境变量==
			- 一般其实不需要care这些问题:: 只有对执行延迟非常敏感才需要，gc的开销影响了性能；无非：尽量少申请内存，复用
				- ((63f859a9-3219-4740-897a-774254c56dd9))
			-
- ##### other question
	- 1.goroutine是什么，如何解释？ [[goroutine]]
	  id:: 64117957-6c5b-4fb1-b810-fb9cbefc8596
	- 2.rune理解。 int32别名，**用它来区分字符值和整数值**， [例子](https://learnku.com/articles/23411/the-difference-between-rune-and-byte-of-go)，实际上是字符串转unicode的码点占用4byte，比如中文截取那就会乱码，所以转成rune就可以正常获取
	-
	-