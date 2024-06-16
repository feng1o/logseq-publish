- {{renderer :tocgen2, [[]], auto, 1}}
- ==summary-tcp-ip==
	- [interview-question-tcp-ip](https://static.kancloud.cn/qq5202056/gomianshi/2657252) #interview  <a class="alg-hard"></a>
- [[MTU]] 作用，[怎么确定MTU的](https://info.support.huawei.com/info-finder/encyclopedia/zh/MTU.html) #interview #card
  card-last-interval:: 4.28
  card-repeats:: 1
  card-ease-factor:: 2.36
  card-next-schedule:: 2023-07-25T10:55:02.083Z
  card-last-reviewed:: 2023-07-21T04:55:02.084Z
  card-last-score:: 3
	- 通过设置MTU来调节网络上数据包的大小，让不同的网络找到最适宜的MTU从而提高转发效率
	- [[数据链路层]] 对数据帧长度的限制。不同链路介质类型的网络有不同的默认MTU值
	- 动态探测Path [[MTU]]值的技术
		- 源节点假设Path MTU就是其出接口的[[MTU]]，发出一个[[$red]]==试探性==的报文，并设置改报文不允许被分片。当转发路径上存在一个小于当前假设的Path MTU时，转发设备就会向源节点发送回应报文，并且携带自己的MTU值，此后源节点将Path MTU的假设值更改为新收到的MTU值继续发送报文。如此反复，直到报文到达目的地之后，源节点就能知道到达目的地的Path MTU了。
		- 但现实是很多不行，因为有些不遵守rfc协议，有些吧icmp应答报文隔离； 那就继续分片重组
	-
- [coolshell-tcpip v1-v2 + tcp常规问题](https://coolshell.cn/articles/11564.html) #interview
	- [[TCP]]在网络OSI的七层模型中的第四层——Transport层，IP在第三层——Network层，ARP在第二层——Data Link层，在第二层上的数据，我们叫Frame，在第三层上的数据叫Packet，第四层的数据叫Segment
	- ==四个概念:==
		- **Sequence Number**是包的序号，**用来解决网络包乱序（reordering）问题。**
		- **Acknowledgement Number**就是ACK——用于确认收到，**用来解决不丢包的问题**。
		- **Window又叫Advertised-Window**，也就是著名的滑动窗口（Sliding Window），**用于解决流控的**。
		- **TCP Flag** ，也就是包的类型，**主要是用于操控TCP的状态机的**。
	- [[SYN Flood攻击]] <span class="subw8">给服务器发了一个SYN后，就下线了，于是服务器需要默认等63s才会断开连接</span>
		- solve:  <span class="subw8 blue">tcp_synack_retries 可以用他来减少重试次数；第二个是：tcp_max_syn_backlog，可以增大SYN连接数；第三个是：tcp_abort_on_overflow 处理不过来干脆就直接拒绝连接了</span>
	- [[TCP重传机制]]
		- [[超时重传]] 比如某个seq没收到，不回ack一直等，发送端一直收不到就重试( 重发seq或后面所有的)
		- [[快速重传]] 不以时间驱动，用数据驱动。  比如发1,2,3,4 收到124，这时候就一直回ack=3，发送断面收到3个2的ack就知道2丢了，马上重发2
		- [[快速重传]]后，直接进行[[拥塞避免]]算法，不进入[[慢启动]]，就是[[快速恢复]]
	- [[拥塞避免]][[算法]]和[[慢启动]][[算法]]是两个[[目的]]不同、独立的[[算法]]；当拥塞发生时，希望进入网络的数据变慢，于是可以启动[[慢启动]]，实际上俩一起实现的
		- [[拥塞避免]]和[[慢启动]]需要对每个连接维护两个变量，一个是[[拥塞窗口cwnd]]一个是[[慢启动门限]]sshtresh，这样算法过程如下:
			- 1.一个给定的cnn，初始化cnwd=1个报文段,ssthresh = 65535
			- 2.tcp输出不能超过cnwd和接收方的[[通告窗口]]，[[拥塞避免]]是[[$red]]==发送方==使用的[[流量控制]]，[[通告窗口]]则是[[$red]]==接收方==进行的[[流量控制]]。[[$red]]==前者是发送方感受到的网络拥塞估计，后者是接收方可用缓存大小==
			- 3.当[[$red]]==拥塞发生时==(超时或者get 重复的ack),ssthresh被设置为当前窗口的一半(cwnd和接收方通告窗口大小最小的，最少2个报文段). 如果[[#blue]]==超时引起来拥塞==，则cnwd会设置为1，启动[[慢启动]]  -> [[快速恢复]]呢？
			- 4.当新的被对方ack后，就增加cnwd，增加的方法依赖于是否进行[[慢启动]]或[[拥塞避免]]。如果cnwd小于ssthresh，则进行[[慢启动]]，否则进行[[拥塞避免]]。慢启动一直持续回到当前拥塞发生是所处位置一半时候才停止，然后转为拥塞避免。
		- [[拥塞避免]][[算法]]要求每次收到一个确认ack是将cwnd加1/cnwd，与[[慢启动]]的指数加比起来是一种慢性增长。
- ##### FAQ
	- 1.
		- a.server收到sync发了sync-ack后未收到ACK:: 此时server会重试发送sync-ack， [[SYN Flood攻击]]
		- b.TIME_WAIT=2MSL:: 1.确保被动关闭的能收到ack，2.避免老的数据被新的cnn收到
		- c.TIM_WAIT的太多:: tcp_tw_recycle，reuse 可打开，但风险大。  尽量避免主动close，http-keepalive
	- 2.