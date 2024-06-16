### 容器基础 [[Docker]]
collapsed:: true
	- 6. [隔离与限制](https://time.geekbang.org/column/article/14653)
		- 基于namespace和 [[cgroup]] 的隔离，很容易被攻击宿主机，有些比如宿主的时间大家还是公用的；基于虚拟化或者独立内核技术的容器实现，则可以比较好地在隔离与性能之间做出平衡
	- 7. [理解容器镜像](https://time.geekbang.org/column/article/17921)
		- 基于namespace创建的容器，那他的目录呢？ 如果直接clone一个进程，会看到宿主机一样的目录；基于chroot，有个mount namespace，这个挂载到宿主机某个目录下，在容器里看到的只有自己的，专业名称: rootFs（根文件系统)，这样就看到了和真实系统一样的目录结构
		- rootfs 只是一个操作系统所包含的文件、配置和目录，并不包括操作系统内核；rootfs 只包括了操作系统的“躯壳”，并没有包括操作系统的“灵魂”。灵魂在哪里？ 同一台机器上的所有容器，都共享宿主机操作系统的内核。
		- rootFs提供了一致性：
			- 由于 rootfs 里打包的不只是应用，而是整个操作系统的文件和目录，也就意味着，应用以及它运行所需要的所有依赖，都被封装在了一起。
			- 容器镜像“打包操作系统”的能力，这个最基础的依赖环境也终于变成了应用沙盒的一部分。这就赋予了容器所谓的一致性：无论在本地、云端，还是在一台任何地方的机器上，用户只需要解压打包好的容器镜像，那么这个应用运行所需要的完整的执行环境就被重现出来了。
		- 那每次都搞个一rootFs吗？ 不是，分层，分层实际使用的是unionFS
			- 对于 AuFS 来说，它最关键的目录结构在 /var/lib/docker 路径下的 diff 目录：
	- 8.[重新认识docker容器](https://time.geekbang.org/column/article/18119) [[Docker]]
		- ```apl
		  # 看docker进程id（宿主机)
		  docker inspect --format '{{ .State.Pid }}'  4ddf4638572d
		  ls -l /proc/25686/ns
		  
		  ```
		- <a class="ask">docker exec -it xx 是怎么进到容器里的</a>
			- 在 setns() 执行后，当前进程就加入了这个文件对应的 Linux Namespace 当中了
		- Docker volume [[Docker]]
			- <a class="ask">容器里进程新建的文件，怎么才能让宿主机获取到</a>
			- <a class="ask">宿主机上的文件和目录，怎么才能让容器里的进程访问到</a>
			- ```apl
			  docker run -v /test ...
			  docker run -v /home:/test ...
			  没有显示声明宿主机目录，那么 Docker 就会默认在宿主机上创建一个临时目录 /var/lib/docker/volumes/[VOLUME_ID]/_data，然后把它挂载到容器的 /test 目录上。而在第二种情况下，Docker 就直接把宿主机的 /home 目录挂载到容器的 /test 目录上
			  ```
	- 9. [容器到容器云 k8s本质](https://time.geekbang.org/column/article/23132)
		- 一个正在运行的 Linux 容器，其实可以被“一分为二”地看待：
		- 一组联合挂载在 /var/lib/docker/aufs/mnt 上的 rootfs，这一部分我们称为“容器镜像”（Container Image），是容器的静态视图；
		- 一个由 Namespace+Cgroups 构成的隔离环境，这一部分我们称为“容器运行时”（Container Runtime），是容器的动态视图。
		- k8s要解决的是什么： 编排？调度？容器云？还是集群管理？
		- {{embed ((65d810fd-97ae-4606-9cee-eb624b038011))}}
- ### k8s集群搭建
  collapsed:: true
	- kubeadm
	- {{embed ((65d810fd-3175-44fe-97b2-1dc401737de6))}}
-
- #### 容器编排与作业管理
	- 13. [为什么需要pod？](https://time.geekbang.org/column/article/40092)
		- pod只是一个逻辑概念，就是共享了一些资源的容器。 namespace、net、volume
			- 比如有个需求两个容器之间需要频繁互访，共享资源，进程间通信；那基于docker的可以docker run --net-from --volume-from， 只要两个container共享了net和volume实际...，但docker必须被依赖的先启动
		- k8s里的pod如果支持多个容器，必须有个中间容器，infra容器，k8s.gcr.io/pause
		- [[sidecar]] 一种设计模式，用于将附加的容器（即 Sidecar 容器）与主要容器（即主容器）一起部署在同一个 Pod 中，以扩展或增强主容器的功能。监控、日志采集、安全、路由lb等.
		- 基于infra容器后，对于 Pod 里的容器 A 和容器 B 来说：
			- 它们可以直接使用 localhost 进行通信；它们看到的网络设备跟 Infra 容器看到的完全一样；
			- 一个 Pod 只有一个 IP 地址，也就是这个 Pod 的 Network Namespace 对应的 IP 地址；
			- 当然，其他的所有网络资源，都是一个 Pod 一份，并且被该 Pod 中的所有容器共享；
			- [[$red]]==Pod 的生命周期只跟 Infra 容器一致==，而与容器 A 和 B 无关
			- ==同一个 Pod 里面的所有用户容器来说，它们的进出流量，也可以认为都是通过 Infra 容器完成的。==
		- 可以把pod -- 虚拟机
	- [14. 深入解析pod对象: 概念](https://time.geekbang.org/column/article/40366)
		- 到底哪些属性属于 Pod 对象，而又有哪些属性属于 Container 呢？
			- 凡是调度、网络、存储，以及安全相关的属性，基本上是 Pod 级别的。
		-
	- 16. [控制器](https://time.geekbang.org/column/article/40583)
		- 控制的对象通过模板template定义的，比如deployment里的spec、meta都是控制器定义，template下的label等都是被控制对象
		- pod模板 podTemplate
		- 对于一个 [[Deployment]] 所管理的 Pod，它的 ownerReference 是谁？  [[replicaSet]]
	- 17. [作业副本与水平扩展](https://time.geekbang.org/column/article/40906)
		- deployment: 非常重要的功能：Pod 的“水平扩展 / 收缩”（horizontal scaling out/in）
		- ```apl
		  $ kubectl rollout status deployment/nginx-deployment
		  $ kubectl set image deployment/nginx-deployment nginx=nginx:1.91
		  deployment.extensions/nginx-deployment image updated
		  $ kubectl rollout undo deployment/nginx-deployment
		  $ kubectl rollout history deployment/nginx-deployment
		      deployments "nginx-deployment"
		      REVISION    CHANGE-CAUSE
		      1           kubectl create -f nginx-deployment.yaml --record
		      2           kubectl edit deployment/nginx-deployment
		  	3           kubectl set image deployment/nginx-deployment nginx=nginx:1.91
		  $ kubectl rollout history deployment/nginx-deployment --revision=2
		  $ kubectl rollout undo deployment/nginx-deployment --to-revision=2
		  	# Deployment 对象有一个字段，叫作 spec.revisionHistoryLimit，就是 Kubernetes 为 Deployment 保留的“历史版本”个数。所以，如果把它设置为 0，你就再也不能做回滚操作了。
		  
		  # 比如你每次修改deployment，都会滚动更新一个replicaset，有点浪费资源，可以暂停
		  $ kubectl rollout pause deployment/nginx-deployment
		  $ kubectl rollout resume deployment/nginx-deployment  # 在打开
		  
		  $ kubectl patch statefulset mysql --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"mysql:5.7.23"}]'
		  
		  ```
		- deployment的控制器，滚动更新pod是随机的，那如果有些情况不能呢？ 需要自定义控制器
		- 你听说过[[金丝雀发布]]（Canary Deployment）和[[蓝绿发布]]（Blue-Green Deployment）吗？你能说出它们是什么意思吗？
			- 金丝雀部署：优先发布一台或少量机器升级，等验证无误后再更新其他机器。优点是用户影响范围小，不足之处是要额外控制如何做自动更新。
			  蓝绿部署：2组机器，蓝代表当前的V1版本，绿代表已经升级完成的V2版本。通过LB将流量全部导入V2完成升级部署。优点是切换快速，缺点是影响全部用户。
	- 18. [statefulset 拓扑结构](https://time.geekbang.org/column/article/41017)
		- ```apl
		  $ kubectl run -i --tty --image busybox:1.28.4 dns-test --restart=Never --rm /bin/sh 
		  ```
		- 所以，StatefulSet 的核心功能，就是通过某种方式记录这些(拓扑、存储)状态，然后在 Pod 被重新创建时，能够为新 Pod 恢复这些状态。
		- Headless Service 的方式，StatefulSet 为每个 Pod 创建了一个固定并且稳定的 DNS 记录，来作为它的访问入口<pod-name>.<svc-name>.<namespace>.svc.cluster.local
		- {{embed ((65eecb92-f7ae-467a-8cc8-b55c6713e0fd))}}
	- 19. [statefulset的存储状态](https://time.geekbang.org/column/article/41154)
		- statefulset 如果 不同的pod ，需要不同的配置，
		  id:: 66152501-ba9b-4f11-b633-725c1254aa7f
		  比如说 zk集群，每个集群的myid 都是不同的，比如mysql集群每个主机的serverid 也是不同的，这种的怎么处理呢？
			- operator
	- 20. [mysql为例statefulset ***](https://time.geekbang.org/column/article/41217)  [[mysql容器化]]
		- {{embed ((661529d1-e394-4fa7-b0a0-e694d444f907))}}
	- 21. [daemonset](https://time.geekbang.org/column/article/41366)
		- 更重要的是，跟其他编排对象不一样，DaemonSet 开始运行的时机，很多时候比整个 Kubernetes 集群出现的时机都要早。
		- DaemonSet 的“过人之处”，其实就是依靠 Toleration 实现的。
		- {{embed ((65eecb92-6462-4d71-8042-1b3671d0376a))}}
		- ```apl
		  # 这个大于2的pod才会更新
		  $ kubectl patch statefulset mysql --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"mysql:5.7.23"}]'$ kubectl patch statefulset mysql -p '{"spec":{"updateStrategy":{"type":"RollingUpdate","rollingUpdate":{"partition":2}}}}'
		  
		  ```
		- DaemonSet 管理的，是一个网络插件的 Agent Pod，那么你就必须在这个 DaemonSet 的 YAML 文件里，给它的 Pod 模板加上一个能够“容忍”node.kubernetes.io/network-unavailable“污点”的 Toleration，当一个节点的网络插件尚未安装时，这个节点就会被自动加上名为node.kubernetes.io/network-unavailable的“污点”。
	- 22. 撬动离线业务 [job与cronjob](https://time.geekbang.org/column/article/41607)
		- 提交一个job，restartPolicy： never
		- job如果失败了怎么办？ backoffLimit 来限制重试次数
		- Job Controller 对并行作业的控制方法：
			- spec.parallelism，它定义的是一个 Job 在任意时间最多可以启动多少个 Pod 同时运行；
			  logseq.order-list-type:: number
			- spec.completions，它定义的是 Job 至少要完成的 Pod 数目，即 Job 的最小完成数。
			  logseq.order-list-type:: number
		- job工作原理：
			- 首先，Job Controller 控制的对象，直接就是 Pod。
			- 通过定义parallel和completions来决定并行几个，最多几个完成的pod
	- 23. [声明式api与k8s编程范式](https://time.geekbang.org/column/article/41769)
		- kubectl replace 的执行过程，是使用新的 YAML 文件中的 API 对象，替换原有的 API 对象；而 kubectl apply，则是执行了一个对原有 API 对象的 PATCH 操作。
		- 类似地，kubectl set image 和 kubectl edit 也是对已有 API 对象的修改。更进一步地，这意味着 kube-apiserver 在响应命令式请求（比如，kubectl replace）的时候，一次只能处理一个写请求，否则会有产生冲突的可能。而对于声明式请求（比如，kubectl apply），一次能处理多个写操作，并且具备 Merge 能力。
		- 事实上，从“使用 Kubernetes 部署代码”，到“使用 Kubernetes 编写代码”的蜕变过程，正是你从一个 Kubernetes 用户，到 Kubernetes 玩家的晋级之路。
		- 而，如何理解“Kubernetes 编程范式”，如何为 Kubernetes 添加自定义 API 对象，编写自定义控制器，正是这个晋级过程中的关键点，
	- 24. 声明式api： [api对象奥秘1](https://time.geekbang.org/column/article/41876)
		- 如何利用这套 API 机制，在 Kubernetes 里添加自定义的 API 对象？
			- 根据yaml，分组、分类、version管理
		- [[CRD]] 的全称是 Custom Resource Definition， CustomResourceDefinition， 具体步骤
	- 25. 声明式api： [编写自定义控制器](https://time.geekbang.org/column/article/42076)
		- 自定义控制器的工作原理
	- 26. 基于角色[的权限控制 RBAC](https://time.geekbang.org/column/article/42154)  Role-Based Access Control
	- 27. [k8s-operator](https://time.geekbang.org/column/article/42493)
		- etcd-operator为例，EtcdCluster 这个 CRD 的一个具体实例，也就是一个 Custom Resource（CR）
		- [[k8s-operator]] 的工作原理，实际上是利用了 Kubernetes 的自定义 API 资源（CRD），来描述我们想要部署的“有状态应用”；然后在自定义控制器里，根据自定义 API 对象的变化，来完成具体的部署和运维工作。
- #### k8s容器持久化存储
	- 28. [pv pvc sc](https://time.geekbang.org/column/article/42698) [[PVC]] [[PV]] [[storage-class]]
		- 通常情况下，PV 对象是由运维人员事先创建在 Kubernetes 集群里代用的。pv一般是一个持久化在宿主机的目录或nfs挂载目录。
		- PVC 描述的，则是 Pod 所希望使用的持久化存储的属性。比如，Volume 存储的大小、可读写权限等等; PVC 对象通常由开发人员创建；或者以 PVC 模板的方式成为 StatefulSet 的一部分，然后由 StatefulSet 控制器负责创建带编号的 PVC.
		- 当一个 Pod 调度到一个节点上之后，kubelet 就要负责为这个 Pod 创建它的 Volume 目录。默认情况下，kubelet 为 Volume 创建的目录是如下所示的一个宿主机上的路径：`/var/lib/kubelet/pods/<Pod的ID>/volumes/kubernetes.io~<Volume类型>/<Volume名字>`
		- Dynamic Provisioning(能自动创建pv) 机制工作的核心，在于一个名叫 StorageClass 的 API 对象,而 StorageClass 对象的作用，其实就是创建 PV 的模板。
			- ```
			  用户提交请求创建pod，Kubernetes发现这个pod声明使用了PVC，那就靠PersistentVolumeController帮它找一个PV配对。
			  
			  没有现成的PV，就去找对应的StorageClass，帮它新创建一个PV，然后和PVC完成绑定。
			  
			  新创建的PV，还只是一个API 对象，需要经过“两阶段处理”变成宿主机上的“持久化 Volume”才真正有用：
			  第一阶段由运行在master上的AttachDetachController负责，为这个PV完成 Attach 操作，为宿主机挂载远程磁盘；
			  第二阶段是运行在每个节点上kubelet组件的内部，把第一步attach的远程磁盘 mount 到宿主机目录。这个控制循环叫VolumeManagerReconciler，运行在独立的Goroutine，不会阻塞kubelet主循环。
			  
			  完成这两步，PV对应的“持久化 Volume”就准备好了，POD可以正常启动，将“持久化 Volume”挂载在容器内指定的路径。
			  ```
		- 29. [pv、pvc是不是多此一举？](https://time.geekbang.org/column/article/42819)
			- Local Persistent Volume 的设计，主要面临两个难点。
				- 如何把本地磁盘抽象成 PV。
					- 你绝不应该把一个宿主机上的目录当作 PV 使用。这是因为，这种本地目录的存储行为完全不可控，它所在的磁盘随时都可能被应用写满，甚至造成整个宿主机宕机。而且，不同的本地目录之间也缺乏哪怕最基础的 I/O 隔离机制，所以一个LPV应该是一块额外的盘或者设备，‘一个pv一块盘'
				- 调度器如何保证 Pod 始终能被正确地调度到它所请求的 Local Persistent Volume 所在的节点上呢？
					- 本质就是每个节点的设备是运维准备好的，不通节点挂载(目录)不一定一样，设备也可能不同？无法保障。所以一般如果使用了local pv必须通过nodeAffinity来选择指定的节点
			- 手动创建 PV 的方式，即 Static 的 PV 管理方式，在删除 PV 时需要按如下流程执行操作：
				- 删除使用这个pv的所有pod
				- 宿主机移除本地盘 umount掉
				- 删除pvc
				- 删除pv
		- 30. [编写自己的存储插件 lfexvolue与csi](https://time.geekbang.org/column/article/44245)
			- Kubernetes 中，存储插件的开发有两种方式：FlexVolume 和 CSI
		- 31. [csi插件编写](https://time.geekbang.org/column/article/64392)
		-
- #### k8s网络
	- 32. [浅谈容器网络](https://time.geekbang.org/column/article/64948)
		- linux容器有自己的网络栈: 所谓“网络栈”，就包括了：网卡（Network Interface）、回环设备（Loopback Device）、路由表（Routing Table）和 iptables 规则。
		- 容器会在自己的环境虚拟一张网卡、并在宿主机虚拟一张网卡，名字是vethxxxx，通过在宿主机网桥实现网络互通
		- ```apl
		  通过打开 iptables 的 TRACE 功能查看到数据包的传输过程，具体方法如下所示：
		  # 在宿主机上执行
		  $ iptables -t raw -A OUTPUT -p icmp -j TRACE
		  $ iptables -t raw -A PREROUTING -p icmp -j TRACE
		  /var/log/syslog 里看到数据包传输的日志
		  ```
		- 当你遇到容器连不通“外网”的时候，你都应该先试试 docker0 网桥能不能 ping 通，然后查看一下跟 docker0 和 Veth Pair 设备相关的 iptables 规则是不是有异常，往往就能够找到问题的答案了。
		- 构建这种容器网络的核心在于：我们需要在已有的宿主机网络上，再通过软件构建一个覆盖在已有宿主机网络之上的、可以把所有容器连通在一起的虚拟网络。所以，这种技术就被称为：[[Overlay Network]]（覆盖网络
	- 33. [深入解析容器跨主机网络](https://time.geekbang.org/column/article/65287) ***
		- 理解flannel项目的VXLAN网络，怎么实现两个容器之间的网络互通的，本质还是使用了虚拟网络的tunel隧道技术，在发送方的宿主机内核内包装了目的容器宿主机的一个虚拟设备地址，加上子网管理能力flannel，比如机器B有了容器网络bnet1，在机器A的路由标里记录了B有个子网bnet1，发往bnet1的包就知道应该送给B机器
	- 34. [k8s网络模型和cni网络插件](https://time.geekbang.org/column/article/67351)
		- Kubernetes 是通过一个叫作 CNI 的接口，维护了一个单独的网桥来代替 docker0。这个网桥的名字就叫作：CNI 网桥，它在宿主机上的设备名称默认是：cni0。
	- 35. [k8s三层网络方案](https://time.geekbang.org/column/article/67775)
		- flannel的：host-gw 模式的工作原理，其实就是将每个 Flannel 子网（Flannel Subnet，比如：127.x.0.1/24）的“下一跳”，设置成了该子网对应的宿主机的 IP 地址。
			- Flannel 子网和主机的信息，都是保存在 Etcd 当中的。flanneld 只需要 WACTH 这些数据的变化，然后实时更新路由表即可？ 这个怎么理解，如果是很远的两个呢
	- 36. [k8s网络多租户、隔离实现](https://time.geekbang.org/column/article/68316)
		- NetworkPolicy，网络插件就会使用这个 NetworkPolicy 的定义，在宿主机上生成 [[iptables]] 规则
		- ((662a4f46-fd9e-4263-ba6d-c4a53da23a1d))
	- 37. [service、dns与服务发现](https://time.geekbang.org/column/article/68636)  ***** [[k8s网络管理]] [[k8s-gateway]]
		- ```
		  kubectl  get ep -n vepfs vepfsmgr
		  ```
		- Service 是由 kube-proxy 组件，加上 iptables 来共同实现的。比如一个service会有对应deplyoment，和edpoint； service通过iptables设置规则让dnat转换到对应的pod，权重就是平均分，成了round-robing轮询； dnat并会把到service的包转换成具体的pod的ip和port。
			- 通过iptable支持的service，如果规则太多，就会拖慢cpu，因此ipvs模式service出现了
		- ipvs模式的service：
			- 跟 iptables 模式类似。当我们创建了前面的 Service 之后，kube-proxy 首先会在宿主机上创建一个虚拟网卡（叫作：kube-ipvs0），并为它分配 Service VIP 作为 IP 地
			- `ip addr` 可看到很多的虚拟ip
			- kube-proxy 就会通过 Linux 的 IPVS 模块，为这个 IP 地址设置三个 IPVS 虚拟主机，并设置这三个虚拟主机之间使用轮询模式 (rr) 来作为负载均衡策略  `ipvsadm -ln`
			- IPVS 在内核中的实现其实也是基于 Netfilter 的 NAT 模式，所以在转发这一层上，理论上 IPVS 并没有显著的性能提升。但是，IPVS 并不需要在宿主机上为每个 Pod 设置 iptables 规则，而是把对这些“规则”的处理放到了内核态，从而极大地降低了维护这些规则的代价
			-
	- 38. [从外联通service和service调试三板斧](https://time.geekbang.org/column/article/68964)
		- 通过service的nodeport来访问，还有lb来
		- 在理解了 Kubernetes Service 机制的工作原理之后，很多与 Service 相关的问题，其实都可以通过分析 Service 在宿主机上对应的 iptables 规则（或者 IPVS 配置）得到解决。
		- a. Service 没办法通过 DNS 访问到的时候解决？
			- 需要区分到底是 Service 本身的配置问题，还是集群的 DNS 出了问题。一个行之有效的方法，就是检查 Kubernetes 自己的 Master 节点的 Service DNS 是否正常
			- ```
			  # 在一个Pod里执行
			  $ nslookup kubernetes.default
			  如果上面访问 kubernetes.default 返回的值都有问题，那你就需要检查 kube-dns 的运行状态和日志了。否则的话，你应该去检查自己的 Service 定义是不是有问题。
			  ```
		- b. Service 没办法通过 ClusterIP 访问到的时候，你首先应该检查的是这个 Service 是否有 Endpoints：
			- `kubectl get endpoints hostnames`
			- 如果 Endpoints 正常，那么你就需要确认 kube-proxy
			- 如果 kube-proxy 一切正常，你就应该仔细查看宿主机上的 iptables 了。而一个 iptables 模式的 Service 对应的规则
	- 39. [servic和ingress](https://time.geekbang.org/column/article/69214)
		- {{embed ((65eecb93-e665-417f-b752-1d83c2e540b9))}}
		- ingress可以看做service的service
- #### k8s资源管理与作业调度
	- 40.[资源模型与资源管理](https://time.geekbang.org/column/article/69678)
		- Pod 是最小的原子调度单位。这也就意味着，所有跟调度和资源管理相关的属性都应该是属于 Pod 对象的字段
		- cpu和mem有request和limit：
			- 在调度的时候，kube-scheduler 只会按照 requests 的值进行计算。而在真正设置 Cgroups 限制的时候，kubelet 则会按照 limits 的值来进行设置。
		- cpu  '可压缩'资源
			- 设置的单位是“CPU 的个数”。比如，cpu=1 指的就是，这个 Pod 的 CPU 限额是 1 个 CPU，是1vcpu还是hyperthread，取决于cpu模式。
			- 设置为分数500Mm，500 millicpu，也就是 0.5 个 CPU，request.cpu
			- limit.cpu=500m，是cpu的上限，计算(500m/1000m)*100ms, cpu_period_us=100ms，就是最多使用50%cpu
			- limit=request，就是bind core，cpuset能力
		- 资源的Qos模型
			- request = limit，或只设置limit时候，就是guarenteed类       ----》 最后eviction
			- 不满足guarenteed，但是container有设置requests，那就是Burstable类   ----》 其次eviction
			- 啥也没设置就是BestEffort              -----》  eviction最先
			-
			- eviction:
				- 有个soft，hard； soft两分钟后还没减下来，才会eviction
				- 宿主机的 Eviction 阈值达到后，就会进入 MemoryPressure 或者 DiskPressure 状态，从而避免新的 Pod 被调度到这台宿主机上
			- `kubelet --eviction-hard=imagefs.available<10%,memory.available<500Mi,nodefs.available<5%,nodefs.inodesFree<5% --eviction-soft=imagefs.available<30%,nodefs.available<10% --eviction-soft-grace-period=imagefs.available=2m,nodefs.available=2m --eviction-max-pod-grace-period=600`
		-
		- 41. [Kubernetes默认调度器](https://time.geekbang.org/column/article/69890)
			- scheduler就是给pod找一个最合适的node
			- ![](https://static001.geekbang.org/resource/image/bb/53/bb95a7d4962c95d703f7c69caf53ca53.jpg?wh=1631*981){:height 262, :width 422}
			- 第一个控制循环Informer Path。它的主要目的，是启动一系列 Informer，用来监听（Watch）Etcd 中 Pod、Node、Service 等与调度相关的 API 对象的变化。比如，当一个待调度 Pod（即：它的 nodeName 字段是空的）被创建出来之后，调度器就会通过 Pod Informer 的 Handler，将这个待调度 Pod 添加进调度队列
			- 第二个控制循环Scheduling Path：
				- Scheduling Path 的主要逻辑，就是不断地从调度队列里出队一个 Pod。然后，调用 Predicates 算法进行“过滤”。这一步“过滤”得到的一组 Node，就是所有可以运行这个 Pod 的宿主机列表。当然，Predicates 算法需要的 Node 信息，都是从 Scheduler Cache 里直接拿到的，这是调度器保证算法执行效率的主要手段之一。
				- 打分node选中后，不会立马调用apiserver开始创建pod，不在关键调度路径里远程访问 APIServer，Kubernetes 的默认调度器在 Bind 阶段，只会更新 Scheduler Cache 里的 Pod 和 Node 的信息，交assume
				- assume后，启动一个async的goroutine 调用apisever更新pod
				- 他通过queue和cache打到了在调度路径上的无锁画能力
			- 默认调度器的可扩展机制，在 Kubernetes 里面叫作 Scheduler Framework。
		- 42. [默认调度器策略分析](https://time.geekbang.org/column/article/70211)’
			- predicates：从所有node中过滤出符合要求的
				- generalPredicates:  一组过滤规则，比如PodFitsResource，podFitsHost/Port/nodeselector
				- volume相关的过滤规则:
					- NoDiskConflict检查，比如重复mount
					- MaxPDVolumeCountPredicate:  某个node的pvc已经超过了一定数
					- VolumeZomePredicate: volume的zone，高可用能力
					- VolumeBindingPredicate ： nodeAffinity
				- 宿主机过滤规则： pod是否满足node自身的一些条件
					- PodToleratesNodeTaints： node的污点机制，只有pod的toleration和node的taint匹配才会调度
				- Pod相关的过滤规则：
					- PodAffinityPredicate/podAntAffinity： 检查pod和node上已有的pod亲和性
			- priorities: 在predicate过滤后，priority这个来打分
				- LeastRequestedPriority： 选空闲mem cpu嘴多的
				- BalancedResourceAllocation： 均衡策略
				- ImageLocalityPriority： image大的时候..
		- 43. [默认调度器的优先级与抢占机制](https://time.geekbang.org/column/article/70519)
			- pod调度失败，会被搁置，不会自动重新调度； 是否可以挤走某个，然后调度这个pod？
			- 要想抢占，必须提交一个priorityClass定义：globalDefault：false，只有申明使用该priorityCalss的pod值才是这个
				- pod的配置：spec.  priorityClassName: high-priority
			-
			-
