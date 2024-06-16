- LENS可视化工具、通过.kube/config可直接接入
- k9s命令行
- {{embed ((64dc82de-6169-4cb6-aeb3-ff1ad64f9f05))}}
- [kt-connect](https://developer.aliyun.com/article/751321)  完成本地直接测试
	- 目前使用下来最实用的功能就是**直接连接 Kubernetes 网络**实现在本地使用 k8s 内网域名调用 Kubernetes 集群内的服务以及**将 Kubernetes 集群中的流量转发到本地**，作用类似于一个 VPN，将本地网络与 Kubernetes 集群网络连接。
	- 1. 添加以下hosts到`/etc/hosts`文件中
		- ```
		  xxxx mysql-ha-proxy-agent.default.svc.mix-panel-a.org
		  x.x.x.85 zk-cs.default.svc.mix-panel-a.org
		  x.x.x.21 ingress.k8s-default.infcs.tob
		  x.x.x.74 zk-hs.default.svc.mix-panel-a.org
		  x.x cc-zk-3992eb5ca762-headless.configs.svc.mix-panel-a.org
		  x.x.x.25 mymeta-3fda4d3c5b3b-m7f24-proxy-agent-hs.mymeta.svc.control.org
		  x.x.x.10 zk-hs.default.svc.control.org.
		  ```
	- 2. 配置本地kubectl，确保本地可以直连测试环境的的control集群
	- 3. 安装kt-connect
	- ```
	  brew install kt-connect
	  sudo ktctl -d connect --image hxxb.btd.org/infcs/kt-connect-shadow:v0.3.7
	  
	  # 需要本地能访问到k8s集群的服务，甚至双向访问，那就可以本地直接调试了； 比如mgr运行在k8s南京集群，mgr运行依赖的就是env，如果本地和南京个各种boe环境通了，那本地即可跑mgr
	  ```
	- 4. 进入goland编辑运行配置，配置envfile
	  其中envfile为插件，需要手动安装。envfile内容源自南京pod的环境变量，手动copy除了HOME这个变量外的所有变量
		- ![image.png](../assets/image_1717161643152_0.png)
	- 5. 可run
- #### 基于泳道的多人环境k8s mgr测试搭建
	- 修改ingress，给每个人的service配置端口`kubectl edit  -n ingress-nginx configmaps tcp-services`；
		- 增加各自的svc，deplyoment
			- ```
			  ingress-nginx： 34083--> svc-xx的8080
			  	 # "34082": default/rdsmgr-new20:8088
			       # "34083": default/rdsmgr-whfxxx:8088
			       # "34160": default/rdsmysqlomp-xxx:8089
			       
			  svc只有selector 和你svc的name等不一样，比如mgr-xxx， 端口和默认端口一致，比如8080
			  	# apiVersion: v1 kind: Service metadata: labels: app: rdsmgr-whfxxx name: rdsmgr-whfxxx namespace: default spec: ports: - name: rpc port: 8088 protocol: TCP targetPort: 8088 - name: http port: 8089 protocol: TCP targetPort: 8089 selector: app: rdsmgr-whfxxx sessionAffinity: None type: ClusterIP
			      
			  deployment：一样的，只是名字等不一样，改成mgr-xxx
			  	#apiVersion: apps/v1 kind: Deployment metadata: generation: 10 labels: app: rdsmgr-whfxxx name: rdsmgr-whfxxx namespace: default spec: progressDeadlineSeconds: 600 replicas: 0 revisionHistoryLimit: 10 selector: matchLabels: app: rdsmgr-whfxxx strategy: rollingUpdate: maxSurge: 1 maxUnavailable: 0 type: RollingUpdate template: metadata: annotations: kubectl.kubernetes.io/restartedAt: 2023-11-13T20:20:18+08:00 creationTimestamp: null labels: app: rdsmgr-whfxxx,  env: .....
			      
			  还一个dlv的mgr的svc，这个只有一个svc，没dp，为什么能出现监听端口？type是nodeport，给dlv远程用？？ 如何和mgr服务关联的，端口也不一样，dlv的svc的端口直接改成35083， 那goland的dlv就是35083,非dlv的没改，是clusterIP
			  	# apiVersion: v1 kind: Service metadata: annotations: labels: app: rdsmgr-whfxxx-dlv name: rdsmgr-whfxxx-dlv namespace: default spec: externalTrafficPolicy: Cluster ports: - name: dlv nodePort: 31083 port: 2345 protocol: TCP targetPort: 2345 selector: app: rdsmgr-whfxxx sessionAffinity: None type: NodePort
			  ```
			- TODO  web-controll是怎么根据浏览器header自动识别到你的svc的，即svc配置nginx-ingress的port？对应的服务？
			- TODO dlv的端口，为什么是dlv的svc，这个svc没有dp，没有pod，只是一个空白的svc，然后机器上可netstat看到监听端口？然后goland的端口配置dlv的svc端口，会自动关联到真实svc的pod内？why
				- ![image.png](../assets/image_1718118410346_0.png)
			-
		- ```
		  kubectl edit  -n ingress-nginx configmaps tcp-services
		  
		    "3077": default/rdsmgr-new15:8088
		    "34078": default/rdsmgr-new16:8088
		    "34079": default/rdsmgr-new17:8088...
		    
		  rdsmgr-new16          ClusterIP  xx.xx.249.180 <none>     8088
		  rdsmgr-new16-dlv        NodePort   xx.xx.54.40   <none>     2345:31078
		  rdsmgr-new17          ClusterIP  xx.xx.44.48   <none>     8088
		  rdsmgr-new17-dlv        NodePort   xx.xx.248.165 <none>     2345:31079  
		    
		   
		  ```
	- requestly修改header信息
		- ![image.png](../assets/image_1717383445743_0.png)
	- build image推送到镜像
		- ```
		  # 基于xxxx/base/storage_base_go_image:1.x.0.2，增加dlv，其余部分和dockerfile保持相同
		  FROM /infcs/storage_base_go_image_with_dlv:1.x.0.3
		  MAINTAINER xxx <x@x.com>
		  
		  ADD output/x-mgr /opt/tiger/xmgr/x-mgr
		  ADD output/conf /opt/tiger/xmgr/conf
		  ADD output/bin /opt/tiger/xmgr/bin
		  RUN chown -R tiger:tiger /opt/tiger/xmgr \
		      && chmod +777 -R /opt/tiger/xmgr/bin/
		  WORKDIR /opt/tiger/xmgr
		  
		  EXPOSE 8088
		  ```
	- 手动更新
		- ```
		  kubectl scale deployment xxx --replicas=1
		  kubectl 
		  ```
- #### dlv远程测试
	- 点击Edit Configurations，增加一个配置
		- ![image.png](../assets/image_1717383989894_0.png)
	-
