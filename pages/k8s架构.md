- {{renderer :tocgen2, [[]], auto, 1}}
- ### apiserver
	- REST API 层，无状态，用于接收请求，身份认证，类型转换，准入控制(admission-controller)等
	- k8s 的请求是声明式的，经过 apiserver 校验通过之后就会存入 etcd，作为目标状态
- ### controller-manager
	- 实际控制 [[k8s]] 几乎所有资源生命周期的组件，将资源的状态同步至目标状态，达到最终一致性
	- 例如创建一个 deployment，声明的 replica 数量为 5，但现有 2 个， controller-manager 会增加副本，以达到目标状态
	- 例如删除一个 namespace，仅需调用 apiserver 相应的删除接口，apiserver 标记成 terminating 状态，之后 controller 会负责删除该 namespace 下所属的所有资源
- ### scheduler
	- 调度器，所有 pod 的调度都需要经过 scheduler。可以外接 webhook，或自己定制化开发一个调度器，多个调度器可以同时运行
	- 调度器在调度的时候会经过预选、优选两个阶段：
		- 预选：根据标签匹配、require 亲和性、节点剩余资源、资源需求过滤掉一定不满足要求的节点
		- 优选：对每台节点进行打分，内容包括 prefer 亲和性，节点压力，PV 是否已经挂载等进行打分并排序
	- 调度完之后会将 pod 的 node 字段进行修改，存入 etcd
- ### kubelet
	- 每台节点上都存在的一个 agent 组件，一般由 systemd 启动
	- 负责实际启动 pod 内的容器
	- 当 kubelet 发现自己节点上被调度到了新 pod 之后，会调用 CRI（Container Runtime Interface，可能是 docker，也可能是其他，只要实现了这个接口即可），拉取镜像并启动 pod 内的容器、挂载 PV 等
- ### kubeproxy
	- 负责负载均衡，service（k8s 资源） 到 pod 的流量转发等，通过 iptables 或 IPVS 实现
	- 例如当我们通过 service 的 cluster ip 访问一个服务时，就是由 kubeproxy 获取这个 service ip 后端实际的 pod，做流量转发的负载均衡
- ### Coredns
	- k8s 域名解析的核心服务，用于解析所有 k8s 内部域名
	- 内部域名格式形如 etcd-0.etcd.rds.svc.cluster.local
	-
- ### 常见资源类型和概念
- 可以通过指定 hostNetwork 让该 pod 使用宿主机网络
  Resource request & limit
- Pod 内的每一个容器都可以指定相应的 cpu/memory 的 request 和 limit
- Request 表示最低需求，用于在调度的时候做筛选
- Limit 表示资源使用上限，如果内存使用超过 limit，则会触发 OOM(Out Of Memory)，容器被杀
  无状态集 Deployment
- 声明一个含有多个副本的服务，通过 pod template 和 replica 来创建多个相同的无状态服务
- kubectl scale --replicas=3 deployment/nginx可以动态地对 deployment 进行扩缩容
- 里面的每个 pod 每次启动的 pod name 都是随机的，不应该依赖于 pod name
- 仅使用 deployment 部署无状态服务
  有状态集 [[Statefulset]]
- 声明一个含有多个副本的服务，通过 pod template 和 replica 来创建多个有状态服务实例
- 所启动的 pod 名称固定为 {statefulset-name}-{0..n-1}，n 为所设置的副本数
- Statefulset 每个 pod 在重启后的 pod name 都不会变化，可以根据这个来唯一识别一个有状态副本
- StatefulSet通过创建固定标识的PVC保证Pod重新调度后还是能访问到相同的持久化数据。
- Service
- Pod 层之上的负载均衡
- 通过配置标签，可以让 service 找到其后端实际 pod
- Service 默认拥有一个 virtual ip(cluster ip)，直接访问这个 service ip 的时候，会将流量转发到后端的任意一个可用（通过配置 pod readiness） pod
- etcd-0.etcd.default.svc
- 使用 statefulset 的时候，有时候不需要使用自动负载均衡，可以设置 service.spec.clusterIP = None，访问服务的时候使用域名 <pod-name>.<service-name>.<namespace>来访问
  Job
- 负责批量处理短暂的一次性任务，即仅执行一次的任务，保证批处理任务的一个或多个pod成功结束
- Job管理的pod根据用户设置把任务成功完成后就自动退出（pod自动删除）。
  持久化存储 PV, PVC, StorageClass
  Pod 内保存的数据都是临时的，在容器退出之后就会消失，如果需要持久化，需要使用 PV/PVC
- PV
	- PV 是持久化存储，指定一块网络存储（可支持大多数主流网络存储）或本地卷
	- 可声明这块存储可使用的最大空间，和访问模式
	- 可以配置回收策略，当 PV 与 PVC 解绑之后，可保留或删除上面的数据
	- 可以配置 storageClass，表示这个 PV 属于哪一类资源
- PVC
	- PVC 是对一个 PV 的使用的声明，包括了所需要的容量，和访问模式等
	- 创建一个 PVC 之后，会根据 PVC 中定义的容量要求、label 去寻找一块满足条件的 PV 进行绑定
- storageClass
	- 表示一个存储类型，PV 创建时可指定 storageClass，PVC 也可以指定所需要的 storageClass，绑定的时候只会绑定同一个 storageClass 的 PV
	  id:: 654d974e-5449-4712-ab82-eb1f8e0dde8c
	- 一些存储插件实现了 storageClass 的 controller，可以在 PVC 找不到符合需求的 PV 的时候，动态地创建一个
	  RBAC
	  RBAC 是用于 k8s 权限管理的一种规则，包含几种资源：
