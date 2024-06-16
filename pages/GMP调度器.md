- [GMP分析-手撸goroutine pool](https://strikefreedom.top/high-performance-implementation-of-goroutine-pool)   [go-interview 调度](https://golang.design/go-questions/sched/goroutine-vs-thread/)
- id:: 641027d5-5b9f-46de-bd26-9429e54d96d4
  > [[goroutine]]它和 [[thread]] [[线程]]有什么区别？ #interview
	- 内存消耗、创建与销毀、切换。
		- [[goroutine]] 的栈内存消耗为 2 KB，会自动进行扩容。创建一个 thread 则需要消耗 1 MB 栈内存，而且还需要一个被称为 “a guard page” 的区域用于和其他 thread 的栈空间进行隔离
		- [[thread]] 创建和销毀都会有巨大的消耗，因为要和操作系统打交道，是内核级的； [[goroutine]]是[[用户级]]的、runtime管理
		- 当 [[thread]] 切换时，需要保存各种寄存器，以便将来恢复；而 goroutines 切换只需保存[[$red]]==三个寄存器==：Program Counter, Stack Pointer and BP。
	- [[线程]]和goroutine比主要开销大原因？
		- 堆内存大1M
		- 维护各种register信息
		- 线程的创建销毁需要系统调用，内核级
	- [[goroutine]] 是在 Golang 中执行并发任务的方式。它们仅存在于 Go 运行时的虚拟空间中而不存在于 OS 中，因此需要 Go调度器来管理它们的生命周期。请记住这一点很重要，对于所有[[$red]]==操作系统看到的都只有一个请求并运行多个线程的单个用户级进程==。goroutine 本身由 GoRuntimeScheduler 管理 [#](https://zhuanlan.zhihu.com/p/300613281)
	-
- #### 主流的[[线程模型]]型分三种: #interview
  query-table:: false
	- ==[[内核级线程模型]]==、==[[用户级线程]]==模型和==[[两级线程]]==模型（也称混合型线程模型），传统的[[协程]]库属于用户级线程模型； [[并发模型]]
	- {{embed [[线程模型]]}}
- > 什么[是scheduler?](https://golang.design/go-questions/sched/what-is/)  [#](https://golang.design/go-questions/sched/what-is/) #interview
	- [[$red]]==Go程序的执行由两层组成==：Go Program，Runtime，即[[$blue]]==用户程序和运行时==。它们之间通过函数调用来实现内存管理、channel 通信、goroutines 创建等功能
	- Go scheduler 可以说是 Go 运行时的一个最重要的部分了。[[$red]]==Runtime 维护所有的 goroutines，并通过 scheduler 来进行调度==。Goroutines 和 threads 是独立的，但是 goroutines 要依赖 threads 才能执行。
	- Go scheduler 是 Go runtime 的一部分，它内嵌在 Go 程序里，和 Go 程序一起运行；因此它运行在用户空间，在 kernel 的上一层
- #### Go scheduler 的核心思想是： #interview
  background-color:: blue
	- reuse threads；
	- 限制同时运行（不包含阻塞）的线程数为 N，N 等于 CPU 的核心数目；
	- 线程私有的 runqueues，并且可以从其他线程 stealing goroutine 来运行，线程阻塞后，可以将 runqueues 传递给其他线程。
	-
- #### go语言的[[G-P-M 模型]]   模型define: src/runtime/runtime2.go  调度::  src/runtime/pro.go #interview
  background-color:: blue
	- 早期是只有GM的，没有p，导致需要锁，每个m存储缓存，局部性差
	- goroutine 是一个独立的执行单元，OS 线程2M ，goroutine 动态， 初始 2KB，最大可达 1GB，且自己 Go Scheduler调度，还可自动回收；
	- G 并不直接绑定 OS 线程运行，而是由 Goroutine Scheduler 中的 P - Logical Processor （逻辑处理器）来作为两者的『中介』，P 可以看作是一个抽象的资源或者一个上下文，一个 P 绑定一个 OS 线程，在 golang 的实现里把 OS 线程抽象成一个数据结构：M，G 实际上是由 M 通过 P 来进行调度运行的，但是在 G 的层面来看，P 提供了 G 运行所需的一切资源和环境，因此在 G 看来 P 就是运行它的 “CPU”，由 G、P、M 这三种由 Go 抽象出来的实现，最终形成了 Go 调度器的基本结构：
	- ==G==:
		- 表Goroutine，Goroutine 对应一个 G 结构，G 存储 Goroutine 的**运行堆栈、状态以及任务函数**，可重用。G 并非执行体，每个 G 需要绑定到 P 才能被调度执行。
	- ==P==:  - _Logical Processor_ （逻辑处理器）
		- Processor，表示逻辑处理器， 对 G 来说，P 相当于 CPU 核，G 只有绑定到 P(在 P 的 local runq 中)才能被调度。对 M 来说，P 提供了相关的执行环境(Context)，如内存分配状态(mcache)，任务队列(G)等，P 的数量决定了系统内最大可并行的 G 的数量（前提：物理 CPU 核数 >= P 的数量），P 的数量由用户设置的 GOMAXPROCS 决定，但是不论 GOMAXPROCS 设置为多大，P 的数量最大为 256。
	- ==M==:
		- Machine，OS 线程抽象，代表着真正执行计算的资源，在绑定有效的 P 后，进入 schedule 循环；而 schedule 循环的机制大致是从 Global 队列、P 的 Local 队列以及 wait 队列中获取 G，切换到 G 的执行栈上并执行 G 的函数，调用 goexit 做清理工作并回到 M，如此反复。[[$red]]==M 并不保留 G 状态，这是 G 可以跨 M 调度的基础，M 的数量是不定的，由 Go Runtime 调整==，为了防止创建过多 OS 线程导致系统调度不过来，目前默认最大限制为 10000 个
	- Runtime 起始时会启动一些 G：垃圾回收的 G，执行调度的 G，运行用户代码的 G；并且会创建一个 M 用来开始 G 的运行。随着时间的推移，更多的 G 会被创建出来，更多的 M 也会被创建出来。
	- id:: 63bce30b-c976-4d15-aebd-a480f11f78ec
	  调度器work-stealing算法:: 避免了goroutine调度时使用锁
		- 每个 P 维护一个 G 的本地队列；
		  当一个 G 被创建出来，或者变为可执行状态时，就把他放到 P 的可执行队列中；
		  当一个 G 在 M 里执行结束后，P 会从队列中把该 G 取出；如果此时 P 的队列为空，即没有其他 G 可以执行， M 就随机选择另外一个 P，从其可执行的 G 队列中取走一半。
		- ![image.png](../assets/image_1673931158843_0.png){:height 450, :width 488}
	- ### [[G-P-M 模型]]调度 [gometry](https://strikefreedom.top/archives/high-performance-implementation-of-goroutine-pool)
		- 有个全局的runnable队列，create goroutine后丢入P的本地队列。为了run需要m需要绑定一个p，接着 m启动一个os线程，循环从p里取执行。当m执行完当前p，global也空，会去他的p里拿一般过来继续
		- goroutine会在有些阻塞情况下run另外一个
			- ==用户阻塞、唤醒==
				- 比如因为程序阻塞、或net io阻塞时；对应g会放入wait队列，m会跳过g执行下一个取调度。当被另外一个g2唤醒时，会到g2里跑
			- ==系统调用阻塞==
				- 系统调用阻塞时，会进入_Gsyscall状态，m也处于block状态，m可抢占`执行g的m会与p解绑，p尝试与其他idl的m绑定，继续执行另外的g`
				- 如果没其他idl的m，p中仍有g要执行，创建一个新的m跑
		-
		- goroutine调度时机有哪些？ [#](http://golang.design/go-questions/sched/when/)
			- user触发 go fun() {}
			- GC触发
			- 系统调用，系统调用会阻塞用户，m会空闲就可以调度另外一个
			- 内存访问解锁，阻塞了都会调度走
		- 工作窃取:: 其实就是p发现自己这里没事可做了，从其他p拿过来
		- 调度[过程操作](https://golang.design/go-questions/sched/gpm/)
			- 先看 G，取 goroutine 的首字母，主要保存 goroutine 的一些状态信息以及 CPU 的一些寄存器的值，例如 IP 寄存器，以便在轮到本 goroutine 执行时，CPU 知道要从哪一条指令处开始执行。
			- 当 goroutine 被调离 CPU 时，调度器负责把 CPU 寄存器的值保存在 g 对象的成员变量之中。
			- 当 goroutine 被调度起来运行时，调度器又负责把 g 对象的成员变量所保存的[[#blue]]==寄存器值恢复到 CPU 的寄存器==。
		-
- [[G-P-M 模型]] 缺陷 #interview
	- 1.太多的g，仍然可能导致gc很多，影响性能
	- 2.gc也是goroutine，那如果内存紧张，可能oom；无线的等待，p和g的队列累积，gc也增加
- [FAQ-GMP](https://zhuanlan.zhihu.com/p/471490292) #card
  card-last-interval:: 4
  card-repeats:: 1
  card-ease-factor:: 2.6
  card-next-schedule:: 2024-01-19T11:41:03.320Z
  card-last-reviewed:: 2024-01-15T11:41:03.321Z
  card-last-score:: 5
	- Go什么时候发生阻塞？阻塞时，调度器会怎么做。
	- go如何进行调度的。GMP中状态流转、GMP状态、P能去掉？
	- 有一个G一直占用资源怎么办？什么是work stealing算法？
-
-