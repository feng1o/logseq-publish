- [[RDMA]]（Remote Direct Memory Access），可以简单理解为网卡完全绕过CPU实现两个服务器之间的内存数据交换
- rdma-cmd
	- ```
	  ibdev2netdev 网口映射关系   
	  lspci | grep Mellanox   网卡是否install 
	  ibv_devices、ibv_devinfo  网卡及工作status
	  ```
	  [infiniBand](https://blog.51cto.com/liangchaoxi/4046247)
- [[RDMA]]技术适配
	- socket中直接read/write给fd，调用系统函数进入内核缓冲区或读取
	- [rdma编程需要用到verbs api：](https://www.sohu.com/a/368104469_795622)
		- ibv_post_send(struct ibv_qp *q, struct ibv_send_wr *w,  struct ibv_send_wr **bad_wr)
		- ibv_post_rcv、ibv_poll_cq(类似epoll能力?)
		- 关键区别在于，socket API都是同步操作，而RDMA API都是异步操作
		- 具体而言，ibv_post_send函数返回成功，仅仅意味着成功地向网卡提交了发送请求，并不保证数据真的被发送出去了。如果此时立马对发送数据所在的内存进行写操作，那么发送出去的数据就很可能是不正确的。socket  API是同步操作，write函数返回成功，意味着数据已经被写入了内核缓冲区，虽然此时数据未必真的发送了，但应用程序已经可以随意处置发送数据所在的内存
		  另一方面，ibv_poll_cq所获取的事件，与epoll_wait获取的事件也是不同的。前者表明，之前提交给网卡的某一发送或接收请求完成了；而后者表示，有新的报文被成功发送或是接收了。这些语义上的变化会影响到上层应用程序的内存使用模式和API调用方式。
		- 除了同步、异步的语义区别外， **RDMA编程还有一个关键要素，即所有参与发送、接收的数据，所在的内存必须经过注册**
		- 所谓内存注册，简单理解，就是把一段内存的虚拟地址和物理地址间的映射关系绑定好以后注册给网卡硬件
- [[RDMA]]限制
	- 需要基础设施支持:  无法像tpc一样通用，需要网卡硬件支持、正常使用依赖物理网络支持
- {{embed ((658e39d0-467f-4850-a14e-859d06b38e4f))}}
	-