- role
	- 角色，角色内可以指定该角色对哪一些资源（需要指定 apigroup, resource，可用通配符 "*"）有哪些访问操作（get, list, update, delete）权限
- clusterRole
	- 类似 role，但没有 namespace 概念，用于全局资源的权限管理
- serviceAccount
	- 服务账户，可以理解为一个“操作者”
	- 每个 namespace 下面会有一个默认的 serviceAccount，如果需要，可以自己创建
	- 一般一个服务使用一个 serviceAccount，而不是直接使用 admin。不同服务由于所需要的权限不同，为了防止 bug 或误操作影响无关的资源，需要用不同 sa 隔离开
- rolebinding & clusteRolebinding
	- 用于将 role/clusterRole 和 serviceAccount 进行绑定
	  三大类资源之间的关系为：
	  role/clusterRole  <---- rolebinding/clusterRolebinding ----> serviceAccount
	  
	  
	  常见问题和排查方法
	  如何通过域名来访问一个服务
- 对于普通 service，可以访问：<service-name>.<namespace>，例如：rds-zookeeper.default
- 对于 headless service，访问指定 pod：<pod-name>.<service-name>.<namespace>，例如：rds-mysql-0.rds-mysql.rds
  通过域名访问服务时无法解析
- 检查 service 是否存在
- 查看 service 后端时候获取到相应的 endpoints：kubectl get endpoint <service-name>，如果没有，检查 label 是否配置错误
- Core dns IP 怎么看：kubectl get svc -n kube-system
- 检查 pod 内的 /etc/resolve.conf文件，nameserver 和 search 是否正常。当使用 hostnetwork 模式启动 pod 的时候，这个文件可能会直接使用宿主机的配置，可以配置dnsPolicy: ClusterFirstWithHostNet来使用 k8s 的 DNS 配置，完整配置：
  ```
  apiVersion: apps/v1
  kind: StatefulSet
  metadata:
  name: {{.InstanceID}}
  spec:
  selector:
    matchLabels:
      app: {{.InstanceID}}
  serviceName: {{.InstanceID}}
  template:
    metadata:
      labels:
        app: {{.InstanceID}}
    spec:
  ````
- ### ClusterFirstWithHostNet 和 hostNetwork 一起使用，在使用宿主机网络的同时，使用 k8s DNS
      dnsPolicy: ClusterFirstWithHostNet
      initContainers:
	- name: init-mysql
	  ...
	  
	  在 POD 内服务无法访问 K8S
- xxxx is forbidden: User "system:serviceaccount:ck:default" cannot get resource "nodes" in API group "" at the cluster scope
  原因是 RBAC 没有正确设置
- 检查该 pod 所使用的 serviceAccount（默认为 <namespace>:default，可自定义）
- 检查 role/clusterRole/rolebinding/clusterRolebinding 是否对需要访问的资源配置了正确的权限
  Pod 处于 pending 状态
- 查看调度信息：kubectl describe pod <pod-name> 可看到调度信息，一般 pending 状态的 pod 都是因为节点不可用导致，如磁盘不够 disk-pressure，cpu、memory 不足等
- kubectl describe node <node-name> 可以查看节点情况，重点关注
	- taints字段。在磁盘空间不足等一些情况下，k8s 会给 node 打上形如 Taints:  node.kubernetes.io/disk-pressure:NoSchedule的信息。对于有污点 taints的节点，只有配置了污点容忍的 pod 才能调度到这台节点
	- cpu/memory 使用情况
- 查看节点是否被标记为不可调度
- >>> kubectl get nodes                                                            NAME           STATUS                     ROLES    AGE   VERSION
  n225-135-077   Ready,SchedulingDisabled   <none>   25d   v1.18.10
  n225-135-088   Ready                      <none>   13d   v1.18.10
  n225-135-099   Ready                      <none>   25d   v1.18.10
  如果确认有节点可以调度，且 describe 出来没有调度错误，需要考虑 scheduler 是否有问题，可以查看调度器日志等信息
- kubectl top node 可以看集群里所有节点的 cpu/memory 信息
  禁止调度一台节点
  在进行亲和性测试的时候可能想要让某台节点不可调度
- kubectl cordon <node-name> 禁止调度
- kubectl uncordon <node-name> 恢复调度
  让同一个服务的不同 pod 调度到不同节点
- 给该服务的 pod 配置 label
- 配置 pod 亲和性。例如：
  apiVersion: apps/v1
  kind: StatefulSet 
  metadata: 
  name: rds-mysql
  spec: 
  selector: 
    matchLabels: 
      app: mysql
  serviceName: rds-mysql
  template:
    metadata: 
      labels: 
        app: mysql # 配置每个 pod 都拥有的 label
    spec:
- # pod 亲和性，当某台节点存在“拥有此 label 的 pod”时，不往上面调度
      affinity:
        podAntiAffinity: 
          requiredDuringSchedulingIgnoredDuringExecution: # 强制性的，还有 prefer 策略，会影响调度时的节点打分
	- labelSelector:
	    matchExpressions:
		- key: app
		  operator: In
		  values:
			- mysql
			  topologyKey: "kubernetes.io/hostname"
			  一个镜像的同一个 tag，拥有多个版本，怎么使用最新的
			  这种情况一般发生在自己开发测试的时候，会自己反复把一个镜像打到同一个标签
			  可以配置镜像拉取策略为 Always：
			  containers:
	- name: mysql
	  image: rds-tob/rds-mysql:127.x.0.1
	  imagePullPolicy: Always
	  resources:
	    requests:
	      cpu: 100m
	      memory: 1Gi
	  创建了5个副本 deployment，却出现了10个 pod，其中几个马上 terminating
	  一般是 controller-manager 的问题，如在高可用方案下出现多主情况
