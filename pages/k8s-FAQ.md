public:: true

- [23常见k8s-faq](https://www.51cto.com/article/706611.html)
- [91常见k8s-faq](https://github.com/0voice/k8s_awesome_document/blob/main/91%E9%81%93%E5%B8%B8%E8%A7%81%E7%9A%84Kubernetes%E9%9D%A2%E8%AF%95%E9%A2%98%E6%80%BB%E7%BB%93.md)
-
- 1. [k8s中的服务发现](https://blog.fleeto.us/post/demystifying-kubernetes-service-discovery/)<a class="ask"></a>
	- Kubernetes Service 对象在一组提供服务的 Pod 之前创建一个稳定的网络端点，并为这些 Pod 进行负载分配。
	- coreDNS 服务注册
		- [[$sub8-blue]]==CoreDNS 实现了一个控制器，会对 API Server 进行监听，一旦发现有新建的 Service 对象，就创建一个从 Service 名称映射到 ClusterIP 的域名记录。这样 Service 就不必自行向 DNS 进行注册，CoreDNS 控制器会关注新创建的 Service 对象，并实现后续的 DNS 过程==
	- kubeproxy
		- [[$sub8-blue]]==是一个基于 Pod 运行的 Kubernetes 原生应用，它所实现的控制器会监控 API Server 上 Service 的变化，并据此创建 `iptables` 或者`IPVS` 规则，这些规则告知节点，捕获目标为 Service 网络的报文，并转发给 Pod IP==
	- [iptables-k8s](https://yuerblog.cc/2019/12/09/k8s-%E6%89%8B%E6%8A%8A%E6%89%8B%E5%88%86%E6%9E%90service%E7%94%9F%E6%88%90%E7%9A%84iptables%E8%A7%84%E5%88%99/)
- 2. [informer](https://zhuanlan.zhihu.com/p/59660536)  [informer原理](https://www.jianshu.com/p/cc1444867c70)
	- 一个带有本地缓存和索引机制的、可以注册 EventHandler 的 client，本地缓存被称为 Store，索引被称为 Index。使用 informer 的目的是为了减轻 apiserver 数据交互的压力而抽象出来的一个 cache 层, 客户端对 apiserver 数据的 "读取" 和 "监听" 操作都通过本地 informer 进行。
	- 功能:
		- 同步数据到本地缓存
		- 根据对应的事件类型，触发事先注册好的 ResourceEventHandle
- 3. [pod健康检查](https://www.cnblogs.com/fengjian2016/p/17078670.html) 即pod异常等怎么保证服务切换的连续性 <a class="ask"></a>
	- [[$blue]]==Pod 已经启动成功，且能访问里面的端口，但是却返回错误信息。还有就是在执行滚动更新时候，总会出现一段时间，Pod 对外提供网络访问，但是访问却发生 404==，这两个原因，都是因为 [[#red]]==Pod 已经成功启动，但是 Pod 的的容器中应用程序还在启动中导致==
	- 因为 k8s 中采用大量的异步机制、以及多种对象关系设计上的解耦，当应用实例数增加/删除、或者应用版本发生变化触发滚动升级时，系统并不能保证应用相关的 service、ingress配置总是及时能完成刷新。在一些情况下，往往只是新的 Pod 完成自身初始化，系统尚未完成 
	  Endpoint、负载均衡器等外部可达的访问信息刷新，老的 Pod 就立即被删除，最终造成服务短暂的额不可用，这对于生产来说是不可接受的，所以 k8s 就加入了一些存活性探针：
		- [[StartupProbe]]   [[$sub8]]==先执行 StartupProbe 探针，其他两个探针将会被暂时禁用，直到 pod 满足 StartupProbe 探针配置的条件，其他 2 个探针启动，如果不满足按照规则重启容器。另外两种探针在容器启动后，会按照配置，直到容器消亡才停止探测，而 StartupProbe 探针只是在容器启动后按照配置满足一次后，不再进行后续的探测==
		- [[LivenessProbe]]  [[$sub8]]==存活性探针，用于判断容器是不是健康，如果不满足健康条件，那么 Kubelet 将根据 Pod 中设置的 restartPolicy （重启策略）来判断==
		- [[ReadinessProbe]]  [[$sub8]]==就绪性探针，用于判断容器内的程序是否存活（或者说是否健康），只有程序(服务)正常, 异常把node剔除service==
	- 探测方法，执行命令、tcp、http [[LivenessProbe]] [[ReadinessProbe]]  还可以设置探测频率、间隔等
- 4. [leader选择](https://blog.csdn.net/weixin_39961559/article/details/81877056)
	- scheduler和manager controller
	-
- 5. [k8s-crd](https://www.cnblogs.com/liugp/p/16683916.html)  `Custom Resource Definition`自定义资源定义
-
- id:: 65d810fd-97ae-4606-9cee-eb624b038011
  6. [k8s的架构](https://www.51cto.com/article/706611.html)
	- #.kanban
		- master节点
			- api-servier: [[$sub8-blue]]==提供了认证、授权、访问控制、API注册和发现等机制==
			- controller-manager: [[$sub8-blue]]==维护群集的状态，比如故障检测、自动扩展、滚动更新等==
			- scheduler: [[$sub8-blue]]==负责资源的调度，按照预定的调度策略将pod调度到相应的node节点上==
			- Etcd / kubectl
		- node节点
			- kubelet: [[$sub8-blue]]==维护容器的生命周期，同时也负责Volume和网络的管理==
			- kube-proxy: [[$sub8-blue]]==负责为Service提供cluster内部的服务发现和负载均衡==
			- container-runtime: [[$sub8-blue]]==负责管理运行容器的软件，比如docker==
			- pod
	- kubelet 的另一个重要功能，则是调用网络插件和存储插件为容器配置网络和持久化存储。这两个插件与 kubelet 进行交互的接口，分别是 CNI（Container Networking Interface）和 CSI（Container Storage Interface）。
- card-last-interval:: 4.28
  card-repeats:: 1
  card-ease-factor:: 2.36
  card-next-schedule:: 2024-01-01T19:36:54.732Z
  card-last-reviewed:: 2023-12-28T13:36:54.733Z
  card-last-score:: 3
  7. 创建一个pod的流程 #card
	- 客户端提交Pod的配置信息（可以是yaml文件定义好的信息）到kube-apiserver；
	- Apiserver收到指令后，通知给controller-manager创建一个资源对象；
	- Controller-manager通过api-server将pod的配置信息存储到ETCD数据中心中；
	- Kube-scheduler检测到pod信息会开始调度预选，会先过滤掉不符合Pod资源配置要求的节点，然后开始调度调优，主要是挑选出更适合运行pod的节点，然后将pod的资源配置单发送到node节点上的kubelet组件上。
	- Kubelet根据scheduler发来的资源配置单运行pod，运行成功后，将pod的运行信息返回给scheduler，scheduler将返回的pod运行状况的信息存储到etcd数据中心。
- card-last-interval:: -1
  card-repeats:: 1
  card-ease-factor:: 2.5
  card-next-schedule:: 2024-01-15T16:00:00.000Z
  card-last-reviewed:: 2024-01-15T11:43:20.580Z
  card-last-score:: 1
  8. pod删除过程 #card
	- 答：Kube-apiserver会接受到用户的删除指令，默认有30秒时间等待优雅退出，超过30秒会被标记为死亡状态，此时Pod的状态Terminating，kubelet看到pod标记为Terminating就开始了关闭Pod的工作；
	- 关闭流程如下：
	- pod从service的endpoint列表中被移除；
	- 如果该pod定义了一个停止前的钩子，其会在pod内部被调用，停止钩子一般定义了如何优雅的结束进程；
	- 进程被发送TERM信号（kill -14）
	- 当超过优雅退出的时间后，Pod中的所有进程都会被发送SIGKILL信号（kill -9）。
- card-last-interval:: 4.28
  card-repeats:: 1
  card-ease-factor:: 2.36
  card-next-schedule:: 2024-01-19T17:41:35.458Z
  card-last-reviewed:: 2024-01-15T11:41:35.459Z
  card-last-score:: 3
  9. k8s的数据持久化有哪些方式？ #card
	- {{embed ((64dc87c3-fe56-4a9e-a9d6-201489ef314c))}}
	- {{embed ((64dc88a7-64a6-4c7c-8da8-978d74758ed0))}}
	- {{embed ((64f86be4-f2cf-44e6-bfe5-2d22d5264dd0))}}