- {{renderer :tocgen2, [[]], auto, 1}}
- **CRI**（Container Runtime Interface）
	- 任何实现了这个接口的组件都可以作为 k8s 的容器实际控制者，Docker 只是其中之一，Docker  对于 K8S 不是必须的
- **master：集群的控制平面，负责集群的决策 ( 管理 )**
- > **ApiServer** : 资源操作的唯一入口，接收用户输入的命令，提供认证、授权、API注册和发现等机制
  **Scheduler** : 负责集群资源调度，按照预定的调度策略将Pod调度到相应的node节点上
  **ControllerManager** : 负责维护集群的状态，比如程序部署安排、故障检测、自动扩展、滚动更新等
  **Etcd** ：负责存储集群中各种资源对象的信息
- **node：集群的数据平面，负责为容器提供运行环境 ( 干活 )**
- collapsed:: true
  > **Kubelet** : 负责维护容器的生命周期，即通过控制docker，来创建、更新、销毁容器
  **KubeProxy** : 负责提供集群内部的服务发现和负载均衡
  **Docker** : 负责节点上容器的各种操作
	- ![](https://pic2.zhimg.com/80/v2-efb07df15509cc9a787cf302b77a2729_1440w.webp){:height 263, :width 496}
- #### 节点
	- 节点是组成容器集群的基本元素。节点取决于业务，可以为虚拟机或物理机。每个节点都包含运行 Pod 所需要的基本组件，包括 Kubelet、Kube-proxy 等
- #### Pod
	- Pod 是 Kubernetes 创建或部署的最小/最简单的基本单位，一个 Pod 代表集群上正在运行的一个进程，由[[#blue]]==一个或多个==容器组成
	- 在kubernetes中，Pod是最小的控制单元，但是kubernetes很少直接控制Pod，一般都是通过Pod控制器来完成的。Pod控制器用于pod的管理，确保pod资源符合预期的状态，当pod的资源出现故障时，会尝试进行重启或重建pod
	- > pod种类
		- deployment
		- Service可以看作是一组同类Pod**对外的访问接口**。借助Service，应用可以方便地实现服务发现和负载均衡
- #### 容器
	- 容器旨在让用户在相对独立的环境中运行独立的程序，一个节点可运行多个容器
- #### [](http://wiki.kubernetes.LW9hLWNtLQo=/summary/basic-conception.html#命名空间)  命名空间
	- 一个 Kubernetes 集群支持设置多个命名空间（Namesapce），每个命名空间相当于一个相对独立的虚拟空间，不同空间的资源相互隔离互不干扰。集群可通过命名空间对资源进行分区管理
- #### [Service](https://k8s.easydoc.net/docs/dRiQjyTY/28366845/6GiNOzyZ/C0fakgwO) Pod 层之上的负载均衡
	- 用户在 Kubernetes 中可以部署各种容器，其中一部分是通过 
	  HTTP、HTTPS 协议对外提供[[#red]]==七层网络服务，另一部分是通过 TCP、UDP 协议提供四层网络服务==。而 Kubernetes 
	  定义的服务（Service）资源是用来管理集群中[[$green]]==四层网络==的服务访问。基于四层网络，Service 提供了集群内容器服务的暴露能力
	- 通过配置标签，可以让 service 找到其后端实际 pod
	- Service 默认拥有一个 virtual ip(cluster ip)，直接访问这个 service ip 的时候，会将流量转发到后端的任意一个可用（通过配置 pod readiness） pod， 比如 etcd-0.etcd.default.svc
	- 使用 statefulset 的时候，有时候不需要使用自动负载均衡，可以设置 service.spec.clusterIP = None，访问服务的时候使用域名 <pod-name>.<service-name>.<namespace>来访问(指定pod)
	- 特点：
		- Service 通过 label 关联对应的 Pod
		- Servcie 生命周期不跟 Pod 绑定，不会因为 Pod 重创改变 IP
		- 提供了负载均衡功能，自动转发流量到不同 Pod
		- 可对集群外部提供访问端口
		- 集群内部可通过服务名字访问
	- [service里 type:](https://segmentfault.com/a/1190000040681763)
		- ```
		  kubectl get svc
		  demoapp-nodeport-svc   NodePort    127.x.0.1       <none>        80:31399/TCP   11s    
		  #可以看到两个prot 其中31399就是nodeport端口， clusterIp就一个
		  
		  demoapp-loadbalancer-svc   LoadBalancer   127.x.0.1    <pending>     80:31619/TCP   31s    
		  #可以看到因为不是Iaas平台上 EXTERNAL-IP一直为pending状态,表示一直在申请资源而挂起,依然可以通过NodePort的方式访问
		  ```
		- ClusterIP::   这个ip只能集群内访问; 默认模式，dns查询时返回service地址，具体那个pod是由iptables决定的
		- headless:: 不会分配clusterIp, dns查询会返回pod真实endpoint； 适合数据库（cluterip设置none就是)，loadbancler是云的ld
			- [特点](https://blog.csdn.net/qq_33709508/article/details/115491346):: client可自主选择用哪个pod；每个pod都有dns，可以pod之间互访，集群易可单独访问pod
			- 为什么需要headless? ① client想指定node访问 ②不是随机选pod ③不用service的lb、自己实现
			- 通过解析service的DNS([k8s的dns解析](https://www.lixueduan.com/posts/kubernetes/16-kubedns-workflow/))，返回所有Pod的地址和域名(statefulSet部署的Pod才有域名)
			-
		- NodePort::  NodePort是ClusterIP的增强类型，它会于ClusterIP的功能之外，在每个节点上使用一个相同的端口号将外部流量引入到该Service上来
			- 使用场景:
				- 从集群外访问svc，又不想搞个lb，nodeport可暴露ip+port访问。当然无lb能力，这里的ip是指node节点，不是pod的..
				  background-color:: indianred
				- 测试和开发中不想配置lb，那直接打通网路
				  background-color:: indigo
				- 私有环境下不能访问外部lb服务，那这个可以暴漏
				  background-color:: olivedrab
				- background-color:: slateblue
		- LoadBalancer: 是NodePort的增强类型，为各节点上的NodePort提供一个外部负载均衡器;需要公有云支持
		- ExternalName:外部流程引入到K8S内部,借助集群上KubeDNS来实现，服务的名称会被解析为一个CNAME记录，而CNAME名称会被DNS解析为集群外部的服务的TP地址,实现内部服务与外部服务的数据交互
		   ExternallP 可以与ClusterIP、NodePort一起使用 使用其中一个IP做出口IP
		- > 怎么外部temporary access  `kubectl port-forward service/test-k8s 8080:8080`
	- <a class="ask">怎么在集群外访问k8s集群</a>
		- NodePort
		- Ingress
		- LoadBalancer
- #### [StatefulSet](https://k8s.easydoc.net/docs/dRiQjyTY/28366845/6GiNOzyZ/mJvk9q5z)  [video](https://www.bilibili.com/video/BV1Tg411P7EB/?p=5&spm_id_from=pageDriver&vd_source=249f61d30b660d344f2a5b626a2ac64f)
  id:: 65eecb92-f7ae-467a-8cc8-b55c6713e0fd
	- [[$sub8]]==所启动的 pod 名称固定为 {statefulset-name}-{0..n-1}，n 为所设置的副本数==
	- [[$sub8-blue]]==Statefulset 每个 pod 在重启后的 pod name 都不会变化，可以根据这个来唯一识别一个有状态副本==
	- [[$sub8-red]]==StatefulSet通过创建固定标识的PVC保证Pod重新调度后还是能访问到相同的持久化数据。==
	- 特点：
		- statefulSet下的Pod有DNS地址,通过解析Pod的DNS可以返回Pod的IP   [example](https://www.cnblogs.com/chadiandianwenrou/p/11937041.html)   deployment下的Pod没有DNS
		- Service 的 `CLUSTER-IP` 是空的，Pod 名字也是固定的。
		- Pod 创建和销毁是有序的，创建是顺序的，销毁是逆序的。
		- Pod 重建不会改变名字，除了IP，所以不要用IP直连
	- ```
	  访问时，如果直接使用 Service 名字连接，会随机转发请求
	  要连接指定 Pod，可以这样pod-name.service-name
	  运行一个临时 Pod 连接数据测试下
	  kubectl run mongodb-client --rm --tty -i --restart='Never' --image docker.io/bitnami/mongodb:4.4.10-debian-10-r20 --
	  command -- bash
	  # 指定pod.service  
	  mongo -host mongodb-0.mongod
	  
	  # 报错 Error from server (AlreadyExists): pods "mongodb-client" already exists
	  @xx:~/k8s#kubectl delete pod mongodb-client  删除即可
	  kubectl rollout restart statefulset mongodb
	  ```
	- [为什么一般statefulset + headless service？](https://www.cnblogs.com/chadiandianwenrou/p/11937041.html)   [doc2](https://www.cnblogs.com/zhangpeiyao/p/17099494.html)
		- 1.headless service会为关联的Pod分配一个[[#red]]==域==          <service name>.$<namespace name>.svc.cluster.local
		  background-color:: darkgreen
		  2.StatefulSet会为关联的Pod保持一个[[#red]]==不变的Pod Name==         statefulset中Pod的hostname格式为(StatefulSet name)-(pod序号)
		  3.StatefulSet会为关联的[[#red]]==Pod分配一个dnsName==     <Pod Name>.<service name>.<namespace name>.svc.cluster.local
		- 常规pod也有一个dns:  `pod-ip-address.my-namespace.pod.cluster-domain.example` (ip中的.换成-，127-0-0-1) 这个会变但是statefulset和service是固定的
		  background-color:: grey
		- [statefulset和deplyoment区别](https://www.cnblogs.com/weifeng1463/p/10284122.html)  [[$sub8]]==重点理解statefulset的网络、pv、dns的稳定性、及滚动更新的一致性==
	- service不管是clusterIp还是headless的模式： 都不支持pod.<svc-name>.<ns>.svc.<k8s cluster-name>，但statefulset支持的
- #### daemonset
  id:: 65eecb92-6462-4d71-8042-1b3671d0376a
	- daemonset默认会在k8s集群每个node创建一个pod副本，可通过affinity来控制在哪个node：  kubect get nodes -L  xxx
- #### job
	- [cronjob](https://kubernetes.io/zh-cn/docs/tasks/job/automated-tasks-with-cron-jobs/)
	-
- #### endpoint
	- endpoints是一种kubernetes资源类型，它是namespace scoped
	- 有两种创建方式： [[$sub8-red]]==①随service被创建：  ②将外部服务的endpoint添加到endpoints对象，可以使用kubernetes service访问[外部服务](https://segmentfault.com/a/1190000040829553)==
	- > 比如，开发阶段提供了一个mysql服务svc，但是没创建pod，此时接着创建一个endpoint，可以将endpoint执行外部服务或者本地拉起的mysql测试，或者docker拉起的container。
- ### DNS服务
	- k8s集群内部app可通过service或pod的ip直接访问，通过dns可以忽略pod和service变化
	- DNS服务为集群内每个服务分配一个dns名称，dns自身也有一个
	- DNS 查询可以使用 Pod 中的 `/etc/resolv.conf`
	- svc的dns：  ``<svc name>.<namespace>.svc.cluster.local``    cluster.local是k8s集群名， /etc/kubernetes/kubelet.conf
	- TODO  root@vebackup-mgr-56b947b66d-m6pp4:/opt/tiger/vebackup-mgr# [[#red]]==host vebackup-mgr/agent/vault都通==
		- `vebackup-mgr.vebackup.svc.storage-cp.org has address 10.96.x.x`
		  id:: 64d45f4c-02f3-41f9-93a1-dc379e1e2a42
		- 底座和其他pod内不能简单解析dns `vebackup-mgr`， 但可解析全dns `vebackup-mgr.vebackup.svc.storage-cp.org`？，vebackup的mgr中DNS简单前缀可通work、agent和vault是有什么地方打通？
	-
- #### [数据持久化](https://k8s.easydoc.net/docs/dRiQjyTY/28366845/6GiNOzyZ/Q2gBbjyW)    [video](https://www.bilibili.com/video/BV1Tg411P7EB/?p=6&spm_id_from=pageDriver&vd_source=249f61d30b660d344f2a5b626a2ac64f)
	- hostPath 挂载示例,   把节点上的一个目录挂载到 Pod，但是已经不推荐使用了，[文档](https://kubernetes.io/zh/docs/concepts/storage/volumes/#hostpath)
		- 配置方式简单，需要手动指定 Pod 跑在某个固定的节点。
		- 仅供单节点测试使用；不适用于多节点集群
	- 更高级抽象
		- Storage Class (SC)
			- > 将存储卷划分为不同的种类，例如：SSD，普通磁盘，本地磁盘，按需使用。
		- Persistent Volume (PV)
			- > 描述卷的具体信息，例如磁盘大小，[访问模式](https://kubernetes.io/zh/docs/concepts/storage/persistent-volumes/#access-modes)。[文档](https://kubernetes.io/zh/docs/concepts/storage/persistent-volumes/)，[类型](https://kubernetes.io/zh/docs/concepts/storage/persistent-volumes/#types-of-persistent-volumes)，[Local 示例](https://kubernetes.io/zh/docs/concepts/storage/volumes/#local)
		- Persistent Volume Claim (PVC)
			- 对存储需求的一个申明，可以理解为一个申请单，系统根据这个申请单去找一个合适的 PV
			- 还可以根据 PVC 自动创建 PV。
- #### [ConfigMap & Secret](https://k8s.easydoc.net/docs/dRiQjyTY/28366845/6GiNOzyZ/YJf8LMtE) [[ConfigMap]]
	- ```bash
	  export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace default my-release-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)
	  
	  # To connect to your database, create a MongoDB&reg; client container:
	  kubectl run --namespace default my-release-mongodb-client --rm --tty -i --restart='Never' --env="MONGODB_ROOT_PASSWORD=$MONGODB_ROOT_PASSWORD" --image docker.io/bitnami/mongodb:6.0.6-debian-11-r3 --command -- bash
	  
	  /var/run/secrets/kubernetes.io/serviceaccount/token  pod访问k8s api的密钥
	  ```
- #### [Helm & 命名空间](https://k8s.easydoc.net/docs/dRiQjyTY/28366845/6GiNOzyZ/3iQiyInr)
	- > 可以理解为是一个软件库，可以方便快速的为我们的集群安装一些第三方软件
	- id:: 64a8227f-be62-49a3-9e49-9d81ef21ff3d
	  ```shell
	  # 安装
	  helm repo add bitnami https://charts.bitnami.com/bitnami
	  helm install my-mongo bitnami/mongodb
	  
	  # 指定密码和架构
	  helm install my-mongo bitnami/mongodb --set architecture="replicaset",auth.rootPassword="mongopass"
	  
	  # 删除
	  helm ls
	  helm delete my-mongo
	  
	  # 查看密码
	  kubectl get secret my-release-mongodb -o json
	  kubectl get secret my-mongo-mongodb -o yaml > secret.yaml
	  
	  # 临时运行一个包含 mongo client 的 debian 系统
	  kubectl run mongodb-client --rm --tty -i --restart='Never' --image docker.io/bitnami/mongodb:4.4.10-debian-10-r20 --command -- bash
	  
	  # 进去 mongodb
	  mongo --host "my-mongo-mongodb" -u root -p mongopass
	  
	  # 也可以转发集群里的端口到宿主机访问 mongodb
	  kubectl port-forward svc/my-mongo-mongodb 27017:27018
	  ```
- #### k8s提供了三种资源管理方式  [doc](https://juejin.cn/post/7063274870137683975)
	- [[#red]]==命令式对象管理==：直接使用命令去操作kubernetes资源
		- `kubectl run nginx-pod --image=nginx:1.17.1 --port=80`
	- [[#red]]==命令式对象配置==：通过命令配置和配置文件去操作kubernetes资源.  就是使用[[$red]]==命令配合配置文件==一起来操作kubernetes资源
		- `kubectl create/patch -f nginx-pod.yaml`
	- [[#red]]==声明式对象配置==：通过apply命令和配置文件去操作kubernetes资源
		- `kubectl apply -f nginx-pod.yaml`
	- #### **声明式与命令式：定义**
		- 声明性的东西是对最终结果的陈述，表明意图而不是实现它的过程。在 Kubernetes 中，这就是说“应该有一个包含三个 Pod 的 ReplicaSet”。
		- 命令式充当命令。声明式是被动的，而命令式是主动且直接的：“创建一个包含三个 Pod 的 [[ReplicaSet]]”。
		- Kubernetes 生态系统提供了以这两种形式与您的集群交互的机制。命令式方法由 CLI 命令和单独的 YAML 文件提供。使用组合成最终资源表示的文件目录来促进声明式配置
		- 当 Kubernetes 使用命令式命令时，需要准确地告诉它要做什么。因此，[[$red]]==无法选择性地仅应用 YAML 的更改部分==。为此，您需要切换到声明式操作。 比如，你要把replica改多，那你要用声明式kube会自动跳转如果没有创建，有就扩。
-
