icon:: ☸
color:: light

- {{renderer :tocgen2, [[]], auto, 1}}
- DOING [[TKE]] [[Kubernetes]] {{renderer agenda, task-list}}
  :LOGBOOK:
  CLOCK: [2023-03-28 Tue 19:35:11]
  :END:
- ==summary-k8s ==
	- ![Kubernetes in Action中文版-七牛容器云团队译.pdf](../assets/Kubernetes_in_Action中文版-七牛容器云团队译_1688134324560_0.pdf)
	- ![kubernetes中文指南-云原生应用架构实战手册-jimmysong.pdf](../assets/kubernetes中文指南-云原生应用架构实战手册-jimmysong_1688134376580_0.pdf)
	- [kuboard](https://kuboard.cn/overview/concepts.html#kubernetes-%E5%AD%A6%E4%B9%A0%E9%97%A8%E6%A7%9B%E5%9C%A8%E5%93%AA%E5%84%BF)
	  id:: 64dc82de-6169-4cb6-aeb3-ff1ad64f9f05
		- [[$sub8]]==docker安装后，可通过 ~/.kube/config导入集群==
	- [[k8s架构]]
- [[k8s concept]]
- [[k8s-helm]]
- [[k8s-kubeclt]]  [[k8s工具]]
- [[k8s-operator]]
- [[k8s-volume]]
	- TODO ((64d1fb6b-ad66-404d-af00-709d67846daa)) >[🍅 1min](#agenda-pomo://?t=p-1691749648633-2)
- [[k8s网络管理]]
- [[k8s-调度]]
- [[k8s-FAQ]]
	- pod的相位值 ？
		- ````
		  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
		  ````
	- pod中netstat是[看不到进程pid等信息](https://stackoverflow.com/questions/63454535/why-is-hostport-not-showing-in-the-outputs-of-netstat-from-host-machine)的，那怎么看某个监听端口？比如mysqld
		- ```
		  docker inspect --format '{{ .State.Pid }}' <<container-id>>  //  docker ps 获取containmer id
		  nsenter -t <<container pid>> -n netstat -tunlp   
		  ```
		- 怎么看pod中有多少container？
			- ```
			  kubectl get pods mysql-ha-1  -o jsonpath={.spec.initContainers[*].name}
			  kubectl get pod POD_NAME_HERE -o jsonpath="{.spec['containers','initContainers'][*].name}"
			  ```
		- k9s?
	-
- Agenda
	- TODO cronjob和pod关系？每个cronjob属于哪个container？在哪里执行？比如做了backup的，那备份到哪里了？ >[2023-06-06](#agenda://?start=1686018832000&end=1686018832000)
-
- TODO operation >[2023-06-15 - 2023-06-29](#agenda://?start=1686815957618&end=1688025557618) >[🍅 1min](#agenda-pomo://?t=p-1691749285201-2)
	- ```
	  (tob_env) root@found-k8s-1:~# ls /var/lib/kubelet/pods/547094c1-9c5e-405a-9cb9-fc894aaafbf1/containers/manager/
	  9736d658
	  (tob_env) root@found-k8s-1:~# ps axu | grep 9736d658
	  root     2658591  0.0  0.0  12784   944 pts/28   S+   15:37   0:00 grep 9736d658
	  
	  - kubectl describe cm -n ingress-nginx tcp-services
	  - kubectl  get svc  --all-namespaces | grep ingre
	  
	  kubectl get po -n nsop  --field-selector 'status.phase!=Running' -o json | kubectl delete -f #删除不是running的
	  ```
	- TODO kubelet问题怎么定位？ 比如pod无法创建，pvc无法mount或umount等？ >[2023-06-15 - 2023-06-30](#agenda://?start=1686813353000&end=1688109353000)
	  :LOGBOOK:
	  CLOCK: [2023-06-15 Thu 15:15:40]--[2023-06-15 Thu 15:16:13] =>  00:00:33
	  CLOCK: [2023-06-15 Thu 15:16:14]--[2023-06-15 Thu 15:16:14] =>  00:00:00
	  CLOCK: [2023-06-15 Thu 15:16:15]
	  :END:
	- [pod copy文件到宿主机](https://nj.transwarp.cn:8180/?p=493)  方法汇总？
	- 底座上的svc、比如vepfsmgr的clusterIp 是谁分配的？ 各种服务的port怎么管理关联？各种可见性问题，pod里访问metadb-mysql等的域名或ip是怎么规划的？
- #### mac  ~/.kube/config已配置测试账号
	- ~/Documents/k8s
	- kubectl  get pod --v=8 2>logx
	- kubectl config view
-
-