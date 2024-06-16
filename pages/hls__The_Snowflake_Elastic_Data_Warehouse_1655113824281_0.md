file-path:: ../assets/The_Snowflake_Elastic_Data_Warehouse_1655113824281_0.pdf
file:: [The_Snowflake_Elastic_Data_Warehouse_1655113824281_0.pdf](../assets/The_Snowflake_Elastic_Data_Warehouse_1655113824281_0.pdf)
title:: hls__The_Snowflake_Elastic_Data_Warehouse_1655113824281_0

- Snowflake  is  amulti-tenant, transactional, secure, highly scalable and elas-tic system with full SQL support and built-in extensions forsemi-structured and schema-less data. 
  ls-type:: annotation
  hl-page:: 1
  id:: 62a70881-73f2-49a2-aede-a498ae336076
- describe  the  design  of  Snowflake  andits novel multi-cluster, ```shared-data architecture```.
  ls-type:: annotation
  hl-page:: 1
  id:: 62a708a1-2f4b-4262-9ffe-1ea01e263656
- key  features  of  Snowflake:  extremeelasticity and availability,  semi-structured and schema-lessdata, time travel, and end-to-end security  特性几个
  hl-page:: 1
  ls-type:: annotation
  id:: 62a708b9-5e74-4f0e-adad-87556858343f
