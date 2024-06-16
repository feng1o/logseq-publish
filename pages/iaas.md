- ==summary-iaas ==
  id:: 658d676c-3cc4-4481-a90b-991490b57c92
	- [[DPU]]
- [[DPU]]  [介绍](https://www.sohu.com/a/677771102_711053)
	- DPU是以数据为中心 IO密集的专用处理器。DPU对现有的SmartNIC 做了整合，能看到很多以往 SmartNIC 的影子，但明显高于之前任何一个 SmartNIC 的定位。
	- DPU的核心功能就是[[#green]]==网络数据处理==，既包括网络协议的分析，也可以是直接满足应用需求的加工计算。随之可以减少 22~80%的 CPU 性能，因此也被称为“卸载”（offload）。DPU 的部分前身功能在智能网卡（SmartNIC）上实现，完整的 DPU 芯片本身也通常会被集成到板卡（网卡）上
	- DPU要解决的核心问题是基础设施的“降本增效”，即将“CPU处理效率低 下、GPU处理不了”的负载卸载到专用DPU，提升整个计算系统的效率、降低 整体系统的总体拥有成本（）  [quote](https://xueqiu.com/5736210091/211224390)
	-
	- 出现:    十年前，[[#green]]==网络处理器==(NP)主要用于包处理、协议处理加速，应用在各种网关、防火墙、UTM等设备上，多采用多核NOC架构。后来Intel推出了DPDK技术，在用户空间上利用自身提供的数据平面库手法数据包，绕过linux内核协议栈，极大提升了包转发速率，原来需要NP来实现的网关类设备，现在X86就能满足性能要求。而DPU则是5G时代集网络加速为一体的新型数据处理单元。[[DPU]]内部融合了[[RDMA]]、网络功能、存储功能、安全功能、虚拟化功能。接手CPU不擅长的网络协议处理、数据加解密、数据压缩等数据处理任务，同时兼顾传输和计算的需求。DPU起到连接枢纽的作用，一端连接CPU、GPU、SSD、FPGA加速卡等本地资源，一端连接交换机/路由器等网络资源。总体而言，DPU不仅提高了网络传输效率，而且释放了CPU算力资源，从而带动整体数据中心的降本增效。
	- [what?](https://zhuanlan.zhihu.com/p/424285923)  DPU是相当于智能网卡的升级版本，增强了网络安全和网络协议的处理能力，增强了分布式存储的处理能力，[[$blue]]==将软件定义网络、软件定义存储、软件定义加速器融合到一个有机的整体中==，解决协议处理，数据安全，算法加速等计算负载，替代数据中心用于处理分布式存储和网络通信的CPU资源
		- DPU本质上是分类计算，是将数据处理/预处理从CPU卸载，同时将算力分布在更靠近数据发生的地方，从而降低通信量，涵盖基于GPU的异构计算，基于网络的计算(In-NetworkComputing)、基于内存(In-Memory-Computing)的计算等多个方面。DPU定位于协同处理单元，是数据面与控制面分离思想的一种实现，其与CPU协作配合，后者负责通用控制，前者专注于数据处理。在局域网场景下DPU通过PCIe/CXL等技术连接同一边缘内各种CPU、GPU，广域网场景下主要通过Ethernet/infiniband等技术实现边缘与边缘间、边缘与云之间的连接。
	- 特点::
		- 基于DPU的网络处理模块是完全可编程的
		- DPU将成为新的数据网关，集成安全功能，使网络接口成为隐私的边界
		- DPU将成为存储的入口
		- DPU将成为云服务提供商管理资源的工具，云服务提供商将云资源管理占用全部下沉至DPU，将CPU、GPU全部释放出来，作为基础设施提供给云租户
	- DPU实现的方式::
	- [[DPU]]和[[NPU]](ai芯片)区别:
		- [[DPU]]和[[NPU]]都是具有学习能力的芯片，只是DPU是深度学习处理器，是基于Xilinx可重构特性的FPGA芯片。而NPU不基于Xilinx。
		- 不同于CPU的AI芯片，[[DPU]]可以用于机器学习、安全、电信和存储等应用，并提升性能。
		- NPU包括三个部分：可编程引擎（Programmable Engines，PPU）、神经网络引擎（Neural Network Engine，NN）和各级缓存
- [[cpu]]
	- 国产cpu形成六大厂商齐头并进的格局，**以鲲鹏(hisilicon/华为 armv8)、飞腾(phytium/Armv8)、龙芯(ip授权+自研/mips)、兆芯(x86授权)、海光(hygon/x86)、申威(授权+自研/alpha)为代表**
- 云上网络划分
	- {{embed ((65af7f3e-34b2-4d3d-8836-487664ed5e55))}}
	- 一般云监控服务，可以从公共服务区直接访问；如果某个产品是on ecs的，监控agent需要在ecs内，agent就无法直接push数据到云监控，网络隔离
	-