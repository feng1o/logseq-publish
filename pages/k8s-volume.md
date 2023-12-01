- FAQ
	- ops:: 部署模型，资源规划，pod和pv类型关系
	- pv类型、调度过程资源分配、pod和pv绑定
- [pvc pv storage-class](https://boilingfrog.github.io/2021/07/01/k8s%E4%B8%AD%E7%9A%84PV%E5%92%8CPVC%E7%90%86%E8%A7%A3/) #card
  card-last-score:: 5
  card-repeats:: 1
  card-next-schedule:: 2023-08-26T03:42:53.017Z
  card-last-interval:: 4
  card-ease-factor:: 2.6
  card-last-reviewed:: 2023-08-22T03:42:53.017Z
	- [LPV](https://www.cnblogs.com/orchidzjl/p/12025100.html) LPV设计有两个点：
		- 如何把本地磁盘抽象成pv:: hostPath 加 NodeAffinity？本地目录不应该当做pv使用，资源不隔离，不可控，写满等问题。一般应该是单独的一个盘，当做pv
		- 调度器如何保证 Pod 始终能被正确地调度到它所请求的 Local Persistent Volume 所在的节点上呢
	- [[PV]]
		- {{embed ((64f86bf0-7239-4261-9cca-ae1eccab1dcf))}}
	- [[PVC]]
		- {{embed ((64f86c8a-846d-4cc3-846e-fef42789b5fe))}}
	- storage-class
		- 表示一个存储类型，PV 创建时可指定 storageClass，PVC 也可以指定所需要的 storageClass，绑定的时候只会绑定同一个 storageClass 的 PV
		- 一些存储插件实现了 storageClass 的 controller，可以在 PVC 找不到符合需求的 PV 的时候，动态地创建一个
- 一个 Volume（数据卷）仅仅是一个可被容器组中的容器访问的文件目录（也许其中包含一些数据文件）。这个目录是怎么来的，取决于该数据卷的类型（不同类型的数据卷使用不同的存储介质） [kuboard](https://kuboard.cn/learning/k8s-intermediate/persistent/volume.html#%E6%95%B0%E6%8D%AE%E5%8D%B7%E6%A6%82%E8%BF%B0)
- volume类型：
	- #### [emptdir](https://kuboard.cn/learning/k8s-intermediate/persistent/volume.html#emptydir)
	  id:: 64dc87c3-fe56-4a9e-a9d6-201489ef314c
		- 默认用的node的存储介质，pod删除会丢，奔溃不会，一般用来存储中间数据，比如mergeSort的中间数据
	- #### NFS cephfs
	- #### [hostPath](https://kuboard.cn/learning/k8s-intermediate/persistent/volume.html#hostpath)
	  id:: 64dc88a7-64a6-4c7c-8da8-978d74758ed0
		- 将 Pod（容器组）所在节点的文件系统上某一个文件或文件夹挂载进容器组（容器）
		- 一般对于k8s集群本身的数据持久化和docker本身的数据持久化会使用这种方式；增加了pod和node的耦合，一般不用
	- #### [configmap](https://kuboard.cn/learning/k8s-intermediate/persistent/volume.html#configmap)
	- #### [secret](https://kuboard.cn/learning/k8s-intermediate/persistent/volume.html#secret)
	- #### [persistentVolumeClaim](https://kuboard.cn/learning/k8s-intermediate/persistent/volume.html#persistentvolumeclaim)
- pod本地盘资源分配？pod在node上的位置等信息，describe可看到container-id
  id:: 64d1fb6b-ad66-404d-af00-709d67846daa
  :LOGBOOK:
  CLOCK: [2023-08-11 Fri 18:06:26]--[2023-08-11 Fri 18:06:27] =>  00:00:01
  CLOCK: [2023-08-11 Fri 18:06:28]--[2023-08-11 Fri 18:06:29] =>  00:00:01
  :END:
	- df -h | grep container-id 可看到一个分区使用情况，到pod里df无？
	- 为什么一个overlay的文件系统上有很多container-id都挂载了？ 都显示使用2% [[k8s资源管理]]
		- ![image.png](../assets/image_1691745972817_0.png)
	- 该node下mount到data00,但是shm为什么和overlay的分区不一样？
		- 这里的系统盘/ ？ 挂data00， 看[[linux查看磁盘分区]]
		- ![image.png](../assets/image_1691747295706_0.png)
		- ![image.png](../assets/image_1691747399382_0.png)