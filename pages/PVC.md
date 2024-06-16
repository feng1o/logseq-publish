- ==summary-pvc==
  id:: 64f86c8a-846d-4cc3-846e-fef42789b5fe
	- PVC 是对一个 PV 的使用的声明，包括了所需要的容量，和访问模式等
	- 创建一个 PVC 之后，会根据 PVC 中定义的容量要求、label 去寻找一块满足条件的 PV 进行绑定
	- pvc是对pv的申领，