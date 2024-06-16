- {{embed ((66152501-ba9b-4f11-b633-725c1254aa7f))}}
- [主从模式的 MySQL 集群的主要难点在于：如何让从节点能够拥有主节点的数据，即：如何配置主（Master）从（Slave）节点的复制与同步？](https://time.geekbang.org/column/article/41217)
	- 将部署 MySQL 集群的流程迁移到 Kubernetes 项目上，需要能够“容器化”地解决下面的“三座大山”：
	  id:: 661529d1-e394-4fa7-b0a0-e694d444f907
		- Master 节点和 Slave 节点需要有不同的配置文件（即：不同的 my.cnf）；
		- Master 节点和 Slave 节点需要能够传输备份信息文件；
		- 在 Slave 节点第一次启动之前，需要执行一些初始化 SQL 操作；
		-
		- 如果你的应用要求不同节点的镜像不一样，那就不能再使用 StatefulSet 了。对于这种情况，应该考虑我后面会讲解到的 Operator。
		-
	-
	-
	- 因为是通过一个statefulset来实现的 感觉太复杂了，master和slave做成两个statefulset就非常简单了 ？
		- 两个statefulset确实简单很多。而且先后顺序也容易控制。slave的statefulset再加上一个initContainer就行了，这个initContainer做ping操作：until
		   nslookup mysql-master; do echo waiting for mysql-master; sleep 1; done;
	- 这样的有状态应用有个约束，pod标识一旦确定，角色就确定了。但实际应用中，不能有这样的约束，主挂了，要有一个从升主。这就要求至少有选主机制，所有的配置文件也不能依赖id确定角色。
	  这怎么玩呢？operater吗？operater可以看成一个特定应用的sre保姆吗？
		- 1
	-