- <a href=https://github.com/apache/incubator-brpc/blob/master/README_cn.md class=perfect>brpc-</a>
  id:: 638d6974-9d85-4e61-8f01-33cb1f1a29f6
- [[线程模型]] [brpc-doc](https://github.com/apache/brpc/blob/master/docs/cn/threading_overview.md#%E5%8D%95%E7%BA%BF%E7%A8%8Breactor)
  id:: 63bce30c-cce0-43de-b0f8-cded374999ea
	- 连接独占线程或进程
		- 在这个模型中，线程/进程处理来自绑定连接的消息，在连接断开前不退也不做其他事情。当连接数逐渐增多时，线程/进程占用的资源和上下文切换成本会越来越大，性能很差，这就是C10K问题的来源。这种方法常见于早期的web server，现在很少使用。
		  id:: 63bce30c-029e-4b30-95dc-b69d16c1bd70
	- [[单线程reactor]]
		- 以[libevent](http://libevent.org/), [libev](http://software.schmorp.de/pkg/libev.html)等event-loop库为典型。这个模型一般由一个event dispatcher等待各类事件，待事件发生后**原地**调用对应的event handler，全部调用完后等待更多事件，故为"loop"
	- [[N:1线程库]]
		- 又称为[Fiber](http://en.wikipedia.org/wiki/Fiber_(computer_science))，以[GNU Pth](http://www.gnu.org/software/pth/pth-manual.html), [StateThreads](http://state-threads.sourceforge.net/index.html)等为典型，一般是把N个用户线程映射入一个系统线程。同时只运行一个用户线程，调用阻塞函数时才会切换至其他用户线程。N:1线程库与单线程reactor在能力上等价，但事件回调被替换为了上下文(栈,寄存器,signals)，运行回调变成了跳转至上下文。和event
		   loop库一样，单个N:1线程库无法充分发挥多核性能，只适合一些特定的程序。
	- [[brpc-im-concept]]
		- bthread：类似Go语言中Goroutine的M:N的用户级线程库。可以极为方便地实现并行调度。请求处理的网络模型可以不再是一个请求在一个线程中处理的传统模式。
	- [[多线程reactor]]
		- 以[boost::asio](http://www.boost.org/doc/libs/1_56_0/doc/html/boost_asio.html)为典型。一般由一个或多个线程分别运行event dispatcher，待事件发生后把event handler交给一个worker线程执行。 这个模型是单线程reactor的自然扩展，可以利用多核
	- [[M:N线程库]]
		- 即把M个用户线程映射入N个系统线程。M:N线程库可以决定一段代码何时开始在哪运行，并何时结束，相比多线程reactor在调度上具备更多的灵活度。但实现全功能的M:N线程库是困难的
- #### 优势
	- 友好的interface::  [jump](https://github.com/apache/incubator-brpc/blob/master/docs/cn/overview.md#%E6%9B%B4%E5%8F%8B%E5%A5%BD%E7%9A%84%E6%8E%A5%E5%8F%A3) 只有三个(主要的)用户类: [Server](https://github.com/brpc/brpc/blob/master/src/brpc/server.h), [Channel](https://github.com/brpc/brpc/blob/master/src/brpc/channel.h), [Controller](https://github.com/brpc/brpc/blob/master/src/brpc/controller.h), 分别对应server端，client端，参数集合.
	- 可靠:: 可html看server状态，profile分析