-
- [translate](https://baijiahao.baidu.com/s?id=1695559116882110559&wfr=spider&for=pc&searchword=snowflack%E6%95%B0%E6%8D%AE%E5%BA%93%E7%89%B9)
  hl-page:: 1
  ls-type:: annotation
  id:: 62a7098f-14d9-4f74-8c9f-02f6f6feeec4
- 传统datawarehouse和大数据需求矛盾，所以要做snowflake
  hl-page:: 2
  ls-type:: annotation
  id:: 62a709b6-58d6-4593-9bc9-12de06a4296d
- key features:
	- SaaS
	- HTP  ACID
	- 结构化和半结构化数据
	- 弹性
	- 高可用
	- 持久化
	- 性价比高
	- 安全
-
- paper结构：
  hl-page:: 2
  ls-type:: annotation
  id:: 62a70abf-f159-4cf8-8704-43945053e412
	- session2  介绍背后的关键设计选择
	- session3 multi cluster和shared data架构介绍
	- session4 高可用，structured和semi 支持，安全等
	- session5  探讨相关工作
	- session6 未来
- 2.STORAGE VERSUS COMPUTE [example](https://fuzhe1989.github.io/2020/12/28/the-snowflake-elastic-data-warehouse/)
  hl-page:: 2
  ls-type:: annotation
  id:: 62a70b79-57b3-4ca6-a498-fb756ac3db77
	- share nothing: 在高性能数仓领域占据了主导地位，它的优点是规模与硬件便宜
	- 严重缺陷：计算与存储耦合
		- 异构工作负载： 硬件一般同，单load不同，io 和运算可能异构
		- 节点关系变化： 结点变更或故障，用户调整大小，需要大量shuffle，影响性能和可用性
		- 在线升级：
	- 内部环境可能以上问题能容忍；但云上环境复杂，结点关系改变，异常都很频繁；因为这样那样的原因，Snowflake做了存储和计算分离
	- An added benefit缓存了热数据，性能就接近甚至超过纯shared-nothing结构的性能。我们称这种新的体系结构为multi-cluster、 shared-data结构
	  hl-page:: 3
	  ls-type:: annotation
	  id:: 62a72535-5e52-43c0-92ea-33f8bbb24865
	-
- 3.ARCHITECTURE
  hl-page:: 3
  ls-type:: annotation
  id:: 62a7258e-659d-4b73-ba6e-f927923631c9
  background-color:: #787f97
	- Snowflake是一个面向服务的体系结构，由高度容错和独立可扩展的服务组
	- 3.1 存储层是AWS的S3.
		- AWS成熟的云平台，潜在客户大
		- S3和hdfs： S3虽然性能不太稳定，但它的易用性、高可用、强数据可靠性都是很难被替代的。因此Snowflake转而将精力花在了VW层的本地cache和弹性处理倾斜的技术上了
		- S3特点：
			- 单次访问延时高，CPU消耗大，尤其是使用HTTPS时
			- 文件只能覆盖写，不能追加；
			- GET支持只读部分文件；
			-
	- 3.2 虚拟数仓层（virtual warehouse）负责在vm集群上执行query。 每个EC2集群称为一个VW，对用户透明，用户选择时候和’T恤‘大小一样，XS,L,M ....
	- 云服务层，包括了管理VW、query、事务的服务，以及管理元数据的服务。管理虚拟仓库、查询、事务和围绕虚拟仓库的所有元数据的服务的集合，包含数据库元信息、访问控制信息、加密密钥、使用情况统计等
	-
		- 3.2.1 弹性与隔离
		  hl-page:: 4
		  ls-type:: annotation
		  id:: 62a727b2-3e50-405f-ba2a-2309d0ad1c86
			- VM是独立纯计算资源，可以随时销毁，拉起。vm之间不共享，单个query只在一个vm。
		- 3.2.2 本地缓存和文件窃取 -- 怎么保证已buffer的文件请求到对应vm的？ 什么是从窃取，从worker拿？
		  hl-page:: 4
		  ls-type:: annotation
		  id:: 62a72f1b-d4e2-4bae-a5ac-203f628dec14
			- worker节点在本地磁盘上缓存了一些表数据。缓存的文件是一些表文件，即节点过去访问过的S3对象。缓存头和文件的各个列，查询只下载它们需要的列
			- 云服务让后续对应请求到已缓存的节点；   提高命中率并避免VW的工作节点之间对单个表文件进行冗余缓存，查询优化器使用表文件名上的一致哈希将输入文件集分配给工作节点。因此，访问同一表文件的后续查询或并发查询将在同一工作节点上执行
			- 倾斜处理在云数据仓库中尤为重要。由于虚拟化问题或网络争用，某些节点的执行速度可能比其他节点慢得多 https://www.cnblogs.com/gered/p/14899327.html
		- 3.2.3 执行引擎
			- ...
-
	- 3.3 Cloud Services
	  hl-page:: 5
	  ls-type:: annotation
	  id:: 62a73353-2ff3-41cc-9c55-a2e5e67be14e
		- 多租户的。这一层的每个服务访问控制、查询优化器、事务管理器和其他服务都是长期存在的，并在许多用户之间共享；每个服务都被复制以实现高可用性和可扩展性，怎么做到的？
		- 3.3.1 查询管理和优化
		  hl-page:: 5
		  ls-type:: annotation
		  id:: 62a734f2-019a-4a5d-aa40-5f1d716dc845
			- 所有用户发起的query都会先经过云服务层，在这里做完早期处理：解析、对象解析、访问控制、plan优化；
			- 优化器完成后，生成的执行计划将分发给部分查询节点。当查询执行时，云服务会不断跟踪查询的状态，收集性能指标并检测节点故障。所有查询信息和统计信息都存储起来，进行审计和性能分析
		- 3.3.2 并发控制
		  hl-page:: 5
		  ls-type:: annotation
		  id:: 62a73511-a313-4b22-832e-6a6b23b25c82
			- 云服务层完成并发管理，通过snapshot Isolation SI隔离实现acid
			- 在SI下，事务的所有读取都会看到事务启动时数据库的一致快照。通常，SI是在多版本并发控制（MVCC）之上实现的，这意味着每个更改的数据库对象的一个副本都会保留一段时间。
			- MVCC是一个自然的选择，因为表文件是不可变的，这是使用S3存储的结果。只有将文件替换为包含更改的其他文件，才能对文件进行更改。因此，表上的写操作（insert、update、delete、merge）通过添加和删除相对于上一个表版本的整个文件来生成新版本的表。在元数据（在全局键值存储中）中跟踪文件的添加和删除，这种形式对属于特定表版本的文件集计算非常高效。
			-
		- 3.3.3 剪枝优化
		  hl-page:: 5
		  ls-type:: annotation
		  id:: 62a735e2-7907-40d4-a760-f7ec3b7ae4c1
			- 没有使用B+数模式，随机访问，没有index；S3不允许改
			- 另一种技术最近在大规模数据处理中得到了广泛应用：基于最小-最大值的修剪，也称为小物化聚合、区域映射和数据跳跃
			- 待定
		-
- 4.技术亮点
  hl-page:: 6
  ls-type:: annotation
  id:: 62a7364a-6a3b-4919-94a0-f2f0fce25289
	- SaaS服务
	- 持续可用性，故障恢复能力和在线升级能力
		- 能容忍单个或相关结点fail，S3是跨AZ存储副本，metadata也是跨az；
		- 云服务层的其余服务由多个AZ中的无状态节点组成，负载均衡器负责分发用户请求
	- 升级
		- 两个版本，控制两个虚拟仓库（vw），每个都有两个版本。负载平衡器将传入的请求定向到云服务的适当版本。一个版本的云服务只与一个匹配版本的通信
		- 两个版本的云服务共享相同的元数据存储。此外，不同版本的vw能够共享相同的工作节点及其各自的缓存。因此，升级后不需要重新填充缓存。整个过程对用户是透明的，没有停机或性能下降
- ls-type:: annotation
  hl-page:: 6
  id:: 62a9c038-4c88-47b4-874a-ad1f815839fa