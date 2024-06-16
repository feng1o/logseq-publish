- ==pv-summary==
  id:: 64f86bf0-7239-4261-9cca-ae1eccab1dcf
	- PV 是持久化存储，指定一块网络存储（可支持大多数主流网络存储）或本地卷
	- 可声明这块存储可使用的最大空间，和访问模式
	- 可以配置回收策略，当 PV 与 PVC 解绑之后，可保留或删除上面的数据
	- 可以配置 storageClass，表示这个 PV 属于哪一类资源
	- pv卷的制备： 动态、静态
		- 动态制备: pod申领pv，如果没有静态，就会基于pvc制备，pvc申请某个storage-class
	- [持久卷的类型](https://kubernetes.io/zh-cn/docs/concepts/storage/persistent-volumes/#types-of-persistent-volumes)  csi hostpath  ceph fc....