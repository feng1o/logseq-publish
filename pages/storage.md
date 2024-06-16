- ==summary-store ==
  id:: 64ac0b44-f2c4-490c-9671-b3f89bdf94ac
	- ![数据存储技术.pdf](../assets/数据存储技术_1686999388977_0.pdf) /  ![大话存储II.pdf](../assets/大话存储II_1686998175348_0.pdf)
	- ![Ceph设计原理与实现.pdf](../assets/Ceph设计原理与实现_1686998075030_0.pdf)
	- [[hls__ddia_1641797656322_0]]
	- ![存储技术原理分析：基于Linux_2.6内核源代码.pdf](../assets/存储技术原理分析：基于Linux_2.6内核源代码_1686927795111_0.pdf)
	- 文件系统技术内幕
	- 对象存储实战指南
	- [《分布式对象存储：原理、架构及Go语言实现》](https://zhuanlan.zhihu.com/write)
	- [DAS、NAS（nfs，cifs）、SAN，Samba（cifs通用互联网internet文件系统 ）](https://blog.51cto.com/liangchaoxi/4993756)  [[nfs]]、[[SAN]]、[[Samba]]、[[cifs]]
		- > CIFS 基于服务器消息块（SMB）协议。CIFS 允许设备与服务器和其他外围设备（如打印机）共享文件。在 NFS 中，客户端使用远程过程调用（RPC）向远程 NFS 服务器请求文件或目录。CIFS是Microsoft搞得SMB扩展，更新版本的 SMB 已经取代了 CIFS
		- > NAS和SAN最本质的区别就是文件管理系统FS在哪里，SAN结构中，文件管理系统（FS）分别在每一个应用服务器上面，而NAS则是每个应用服务器通过网络共享协议，使用同一个​ ​文件管理系统​​。即NAS和SAN存储系统的区别就是NAS有自已的文件管理系统。
	- [阿里云NAS EBS OSS对比](https://help.aliyun.com/zh/nas/product-overview/comparison-of-nas-oss-and-ebs)<a class="alg-2stars"></a>
- [[storage-concept]]
- [[分布式存储]]
	- [[Ceph]]
		- {{embed ((648d882f-62b2-490e-a8b4-1521e6a184dc))}}
	- [[GPFS]]  [[CFS]]
		- {{embed ((648d8888-67ef-4f15-9760-84a4d1f94bf5))}}
	- [[HDFS]]
		- {{embed ((648d88ec-2bfd-4c2f-9c15-1833891e139f))}}
	- [[GFS]]
	- [[Swift]]
		-
	- [[Lustre]]
		- 缺少副本机制、HPC领域，美国能源局结合IBM INTER等开发的。已开源， 阿里云PFS早期基于这个、后期改为GPFS?
- 存储[[压测工具]] [[fio]]/[[fio_verify]] [[vdbench]] [[$sub8]]==vdbench是一个 I/O 工作负载生成器，用于验证数据完整性和度量直接附加和网络连接的存储的性能==
	- [[$sub8-blue]]==vdbench测试的是整个集群或者整个虚机或者所有磁盘的总性能，而fio需要写脚本去测试多个磁盘或者多台虚机==
	- [fio_verify](http://smilejay.cn/2023/03/data-correctness-testing-via-fio-verify/)
- ##  path
	- https://zhuanlan.zhihu.com/p/491714514
	- https://zhuanlan.zhihu.com/p/362020813
- |**名词**| ----- |**说明**|
  |--| -- | --|
  | [[#red]]==云盘== | 数据块级别的块存储产品。云盘采用多副本的分布式机制，具有低时延、高性能、持久性、高可靠等性能，支持随时创建、扩容以及释放。| |
  |[[#red]]==本地盘==|基于云主机所在物理机（宿主机）上的本地硬盘设备，为云主机提供本地存储访问能力。为对存储IO性能和海量存储性价比有极高要求的业务场景而设计的产品。具有低时延、高随机IOPS、高吞吐量、高性价比等优势。 <html> <br>    从技术实现角度，Volc Stack计划支持两种类型的本地盘：<br>          本地直通盘；<br>          LVM（本地逻辑盘） </html>| |
  |[[#red]]==本地直通盘==| 属于本地盘的一种，将云主机所在物理机上的盘，通过PCI设备直通方案直接给云服务器使用，降低虚拟化开销。具有高读写速率，低读写时延，适用于处理海量数据、需要高I/O能力，要求快速数据交换和处理的场景。 <html> <br>     物理磁盘:云主机挂盘=1:1 <br>     目前后端NVMe SSD采用直通方案，HDD采用virtio，对前端无区分。</html> | |
  |[[#red]]==LVM==[[$sub8]]==(以下称为“本地逻辑盘”）==|     逻辑卷管理（Logical Volume Manager）是 Linux 下对磁盘分区进行管理的一种机制。LVM 是建立在磁盘分区和文件系统之间的一个逻辑层，系统管理员可以利用 LVM 在不重新对磁盘分区的情况下动态的调整分区的大小。如果系统新增了一块硬盘，通过 LVM 就可以将新增的硬盘空间直接扩展到原来的磁盘分区上。||
  |[[#red]]==参考==| [quote](https://forum.huawei.com/enterprise/zh/thread/580934324419706880) | -- |