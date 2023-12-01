- ```
  kubectl top node  found-k8s-2
  kubectl describe node  found-k8s-2
  ```
污点和容忍度::  [taint toleration](https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/taint-and-toleration/)

	- ```
	  kubectl taint nodes node1 key1=value1:NoSchedule
	  ```
	-
-