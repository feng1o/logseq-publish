- kafka工作原理及流程 #interview #card
  card-last-interval:: 9.28
  card-repeats:: 3
  card-ease-factor:: 2.32
  card-next-schedule:: 2024-01-06T19:48:33.296Z
  card-last-reviewed:: 2023-12-28T13:48:33.296Z
  card-last-score:: 5
	- [#](https://www.cnblogs.com/xuwc/p/14018494.html)   解耦、削峰填谷、异步
	- 具有高性能、持久化、多副本备份、横向扩展能力…
	- #### 消息队列通信的模式
		- [[点对点方式]] producer把消息丢进去后，consumer自己去轮询消费，一个queue就一个consumer，消费速度consumer可控，但是是否有消息需要consumer自己去查询，轮询
		- [[发布订阅方式]]  基于消息送的消息传送模型，改模型可以有多种不同的订阅者。生产者将消息放入消息队列后，队列会将消息推送给订阅过该类消息的消费者（类似微信公众号）。由于是消费者被动接收推送，所以无需感知消息队列是否有待消费的消息
	- 其架构图
		- ![](https://www.17coding.info/cdn/WeChat%20Screenshot_20190325215237.png){:height 410, :width 592}
			- **Zookeeper**：kafka集群依赖zookeeper来保存集群的的元信息，来保证系统的可用性。
	- ##### kafka工作流程分析 #card #interview
	  card-last-interval:: 4
	  card-repeats:: 2
	  card-ease-factor:: 2.22
	  card-next-schedule:: 2024-01-27T14:22:12.528Z
	  card-last-reviewed:: 2024-01-23T14:22:12.529Z
	  card-last-score:: 3
		- > 发送数据
			- producer写入数据到master，follower主动去master同步数据
		- 那producer在向kafka写入消息的时候，怎么保证消息不丢失呢？  通过ACK应答机制
		- > 保存数据
			- topic都可以分为一个或多个partition，如果你觉得topic比较抽象，那partition就是比较具体的东西了！[[#green]]==Partition在服务器上的表现形式就是一个一个的文件夹==，每个partition的文件夹下面会有多组segment文件，每组segment文件又包含.index文件、.log文件、.timeindex文件（早期版本中没有）三个文件，
			   log文件就实际是存储message的地方，而index和timeindex文件为索引文件，用于检索消息
			- ![image.png](../assets/image_1679041732937_0.png){:height 136, :width 151}
			- 如上图，这个partition有三组segment文件，每个log文件的大小是一样的，但是存储的message数量是不一定相等的（每条的message大小不一致）。文件的命名是以该segment最小offset来命名的，如000.index存储offset为0~368795的消息，kafka就是利用[[$red]]==分段+索引的方式来解决查找效率==的问题。
		- > 消费数据
			- 消费者在拉取消息的时候也是**找leader**去拉取
			- partition划分为多组segment，每个segment又包含.log、.index、.timeindex文件，存放的每条message包含offset、消息大小、消息体……我们多次提到segment和offset，查找消息的时候是怎么利用segment+offset配合查找的呢？假如现在需要查找一个offset为368801的message是什么样的过程呢？
			- 那每个消费者又是怎么记录自己消费的位置呢？在早期的版本中，消费者将消费到的offset维护zookeeper中，consumer每间隔一段时间上报一次，这里容易导致重复消费，且性能不好！在新的版本中消费者消费到的offset已经直接维护在kafk集群的__consumer_offsets这个topic中！
			-
	-