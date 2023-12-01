- ```shell
  mysql  -P3679 -uroot -pByterds1qaz@WSX! -h$(kubectl get service |grep mysql-ha-proxy-agent |awk '{print $3}')
  kubectl describe  service/mysql-ha-proxy-agent  # proxy port 3679
  kubectl describe  pod mysql-ha-1  # get ip and user 可直接登录
  use vebackupmgr;
  
  
  - kubectl describe cm -n ingress-nginx tcp-services
  - kubectl  get svc  --all-namespaces | grep ingre
  
  # e10
  mysql -hmetadb-mysql-proxy-agent.metadb.svc.storage-cp.org -P3679 -uuser_admin -p$(kubectl get secrets -nmetadb -oyaml  metadb-mysql |grep ROOT_PASSWORD|grep -v 'f:'|awk '{print $2}'|base64 -d)
  ```
-
- ```
  ip addr show bond0
  ```
-