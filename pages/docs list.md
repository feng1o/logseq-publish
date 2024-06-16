- ==im list==
  id:: 62330b3a-decf-4c61-bf4b-c9e73bc9f598
  collapsed:: true
	- 001.[AWS存储产品介绍 S3 EBS EC2](https://blog.51cto.com/tenderrain/1973883)
	  id:: 326744f3-4813-4ed7-a891-b2375551ef72
	- 002.[pingcap介绍云原生数据库设计思路](https://pingcap.com/blog-cn/new-ideas-for-designing-cloud-native-database/)
	- 003.[阿里管控介绍](https://blog.csdn.net/yunqiinsight/article/details/112553794)
	- 004.[lets build a-full-text search eginer](https://artem.krylysov.com/blog/2020/07/28/lets-build-a-full-text-search-engine/)
	  id:: 62359e0e-6bd3-4b68-9c97-61ee7824a77b
	- 005.[cache buffer](https://zhuanlan.zhihu.com/p/35277219)
	- DOING 006. [ali内核月报](http://mysql.taobao.org/monthly/)
	  :LOGBOOK:
	  CLOCK: [2022-08-23 Tue 11:42:39]
	  :END:
	- 007. ![美团2022-doc.pdf](../assets/美团2022-doc_1673593704091_0.pdf)
	- 008. ((6497b93b-d5c0-4fb4-ac24-409bfe003b77))
-
- ```
  buffer : 作为buffer cache的内存，是块设备的读写缓冲区，更靠近存储设备，或者直接就是disk的缓冲区。
  - cache: 作为page cache的内存, 文件系统的cache，是memory的缓冲区 。
  - Page cache实际上是针对文件系统的，是文件的缓存，在文件层面上的数据会缓存到page cache。
  文件的逻辑层需要映射到实际的物理磁盘，这种映射关系由文件系统来完成。
  当page cache的数据需要刷新时，page cache中的数据交给buffer cache，但是这种处理在2.6版本的内核之后就变的很简单了，没有真正意义上的cache操作
  ```