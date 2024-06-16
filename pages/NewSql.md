- [new在何处？墨天轮](https://www.modb.pro/db/49527)
- [Tidb云原生数据库设计新思路](https://pingcap.com/zh/blog/new-ideas-for-designing-cloud-native-database) <span class="alg-4stars"><a href=https://zhuanlan.zhihu.com/p/464135327>---->参考2</a></span>
	- 数据库构架设计中主要有[[Shared Everthting]]、[[Shared Nothing]]、和[[Shared Disk]]：
		- [[Shared Everything]]指单个主机独立支配CPU、内存、磁盘等硬件资源，其优势是架构简单，搭建方便。但该种架构的缺陷是数据并行处理能力较差，扩展性较低。Shared Everything的典型代表的产品为SQLserver。
		- [[Shared Disk]]: 该种架构的典型代表为DB2 pureScale和Oracle Rac。这种共享架构具备一定的扩展能力，可通过节点的增加来提升数据并行处理能力。但当存储器接口使用饱和时，磁盘IO成为了系统资源瓶颈，节点的扩充并不能提升系统性能。
- [[Aurora]]
- [[Query Optimization in Microsoft SQL Server PDW]]
- [[The Snowflake Elastic Data Warehouse]]
- [[MPP DB]]
- [[NOSQL]] : 驱动因素： 比关系型扩展性，大数据集，高吞吐； 受挫于关系模型的限制性，渴望一种更具多动态性与表现力的数据模型；特殊查询
  Sharding 或者分库分表，NoSQL 也好，都面临着一个业务的侵入性问题，如果你的业务是重度依赖 SQL，那么用这两种方案都是很不舒适的。
  于是一些技术比较前沿的公司就在思考，能不能结合传统数据库的优点，比如 SQL 表达力，事务一致性等特性，但是又跟 NoSQL 时代好的特性，
  比如扩展性能够相结合发展出一种新的、可扩展的，但是用起来又像单机数据库一样方便的系统
-
- [[Shared Disk]]顾名思义，数据存储在同一位置，大家享用同样的资源。这种架构很容易在多用户访问的情况下导致系统崩溃，同时也难以满足高频读写、数据复制与迁移等需求。Oracle Exadata采用了这种传统的数据仓库架构，几乎在延展性和并发性上都落后于时代的发展。
  [[Shared Nothing]]是近年来更主流的一种做法。系统通过优化规则将资源分摊到各个节点，而每个节点不共享任何数据。这样一来，数据的处理过程就不存在争抢资源的情况，从而提供更有效率的延展性和并发性。像Netezza，Teradata，以及Redshift都采用了这样的架构，这也是Hadoop工作的基本原理。这种架构对于数据仓库应用来说有独特的问题，那就是节点资源没有将存储和计算分开。举个例子，当升级或者扩容发生时，系统需要重新分配节点资源，那么数据本身就会面临大量的迁移。这样的操作不仅费时费力费钱，也会大概率降低甚至暂停数据的查询功能，给终端用户造成使用上的影响。
- [[ES]]