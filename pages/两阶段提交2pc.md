2pc包含:: 准备阶段，commit阶段

	- 在第二阶段::  协调者和参与者都挂了，是有可能数据不一致的
	- **2PC的缺陷** [参考](https://www.cnblogs.com/daixianjun/p/2pc-3pc.html) 
	  1、同步阻塞：最大的问题即同步阻塞，即：所有参与事务的逻辑均处于阻塞状态。只能等协调者的命令
	  2、单点：协调者存在单点问题，如果协调者出现故障，参与者将一直处于锁定状态。
	  3、脑裂：在阶段2中，如果只有部分参与者接收并执行了Commit请求，会导致节点数据不一致。
	  4、同时去获得锁（这个2pc提交），会不会产生死锁问题？
- 3pc包含:: [[三阶段提交]]就有CanCommit、PreCommit、DoCommit三个阶段
	- 2pc比如协调者挂了，备份协调者起来后，只能去询问参与者，如果参与者也挂了那只能等，其他的参与者也无法commit或rollback。
		- 1.能否去掉阻塞，使得在commit/abort前能回到初试状态
		- 2.档次决议，参与者不依赖其他参与者状态(2pc必须等，否则可能不一致)
	- canCommit:: 任何异常都终止
	- preCommit阶段2:: coordinator未收到宕机participant的precommit ACK，但因为之前已经收到了宕机participant的赞成反馈(不然也不会进入到阶段2)，coordinator进行commit；watchdog可以通过问询其他participant获得这些信息，过程同理；宕机的participant恢复后发现收到precommit或已经发出赞成vote，则自行commit该次事务
	- doCommit阶段3::  即便coordinator或watchdog未收到宕机participant的commit ACK，也结束该次事务；宕机的participant恢复后发现收到commit或者precommit，也将自行commit该次事务
	- 3pc比2pc多了一个can commit阶段，减少了不必要的资源浪费。因为2pc在第一阶段会占用资源，而3pc在这个阶段不占用资源，只是校验一下sql，如果不能执行，就直接返回，减少了资源占用。
	- 引入超时机制。对于协调者(Coordinator)和参与者(Cohort)都设置了超时机制（在2PC中，只有协调者拥有超时机制，即如果在一定时间内没有收到cohort的消息则默认失败）
	- PreCommit是一个缓冲，保证了在最后提交阶段之前各参与节点的状态是一致的
- [[Paxos]]
  2pc或者3pc均未能解决分布式一致性问题::  解决一致性问题，唯有Paxos，后续将单独总结。
-