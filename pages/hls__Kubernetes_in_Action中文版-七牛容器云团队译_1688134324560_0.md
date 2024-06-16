file:: [Kubernetes_in_Action中文版-七牛容器云团队译_1688134324560_0.pdf](../assets/Kubernetes_in_Action中文版-七牛容器云团队译_1688134324560_0.pdf)
file-path:: ../assets/Kubernetes_in_Action中文版-七牛容器云团队译_1688134324560_0.pdf

- `关于代码`
  ls-type:: annotation
  hl-page:: 2
  hl-color:: red
  id:: 649ee31d-8d52-4b53-95da-aa7200f9585d
	- YAML清 单可以在 https：句 github.co m/ luksa/kub emetes-in-action找到
	  ls-type:: annotation
	  hl-page:: 2
	  hl-color:: green
	  id:: 649ee30c-00d3-44e2-a945-f327b881cb23
- ### 第一章. Kubernetes 介绍
  hl-page:: 21
  ls-type:: annotation
  background-color:: blue
  id:: 649ee33a-cb27-4fa3-aa64-a1dd9b313f52
  hl-color:: red
	- hl-page:: 21
	  ls-type:: annotation
	  id:: 649ee3c8-0152-491f-bfdb-900aad102b15
	  hl-color:: green
	  > <span class="subw8">Kubemetes 抽象了数据中心的硬件基础设施，使得对外暴露的只是 一 个巨大的资源地</span>
	- #### 1.1 Kubernetes 系统的需求
	  ls-type:: annotation
	  hl-page:: 21
	  hl-color:: blue
	  id:: 649ee3eb-088e-4752-b1bb-1def836a1fb1
		- 将应用拆解为多个微服务
		  ls-type:: annotation
		  hl-page:: 22
		  hl-color:: red
		  id:: 649ee4c9-8017-480c-95dd-d8c6959dd269
		- 微服务还带来其他问题
		  ls-type:: annotation
		  hl-page:: 23
		  hl-color:: yellow
		  id:: 64a797e3-3e72-4e9e-aecb-0e289c7f867e
			- [[Zipkin]]这样的[[分布式]]定位系统解决
			  hl-page:: 24
			  ls-type:: annotation
			  id:: 64a797f0-9ef5-4de1-8859-c38d21eddd21
			  hl-color:: green
			- 环境需求的差异
			  ls-type:: annotation
			  hl-page:: 24
			  hl-color:: purple
			  id:: 64a79899-40dc-4ec7-ae4e-bbf02c8c87bc
				- 部署动态链接的应用需要不同版本的共享库，或者需要其他特殊环境
				  ls-type:: annotation
				  hl-page:: 24
				  hl-color:: green
				  id:: 64a798a8-36bc-4629-9b9f-f176e35d7243
		- 1.1.2 为应用程序提供一个一致的环境
		  hl-page:: 24
		  ls-type:: annotation
		  id:: 64a798d3-f606-4828-ba98-ea7b24086c37
		  hl-color:: red
			- 为了减少仅会在生 产环境 才暴露的问题，最理想的做法是让应用在开发和生产阶段可以运行在完 全一样 的 环境下
			  ls-type:: annotation
			  hl-page:: 25
			  hl-color:: green
			  id:: 64a79928-116b-4234-be89-22dddd33688a
		- 1.1.3 迈向持续交付 ： DevOps 和 无 运维
		  hl-page:: 25
		  ls-type:: annotation
		  id:: 64a79933-aaae-4bb1-9c0d-0f974514f50a
		  hl-color:: red
	- 1.2 介绍容器技术
	  ls-type:: annotation
	  hl-page:: 26
	  hl-color:: red
	  id:: 64a79cd4-4141-4161-80f7-f56f592b9c31
		- Kubernetes 能让我们实现所有这些想法。 通过对实际硬件做抽象， 然后将自身暴露成一个平台， 用于 部署和运行应用程序。 它允许开发者自己配置和部署应用程序， 而不需要系统管理员的任何帮助， 让系统管理员聚焦于保持底层基础设施运转正常的同时， 不需要关注实际运行在平台上的应用程序
		  ls-type:: annotation
		  hl-page:: 26
		  hl-color:: green
		  id:: 64a79d00-5c82-4ee6-a1a4-fe141f8f9eff
		- 1.2.1 什么是容器
		  ls-type:: annotation
		  hl-page:: 26
		  hl-color:: red
		  id:: 64a79d33-5e03-4d82-942b-0f3be20e1d97
			- 容器里运行的进程实际上运行在宿主机的操作系统上， 就像所有其他进程一样（不像虚拟机， 进程是运行在不同的操作系统上的）。 但在容器里的进程仍然是和其他进程隔离的。 对于容器内进程本身而言， 就好像是在机器和操作系统上运行的唯一一个进程。
			  ls-type:: annotation
			  hl-page:: 26
			  hl-color:: green
			  id:: 64a79e02-9975-4f3e-8fe4-503ed72a3d7e
			- 比较虚拟机和容器
			  ls-type:: annotation
			  hl-page:: 27
			  hl-color:: red
			  id:: 64a79e0b-9981-4c8b-8b94-e1d6014aae98
			- 和虚拟机比较， 容器更加轻量级， 它允许在相同的硬件上运行更多数量的组件。主要是因为每个虚拟机需要运行自己的一 组系统进程， 这就产生了除组件进程消耗以外的额外计算资源损耗。 从另 一 方面说， 一个容器仅仅是运行在宿主机上被隔离的单个进程， 仅消耗应用容器消耗的资源， 不会有其他进程的开销。
			  ls-type:: annotation
			  hl-page:: 27
			  hl-color:: green
			  id:: 64a79e21-1680-49ca-bf72-555dfece1592
			- 虚拟机的主要好处是它们提供完全隔离的环境， 因为每个虚拟机运行在它自己的 Linux 内核上， 而容器都是调用同 一个内核， 这自然会有安全隐患。
			  ls-type:: annotation
			  hl-page:: 28
			  hl-color:: green
			  id:: 64a79e99-7307-4029-9b1b-6d656cbe7036
		- 1.2.2 Docker容器平台介绍
		  ls-type:: annotation
		  hl-page:: 30
		  hl-color:: red
		  id:: 64b7f5d4-6de5-4585-9e6a-e223faaf60c2
			- 基于 Docker 容器的镜像和虚拟机镜像的一个很大的不同是容器镜像是由多层构成， 它能在多个镜像之间共享和征用。
			  ls-type:: annotation
			  hl-page:: 30
			  hl-color:: red
			  id:: 64bd0ae8-0c78-4e9b-a3bf-4b828a7495de
