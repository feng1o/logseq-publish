format:: `kubectl [command] [TYPE] [NAME] [flags]`   根目录： `/var/lib/kubelet`   log: `/var/log/kubelet.log`
1）**command**：指定要对一个或多个资源执行的操作，例如，`create`、`get`、`describe`、`delete`。
2）**TYPE**：指定资源类型、无大小写、单数复数都ok
3）**NAME**：指定资源的名称。名称区分大小写。
````
kubectl get pod/example-pod1 replicationcontroller/example-rc1
````

- #### kubectl格式化输出
	- ```apl
	  kubectl  get secrets -n rds mysql-cf743ac06d2b-r7ba0 -o  custom-columns=列名指定:apiVersion,列民2:kind -v2
	  kubectl  get secrets -n rds mysql-cf743ac06d2b-r7ba0 -o jsonpath={".data"}
	  
	  ```
- #### 查看和查找资源 [](https://kubernetes.io/zh-cn/docs/reference/kubectl/cheatsheet/#viewing-finding-resources)
	- > 默认default的，namespace需要指定
	- `````
	  kubectl config current-context
	  kubectl get namespace 
	  kubectl get pods   //这个能获取所有吗？ no  列出所有不同的资源对象。
	  kubectl get all  --all-namespaces	
	  kubectl get pods --namespace=default
	  kubectl get pods -n default
	  
	  # label
	  kubectl get pod nginx-pod  -n dev --show-labels
	  kubectl get pod -n dev -l version=2.0  --show-labels
	  
	  kubectl get secrets xxxx -n xxxx --template={{.data.ROOT_PASSWORD}} | base64 -d
	  ```
- #### 交互
	- ```
	  kubectl exec -it x-mgr-59ddddd7b4-kkfbc -n x -- /bin/sh
	  kubectl exec -i -t my-pod --container main-app -- /bin/bash  //有多个container时候选中一个容器
	  kubectl edit pod test-k8s-664bdc5c58-szrsf
	  kubectl edit deployment/test-k8s
	  
	  ```
- #### describe等
	- > descirbe也需要指定namespace
	- ```
	  kubectl describe   pods/xxxxgr-59ddddd7b4-kkfbc  -n xxxname
	  kubectl get pods -o yaml  vxp-mgr-59ddddd7b4-kkfbc -n veba  这个有什么区别？ 
	  
	  ```
- ### 删除重启
	- ```
	  kubectl delete pod  xxxx  //如果是deployment部署的，发现无法删除，应该先删除deplyoment
	  kubectl delete deployment test-k8s
	  kubectl rollout restart deployment vepfsmgr  //通过deploy和svc的，重启svc可做
	  ```
- ### 测试例子
	- ```
	  kubectl apply -f https://k8s.io/examples/application/shell-demo.yaml
	  kubectl get pod shell-demo
	  
	  kubectl scale deployment test-k8s --replicas=5
	  kubectl rollout history deployment test-k8s
	  kubectl rollout undo deployment test-k8s --to-revision=2
	  # 改镜像
	  kubectl set image deployment test-k8s test-k8s=ccr.ccs.tencentyun.com/k8s-tutorial/test-k8s:v2-with-error --record
	  
	  kubectl get pod -o wide --show-labels   // kubectl get pod -L app,versions
	  kubectl get pod -o wide -l app=test-k8s // kubectl get pod -L  '!app' //不包含app tag的，但未能过滤
	  kubectl describe svc test-k8s
	  
	  kubectl port-forward service/test-k8s 8080:8080  serveice的type=cluster到外部访问
	  
	  # statefulset
	  kubectl run mongodb-client --rm --tty -i --restart='Never' --image docker.io/bitnami/mongodb:4.4.10-debian-10-r20 --
	  command -- bash
	  kubectl rollout restart statefulset mongodb
	  ```
- ### miscellaneous
	- 怎么更新pod里容器镜像？ [三种方法](https://blog.csdn.net/StephenLu0422/article/details/78900420)
-
- ```python
  certificatesigningrequests (缩写 csr)
  componentstatuses (缩写 cs)
  configmaps (缩写 cm)
  customresourcedefinition (缩写 crd)
  daemonsets (缩写 ds)
  deployments (缩写 deploy)
  endpoints (缩写 ep)
  events (缩写 ev)
  horizontalpodautoscalers (缩写 hpa)
  ingresses (缩写 ing)
  limitranges (缩写 limits)
  namespaces (缩写 ns)
  networkpolicies (缩写 netpol)
  nodes (缩写 no)
  persistentvolumeclaims (缩写 pvc)
  persistentvolumes (缩写 pv)
  poddisruptionbudgets (缩写 pdb)
  pods (缩写 po)
  podsecuritypolicies (缩写 psp)
  replicasets (缩写 rs)
  replicationcontrollers (缩写 rc)
  resourcequotas (缩写 quota)
  serviceaccounts (缩写 sa)
  services (缩写 svc)
  statefulsets (缩写 sts)
  storageclasses (缩写 sc)
  ```