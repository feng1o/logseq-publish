- ==summary-gpfs==
  id:: 648d8888-67ef-4f15-9760-84a4d1f94bf5
	- 由NSD和、physic disk组成，支持共享的文件系统
	- [blog-install-task-troubleshoting](https://leo.leung.xyz/wiki/GPFS#Troubleshooting)  [gpfs-monitor-github-personal](https://github.com/aleksyv/gpfs-monitoring)
	- TODO https://LWN0Y3QtY20tCg==/developer/news/339954
	- [gpfs并行文件系统分享](https://-.x.com/wiki/wikcn5EcHm6ZgUswZsfSeKie14y)
- ![scale_ece_ibm.pdf](../assets/scale_ece_ibm_1694418096624_0.pdf)   5.1.1
- > conception
	- CCR config cluster repository
	- Ø**File System Manager**:文件系统管理器，每一个GPFS文件系统被分配一个文件系统管理器，文件系统管理器有如下几个功能：１.文件系统配置管理，如增加磁盘，修复文件系统；２.文件系统mount 和umount处理．３.磁盘空间分配管理。
	  Ø**Token Manager**:执行分布式Token管理的功能节点，由集群管理软件根据工作负载情况动态地选择哪些节点、多少节点执行Token manager的功能。 Token用来维护节点间数据的一致性和完整性。
	  Ø**File System**:文件系统，是物理存储设备和用户之间的接口,其将物理存储设备划分为数据块,并在数据块之上构建数据和元数据的数据结构,达到方便用户(应用程序) 对数据操作的目的。GPFS通过条带花技术将数据并行分布到所有共享磁盘上面，并支持如下数据块大小：16K, 64K, 128K, 256K, 512K, 1024K (1M), 2M, 4M， 8M， 16M
- ### GPFS-CMD
	- ```
	  mmlsmount  all
	  mmlsfs all
	  mmgetstate 
	  mmlscluster
	  
	  
	  mmqos class list  fs_vepfs-cejv5be4bc531848
	  mmqos throttle list  fs_vepfs-cejv5be4bc531848
	  /usr/lpp/mmfs/bin/mmqos throttle create fs_vepfs-cejv5be4bc531848 --pool system --class class_fset-8d57be13 --maxMBS 101
	  ```
- ### 特点
	- #### 高性能、跨平台
	- ####  数据一致性
		- GPFS 通过一套复杂的信令管理机制提供数据一致性。通过这套机制允许任意节点通过各自独立的路径到达同一个文件。即使节点无法正常工作， GPFS 也可以找到其它的路径。
	- ####  数据安全性
		- GPFS 是一种日志文件系统，为不同节点建立各自独立的日志。日志中记录 metadata 的分布，一旦节点发生故障后，可以保证快速恢复数据。
		- GPFS 的 fail-over 功能通过规划，将数据分布到不同 failure group 内达到高可用性，减少单点故障的影响。为了保证数据可用性， GPFS 在多个 failure group 内为每个数据实例做备份，即使创建文件系统时没有要求复制， GPFS 也会自动在不同的 failure group 内复制恢复日志。
	- ####  系统可扩展性
		- 通过 GPFS ，系统资源可以动态调整，可以在文件系统挂载情况下添加或者删除硬盘。系统处于相对空闲时，用户可以在已配置的硬盘上重新均衡文件系统以提高吞吐量。可以在不重新启动 GPFS 服务情况下添加新节点。
	- ####  管理简单
		- GPFS 自动在各个节点间同步配置文件和文件系统信息，而且在同一个节点内，对 GPFS 的管理可以在任一个节点上进行。
- 概念
	- SAN:: Storage Area Network, 一个逻辑上的存储区域网络，
	- NSD::  net shared disk
	- nodeclass:: 节点组，gpfs的概念，一个节点组包含若干个节点。当涉及到多个节点的操作或者配置的运维操作，可以直接指定节点组
	- Recovery group:一组节点以及节点上磁盘的集合。一个recovery group里面如果有失效的节点或者磁盘，就去做recovery.
	- Declustered array：[切分组](https://www.ibm.com/docs/en/storage-scale-ece/5.1.4?topic=management-declustered-array-naming)。一个recovery group可以按照磁盘类型的不同，划分到不同的DA里面。数据条带分布只能在这个切分组里进行。也就是说 vdisk的创建只能在一个 DA里面进行，条带不能跨 DA，而且这些磁盘一定要尺寸大小都一致，不然算出来的就不均衡了。
	- Log Group：每个节点上有两个log group，每个log group管理自己的vdisk。所以一个vdiskset 里面的是vdisk数量一定是节点数量的两倍。
-
- other
	- All GPFS management utilities are located under the [[$green]]==/usr/lpp/mmfs/bin/== directory and commands typically start with [[$green]]==mm==.
-
- [[gpfs-csi]]
- pmsensor
	-
- [[gpfs-ibm-fae]]
- ECE数据读写过程
	- ```
	  写I/O数据从用户到落盘的流程介绍
	  Gpfs client发数据到nsd server，nsd server也就是vdisk server收到数据根据数据大小处理不同。
	  1 小数据，会以log个形式先落盘，然后buffer中的脏数据会后台flush
	  2 Full block数据会新分配空间，数据根据条带个数分城各个条带发送给对应的pdisk server.
	  读数据是的时候，gpfs client给某个nsd disk的nsd server发read请求。如果数据已经在Nsd server（vdisk server）的buffer里则nsd server可以直接返回数据。否则Nsd server（vdisk server）把地址转换为EC的 数据track。从track得到每个条带对应的pdisk和条带的地址，然后给对应的pdisk server发送读请求。
	  上面的信息不包括如何从具体的文件数据定位数据在哪个nsd disk的什么位置的过程。
	  培训后下列问题我们可以得到解答，培训内容不限于下列的问题。
	  ECE模式跟普通的模式，哪些功能是不一样的，哪些功能是复用的；
	  ECE多了块设备管理层来实现EC。在文件系统层名和普通模式基本一致。
	  VDisk/Pdisk的映射关系，Log Group的作用等
	  VDisk/Pdisk的映射关系这个比较复杂了，一句话说不清楚。
	  Log Group的作用我理解是方便管理vdisk，比如vdisk server失效后，vdisk应该怎么迁移。以及把data vdisk和log vdisk对应起来。
	  ```
- pdisk/vdisk/nsd structure
	- ![image.png](../assets/image_1703836774066_0.png)
	-