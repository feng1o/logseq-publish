title:: constant hash/一致性哈希

- [[一致性hash]] #card
  card-last-score:: 3
  card-repeats:: 2
  card-next-schedule:: 2023-07-25T05:08:07.071Z
  card-last-interval:: 4
  card-ease-factor:: 2.22
  card-last-reviewed:: 2023-07-21T05:08:07.071Z
	- [[hash算法]]也会面临[[容错性]]和[[扩展性]]的问题。[[#green]]==[[容错性]]是指当系统中的某个服务出现问题时，不能影响其他系统==。[[扩展性]]是指当加入新的服务器后，整个系统能正确高效运行。
	- 一个设计良好的分布式哈希方案应该具有良好的[[单调性]]，即服务节点的变更不会造成大量的哈希重定位
	- [[一致性哈希]]定义：
		- 是一种特殊的哈希算法，在移除或者添加一个服务器时，==能够尽可能小地改变==已存在的服务请求与处理请求服务器之间的映射关系  --  [[$sub8]]==加服务器-服务指向的server可能变了==
		- 一致性哈希解决了简单哈希算法在分布式[哈希表](https://link.segmentfault.com/?enc=8SLNH%2BJkz1wSUKDQoMpUHQ%3D%3D.d6lGfewjMMLemIFvUa01RtDhzMFVr3f3KDOee9wh%2BKofqOsfRFAUjbNFSu8hZ6mQSLJllSWS62WHskJ0a0tkhdU4zmtmnEgyaQYtUxL2FDE%3D)（Distributed Hash Table，DHT）中存在的==动态伸缩==等问题；
	- [[一致性哈希]]解决问题：[[容错性]]
		- 比如有4个服务器，取模%4，那其中一个异常，加一个，或者去一个取模后映射都变了，有[[雪崩]]问题
		- 一致性hash是**对固定值2^32取模**
	- [[一致性哈希]]原理：
		- 1. hash 环
		  2. 映射服务到环 %2^32，这样一定是有个点的，如果不存在就顺时针取  [[容错性]] 
		  3. 比如加了一个或者宕了一个，只影响临近的扩展
		  4. 偏斜和rebalnce问题 ---  虚拟node,把存量node虚拟几个平均分配过去   
		  5. 前面部分都是讲述到Redis节点较多和节点分布较为均衡的情况，如果节点较少就会出现节点分布不均衡造成[[数据倾斜]]问题
-
-
-