- #### 第七章： [[ConfigMap]]和Secre配置应用程序
  hl-page:: 214
  ls-type:: annotation
  id:: 64c3a950-1b57-41d0-8c4d-5744b7765f52
  hl-color:: red
  background-color:: blue
	- 7.1 配置容器化应用程序
	  ls-type:: annotation
	  hl-page:: 214
	  hl-color:: green
	  id:: 64c3a99b-0122-4fe0-bc61-901d8f2638a1
		- 一种通用的传递配置选项给容器化应用程序的方法是借助环境变量。
		  ls-type:: annotation
		  hl-page:: 215
		  hl-color:: blue
		  id:: 64c3a9c1-bd78-4481-97af-ebc07baedf03
		- 为何环境变量的方案会在容器环境下如此常见？通常直接在Docker 容器中采用配置文件的方式是有些许困难的， 往往需要将配置文件打入容器镜像， 抑或是挂载包含该文件的卷。
		  ls-type:: annotation
		  hl-page:: 215
		  hl-color:: purple
		  id:: 64c3a9db-533f-4a0c-9546-46f3e0b62805
		- 用以存储配置数据的Kubernetes资源称为[[ConfigMap]]。
		  ls-type:: annotation
		  hl-page:: 215
		  hl-color:: green
		  id:: 64c3aa0a-e60c-40bf-9980-fb36858208ad
			- <span class="subw9">传递命令行参数
			  container设置自定义环境var
			  通过特殊类型的卷将配置文件挂载到容器中</span>
	- 7.2 向容器传递命令行参数
	  ls-type:: annotation
	  hl-page:: 215
	  hl-color:: red
	  id:: 64c3aa88-d278-4aba-b078-55cb03934e3c
		- 7.2.1 在Docker中定义命令与参数
		  ls-type:: annotation
		  hl-page:: 215
		  hl-color:: green
		  id:: 64c3aaa5-545b-49d3-b5ff-01b127d45f8d
			- 了解ENTRYPOINT与CMD
			  ls-type:: annotation
			  hl-page:: 216
			  hl-color:: blue
			  id:: 64c3aab5-79e6-4970-b546-a42728616015
			- [[#red]]==了解shell与exec形式的区别==
			  ls-type:: annotation
			  hl-page:: 216
			  hl-color:: red
			  id:: 64c3abaa-7c5b-426a-a1f6-74cab2382c0c
				- • shell形式一如ENTRYPOINT node app.js。
				- • exec形式一如ENTRYPOINT ["node", "app. js"]。
				- {{embed ((64c3ae6f-f375-4ee7-9dd4-61892e806f1e))}}
			- 可配置化fortune镜像中的间隔参数, 命令加参数cmd ['p1', 'p2']
			  hl-page:: 217
			  ls-type:: annotation
			  id:: 64c3ac77-9ecf-4fd0-8e9f-e62c1d72ef7d
			  hl-color:: red
		- 7.2.2 在 Kubernetes 中覆盖命令和参数
		  ls-type:: annotation
		  hl-page:: 218
		  hl-color:: red
		  id:: 64c3b095-488c-4d92-bef5-43db80170506
			- Kubemetes 中定义容器时， 镜像的 ENTRY POINT 和 CMD 均可以被覆盖， 仅需在容器定义中设置属性 [[#red]]==command== 和 [[#red]]==args== 的值
			  hl-page:: 218
			  ls-type:: annotation
			  id:: 64c3b0a6-b1a0-4be3-9eef-7a692cbc9874
			  hl-color:: green
	- 7.3 为容器设置环境变量
	  ls-type:: annotation
	  hl-page:: 219
	  hl-color:: red
	  id:: 64dc59b2-0aa5-452d-adda-c6b9907ae631
		- 7.3.1 在容器定义中指定环境变量
		  ls-type:: annotation
		  hl-page:: 220
		  hl-color:: green
		  id:: 64dc59ed-b210-4c7e-b1c5-ce1190158bc7
		- 7.3.2 在环境变量值中引用其他环境变量  $(var)
		  hl-page:: 220
		  ls-type:: annotation
		  id:: 64dc5a3b-6769-4313-8101-7200b82ed3fa
		  hl-color:: green
		- 7.3.3 了解硬编码环境变量的不足之处
		  ls-type:: annotation
		  hl-page:: 221
		  hl-color:: green
		  id:: 64dc5a58-1b46-4f36-800e-a51ee0e55242
		- 可 以 通过 一 种叫作 [[ConfigMap]] 的 资源对象完成解楠，用 valueFrom 宇段替代 value 字 段使 ConfigMap 成为环境变 量 值的来源
		  hl-page:: 221
		  ls-type:: annotation
		  id:: 64dc5aaf-781f-40ed-83df-f8a2eb6b1eed
		  hl-color:: blue
	- 7.4 利用 ConfigMap 解相配置
	  ls-type:: annotation
	  hl-page:: 221
	  hl-color:: red
	  id:: 64dc5ac3-f01f-46b4-ad18-6e8a848cc27b
		- 应用配置的关键在于能够在多个环境中区分配置边项，将配置从应用程序源码中分离，可频繁变更配置值 
		  ls-type:: annotation
		  hl-page:: 221
		  hl-color:: red
		  id:: 64dc5ad6-1fdd-4b93-a323-a63d1292b298
		- 7.4.1 **ConfigMap** 介绍
		  ls-type:: annotation
		  hl-page:: 221
		  hl-color:: red
		  id:: 64dc5add-1b82-4bd4-af93-79c94ad85385
			- 允 许将配置选项分离到单独的资源对象 C onfigMap 中， 本质上就是一 个键 ／ 值对映射，值可以是短字面 量 ，也可以是完整的配置文件
			  ls-type:: annotation
			  hl-page:: 221
			  hl-color:: green
			  id:: 64dc5aee-0f7e-4870-99fa-dd8caa127601
			- 应用无须直接读取 ConfigMap ， 甚至根本不需要知道其是否存在。映 射的内 容通过环境变 量 或者卷文件（如图 7.2 所示）的形式传递给容器
			  ls-type:: annotation
			  hl-page:: 221
			  hl-color:: blue
			  id:: 64dc5af9-0699-4e2f-b469-474958344473
			- 而并非直接传递给容器 。 命令行 参 数的定义中可 以通过 $ （ ENV VAR ）语 法 引用环 境变量，因 而可以达到将 ConfigMap 的条目当作命令行参数传递给进程的效果
			  ls-type:: annotation
			  hl-page:: 221
			  hl-color:: green
			  id:: 64dc5b0e-e055-4f88-9510-fa9cdeda093c
			- pod 通过环境变 量 与 ConfigMap 卷使用 ConfigMap
			  ls-type:: annotation
			  hl-page:: 222
			  hl-color:: blue
			  id:: 64dc5b26-376c-44c9-91f0-6a27e717bc6e
		- 7.4.2 创建 ConfigMap
		  ls-type:: annotation
		  hl-page:: 222
		  hl-color:: red
		  id:: 64dc5b5a-6af2-4956-933f-620442ad0917
			- `kubectl create configmap fortune-config  --from-literal=sleep-interval=25`
			- ```
			  kubectl get configmap fortune-config -o yaml
			  apiVersion: v1
			  data:
			    sleep-interval: "25"
			  kind: ConfigMap
			  metadata:
			    creationTimestamp: "2023-08-16T05:17:30Z"
			    name: fortune-config
			    namespace: default
			    resourceVersion: "29495063"
			  ```
			- `kubectl create - f   fortune -onfig. yaml`
			- kubectl create configmap my-config -from-file=customkey=config file.conf
			  ls-type:: annotation
			  hl-page:: 224
			  hl-color:: green
			  id:: 64dc5cb3-1b42-4d86-b18c-17cebd0b264c
			- 合并不同选项，就是从文件、文件夹、cmd上创建
			  hl-page:: 224
			  ls-type:: annotation
			  id:: 64dc5d22-d093-41dd-b9e6-213d9bee1280
			  hl-color:: red
		- 7.4.3 给容器传递 ConfigMap 条目作为环境变量
		  ls-type:: annotation
		  hl-page:: 225
		  hl-color:: red
		  id:: 64dc5d35-bf29-4683-bea6-1f899a8aacbb
			- [:span]
			  ls-type:: annotation
			  hl-page:: 226
			  hl-color:: yellow
			  id:: 64dc5d6b-1478-4f5d-aab1-7292a2513cc1
			  hl-type:: area
			  hl-stamp:: 1692163463635
		- 7.4.4 一次性传递 ConfigMap 的所有条目作为环境变量
		  ls-type:: annotation
		  hl-page:: 227
		  hl-color:: green
		  id:: 64dc5ded-1da7-4515-a269-469f48be36fc
			- ```
			  envFrom:
			  	- prefix: CONFIG_     // config_开头的都被选中
			      configmapRef:
			      	name:  xxx-config-map
			  ```
		- 7.4.5传递 ConfigMap条目作为命令行参数，如何将configmap参数给容器？
		  hl-page:: 228
		  ls-type:: annotation
		  id:: 64dc5e68-1193-4514-8755-dbc76ab4cfa5
		  hl-color:: red
			- 宇段 pod. spec.containers.args中无法直接引用 [[ConfigMap]]的条目，但是可以利用 ConfigMap条目初始化某个环境变量，然后再在参数字段中引用该环境变量，
			  hl-page:: 228
			  ls-type:: annotation
			  id:: 64e2eea8-c938-42f1-a586-999a73bfa909
			  hl-color:: green
				- ((64dc5d35-bf29-4683-bea6-1f899a8aacbb))
					- args: [$(INTERVAL)]即可使用
		- 7.4.6使用 [[#red]]==configMap卷==将条目暴露为文件
		  hl-page:: 229
		  ls-type:: annotation
		  id:: 64e2efa0-3068-4fe6-acd0-3acfc7b37e12
		  hl-color:: blue
			- > 就是将configmap作为volume，再mount到pod中即可
			- ConfigMap中可以包含完整的配置文件内容，当你想要将其暴露给容器时，可以借助前面章节提到过的一种称为 configMap卷的特殊卷格式
			  ls-type:: annotation
			  hl-page:: 229
			  hl-color:: green
			  id:: 64e2efba-44e1-4d7f-a248-b1ffffdd8227
				- `kubectl create configmap fortune-config --from-file=configmap files`
			- [[#red]]==所有条目第一行最后的管道符号|表示后续的条目值是多行字面量。==
			  hl-page:: 230
			  ls-type:: annotation
			  id:: 64e2f086-38bd-4edc-9399-3ae97af275e8
			  hl-color:: red
			- 卷内暴露指定的ConfigMap条目
			  ls-type:: annotation
			  hl-page:: 232
			  hl-color:: red
			  id:: 64e2f122-6cf1-480b-b482-c25937049ea6
				- ```
				  volumes:
				  	-name: config
				       configMap:
				       	name: xxx-config
				          items:
				          	- key: nginx-config.conf
				              path: gzip.conf
				  ```
			- [[#red]]==挂载某一文件夹会隐藏该文件夹中已存在的文件==
			  ls-type:: annotation
			  hl-page:: 233
			  hl-color:: red
			  id:: 64e2f17e-2703-4f40-8f8a-f7f20b7c4f0f
				- ConfigMap独立条目作为文件被挂载且不隐藏文件夹中的其他文件
				  ls-type:: annotation
				  hl-page:: 233
				  hl-color:: green
				  id:: 64e2f1f6-887e-47d5-9b58-6d24455ce77a
				- volumeMount额外的[[$sub8-blue]]==subPath==字段可以被用作挂载卷中的某个独立文件或者是文件夹，无须挂载完整
				  ls-type:: annotation
				  hl-page:: 233
				  hl-color:: green
				  id:: 64e2f207-c9f9-4535-b45c-8b0eef182784
			- 7.4.7 更新应用配置且不重启应用程序
			  ls-type:: annotation
			  hl-page:: 235
			  hl-color:: red
			  id:: 64e2f353-5aec-4fc0-87bc-4a3ffb265d16
				- ConfigMap被更新之后， 卷中引用它的所有文件也会相应更新， 进程发现文件被改变之后进行重载。 Kubemetes同样支待文件更新之后手动通知容器。`kubectl edit configmap fortune-config`
				  hl-page:: 235
				  ls-type:: annotation
				  id:: 64e2f36c-df89-4d5f-969a-9432f983301a
				  hl-color:: green
				- 文件被自动更新的过程
				  ls-type:: annotation
				  hl-page:: 236
				  hl-color:: blue
				  id:: 64e2f3b2-0805-483f-9d50-d298a180fdff
					- 应用是否会监听到文件变化并主动进行重载。 幸运的是， 这不会发生， 所有的文件会被 <a class="ask">自动一次性更新</a>
					  hl-page:: 236
					  ls-type:: annotation
					  id:: 64e2f3f4-5874-4ca1-955c-880c3c978935
					  hl-color:: green
					- 被挂载的configMap卷中的文件是 上一级目录实际文件config文件软连接，../data/cnf，比如修改了configmap后会创建一个新的连接把cnf指向新的，这样实现了一次性更新！
					  hl-page:: 236
					  ls-type:: annotation
					  id:: 64e2f402-6539-40ad-86ff-01c09e369fe7
					  hl-color:: green
				- 了解更新 ConfigMap 的影响
				  ls-type:: annotation
				  hl-page:: 236
				  hl-color:: red
				  id:: 64e2f44d-ce14-4edf-a322-ea259b79a8f2
					- 如果应用不支持主动重载配置， 那么修改某些运行pod所使用的 ConfigMap并不是一个好主意
					  ls-type:: annotation
					  hl-page:: 236
					  hl-color:: green
					  id:: 64e2f454-3d49-4304-80ac-6e57adcd9223
					- 一 点仍需注意， 由千 configMap 卷中文件的更新行为对于所有运行中示例而言不是同步的，
					  ls-type:: annotation
					  hl-page:: 237
					  hl-color:: green
					  id:: 64e2f461-7309-4932-8f5c-bb2fee863037
	- 7.5 使用 Secret给容器传递敏感数据 [[k8s-secret]]
	  ls-type:: annotation
	  hl-page:: 237
	  hl-color:: red
	  id:: 64e2f473-500f-4120-9c93-ec2d5ef728be
		- 7.5.1 介绍 Secret
		  ls-type:: annotation
		  hl-page:: 237
		  hl-color:: green
		  id:: 64ec28a2-bcba-4b16-83f3-1be3b061f857
			- Kubemetes 通过仅仅将 Secret 分发到需要访问 Secret 的 pod 所在的机器节点来保障其安全性。
			  ls-type:: annotation
			  hl-page:: 237
			  hl-color:: blue
			  id:: 64ec28b3-9db9-4006-b978-94f28fb7fa63
			- 另外， Secret 只会存储在节点的内存中， 永不写入物理存储，
			  ls-type:: annotation
			  hl-page:: 237
			  hl-color:: red
			  id:: 64ec28c0-7b80-4445-8c71-9b609a0722d2
			- Secret 与 ConfigMap 中做出正确选择是势在必行的， 选择依据相对简单
			  ls-type:: annotation
			  hl-page:: 237
			  hl-color:: yellow
			  id:: 64ec28f8-2442-45e5-a332-279440b2547d
			- Secret 存储天生敏感的数据，
			  ls-type:: annotation
			  hl-page:: 237
			  hl-color:: green
			  id:: 64ec290b-f839-4db5-8f9e-8978aebe54e2
			- ConfigMap 存储非敏感的文本配置数据
			  ls-type:: annotation
			  hl-page:: 237
			  hl-color:: green
			  id:: 64ec290f-0b3f-4e59-8cf7-b361dd7f40b9
		- 7.5.2 默认令牌 Secret 介绍
		  ls-type:: annotation
		  hl-page:: 237
		  hl-color:: red
		  id:: 64ec2916-9f05-456c-9125-eb06869f6b72
			- pod都会被自动挂载上 一 个 secret卷
			  ls-type:: annotation
			  hl-page:: 238
			  hl-color:: red
			  id:: 64ec298f-d4fb-4948-b25c-7aeaf517b89f
				- `kubectl describe  secrets vebackup-agent-token-q7xrr -n vebackup`
				- 可以看出这个Secret包含三个条目-ca.crt、 namespace与token, 包含了从pod内部安全访问KubemetesAPI服务器所需的全部信息。
				  ls-type:: annotation
				  hl-page:: 238
				  hl-color:: red
				  id:: 64ec29fd-ddb3-4e93-acaa-3ad1e6b8d81a
			- 可通过 kubectl exec观察到被secret卷挂载的文件夹下包含三个文件：
			  ls-type:: annotation
			  hl-page:: 239
			  hl-color:: green
			  id:: 64ec2ad8-daed-4ec1-b93a-3cc04330af86
				- ![image.png](../assets/image_1693199086502_0.png)
			- 7.5.3 创建Secret
			  ls-type:: annotation
			  hl-page:: 239
			  hl-color:: red
			  id:: 64ec2b02-9a93-4a51-bb5d-21704c17f3c9
				- kubectl create secret generic fortune-https --from-file=https.key--from-file=https.cert  --from-file=foo
				  hl-page:: 240
				  ls-type:: annotation
				  id:: 64ec2b7e-872b-402e-959d-d7eee430781f
				  hl-color:: red
			- 7.5.4 对比 ConfigMap 与 Secret
			  ls-type:: annotation
			  hl-page:: 240
			  hl-color:: red
			  id:: 64ec2bd3-64b6-443d-8d75-4c9492c76d1d
				- Secret条 目 的 内 容会被 以 Base64格式编 码
				  ls-type:: annotation
				  hl-page:: 241
				  hl-color:: red
				  id:: 64ec2bf5-1e8c-4071-90ba-c98c3969b43a
				- 为二进制数据创建Secret采用Base64编码的原因很简单。Secret的条目可以涵盖二进制数据，而不仅仅是纯文本。Base64编码可以将二进制数据转换为纯文本，以YAML 或JSON格式展示
				  ls-type:: annotation
				  hl-page:: 241
				  hl-color:: green
				  id:: 64ec2c11-7579-4bf8-91ae-d5c43cfc13ad
			- string Data字段介绍
			  ls-type:: annotation
			  hl-page:: 241
			  hl-color:: red
			  id:: 64ec2c37-5b75-48fd-bf96-55dad33c87b0
				- stringData字段是只写的（注意：是只写，非只 读），可以被用来设置 条目值。通过kubectl ge七-o yaml获取Secret的YAML格式定义时，不会显示 stringData字段。 相反，stringData字段中的所有条目（如上面示例中的 foo条目） 会被Base64编码之后展示在data字段下
				  ls-type:: annotation
				  hl-page:: 241
				  hl-color:: green
				  id:: 64ec2c4d-ccae-4be7-84e6-584d60b8ce72
		- 7.5.5 在 pod 中使用 Secret
		  ls-type:: annotation
		  hl-page:: 241
		  hl-color:: yellow
		  id:: 64ec2c63-c698-444e-bdb6-9fed1ca4aee7
			- kubectl edit configmap fortune config
			  hl-page:: 242
			  ls-type:: annotation
			  id:: 64ec2c7f-fb16-46cc-8934-d71727fd4530
			  hl-color:: green
			- [:span]
			  ls-type:: annotation
			  hl-page:: 243
			  hl-color:: green
			  id:: 64ec2cbf-a3d9-44f5-8028-6ac368ce904b
			  hl-type:: area
			  hl-stamp:: 1693199549220
				- Secret卷存储于内存
				  ls-type:: annotation
				  hl-page:: 244
				  hl-color:: red
				  id:: 64ec2cf5-aedb-4b75-b477-b8aec1ccda57
				- kubectl exec fo rt une-https -c web-ser ver -- mount I grep cert s
				  ls-type:: annotation
				  hl-page:: 245
				  hl-color:: green
				  id:: 64ec2d0f-6112-4a17-a385-56e665c882ed
				- 通过环境变 量 暴露 Secret 条目
				  ls-type:: annotation
				  hl-page:: 245
				  hl-color:: red
				  id:: 64ec2d25-2b2b-4814-ad4b-9c9a676634aa
				- [:span]
				  ls-type:: annotation
				  hl-page:: 245
				  hl-color:: yellow
				  id:: 64ec2d58-d93a-4b6e-b47c-48e8ce02e2d9
				  hl-type:: area
				  hl-stamp:: 1693199703420
				- 由于敏感 数据可能在无意中被暴露 ，通过环境变量暴露 Secret 给容器之前请再三思考 。 为了确保安全性，请始终采用 secret 卷的方式暴露 Se cr e t
				  ls-type:: annotation
				  hl-page:: 245
				  hl-color:: green
				  id:: 64ec2d5f-5c93-485e-8a8f-468e5de67afc
				- 不需要为每个 pod指定镜像拉取 Secret假设某系统中通常运行大量 pod，你可能会好奇是否需要为每个 pod都添加相同的镜像拉取 Secret。幸运的是，情况并非如此。第12章中将会学习到如何通过添加 Sec r et至 Serv ic eAcco unt使所有 pod都能 自动添加上镜像拉取 Secre
				  ls-type:: annotation
				  hl-page:: 247
				  hl-color:: red
				  id:: 64ec2d9d-1204-492e-b2fd-e88fc0275315
				- pod都添加相同的镜像拉取 Secret。幸运的是，情况并非如此。第12章中将会学习到如何通过添加 Sec r et至 Serv ic eAcco unt使所有 pod都能 自动添加上镜像拉取 Secret。
				  ls-type:: annotation
				  hl-page:: 247
				  hl-color:: red
				  id:: 64ec2da5-6aef-4b4c-99c6-ddbf88772caa
	- 7.6本章小结
		- 在 pod定义中覆盖容器镜像定义的默认命令
		  ls-type:: annotation
		  hl-page:: 247
		  hl-color:: green
		  id:: 64ec2db7-27dc-41f1-a65d-17a011587b18
			- ·传递命令行参数给容器主进程
			- ·为容器设置环境变量·将配置从 pod定义中分离并放入 ConfigMap
			- ．通过 Secret存储敏感数据并安全分发至容器
			- ·创建 do cker registry Secret用以从 私有镜像仓库拉取镜像