- [[k8s-ingress]]
	- Kubernetes Ingress定义了如何将外部流量定向到集群内部的服务
	- 能够提供七层网络下 HTTP、HTTPS 协议服务的暴露，同时也包括各种七层网络下的常见能力。Ingress 是允许访问到集群内 Service 规则的集合，您可以通过配置转发规则，实现不同 URL 可以访问到集群内不同的 Service
	  id:: 65eecb93-e665-417f-b752-1d83c2e540b9
	- 入口（Ingress）目前已停止更新。新的功能正在集成至[网关 API](https://kubernetes.io/zh-cn/docs/concepts/services-networking/gateway/) 中。
	- TODO kubectl  edit  configmaps  -n ingress-nginx  tcp-services  # 转发规则   该configmap用处 <a class="ask"></a>
	- [ingress-nginx](https://github.com/shuangxi588/K8s/blob/master/ingress/ingress-nginx.md)
		- [ingress-nginx  install guide - 文档详细介绍使用](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start)
			- id:: 65eecb93-0bb3-48ef-aa01-7e75ba6be8f2
			  ```
			  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
			  kubectl get services -n ingress-nginx
			  kubectl -n ingress-nginx get pod -o yaml
			  kubectl get pods --namespace=ingress-nginx   # 一般3个pod running
			  # 创建一个servie
			  # port-forward 暴露port
			  # 然后在ingress nginx注册 
			  ```
- [[k8s-gateway]]
	- Gateway API在Ingress API的基础上增加了更多特性，例如HTTP头匹配、加权流量分割、多协议支持(如HTTP、gRpc)以及其他各种后端功能(如桶、函数)
- [overlay和underlay网路](https://www.cnblogs.com/cyh00001/p/16646062.html)  Underlay网络就是传统IT基础设施网络， 由交换机和路由器等设备组成， 借助以太网协议、 路由协议和VLAN协议等驱动， 它还是Overlay网络的底层网络， 为Overlay网络提供数据通信服务。 容器网络中的Underlay网络是指借助驱动程序将宿主机的底层网络接口直接暴露给容器使用的一种网络构建技术
	- k8s网络同行模式
		- **Overlay网络**：
			- Flannel Vxlan、 Calico BGP、 Calico Vxlan
			- 将pod 地址信息封装在宿主机地址信息以内， 实现跨主机且可跨node子网的通信报文。
		- **直接路由**：
			- Flannel Host-gw、 Flannel VXLAN Directrouting、 Calico Directrouting
			- 基于主机路由， 实现报文从源主机到目的主机的直接转发， 不需要进行报文的叠加封装， 性能比overlay更好。
		- **Underlay:**
			- 需要为pod启用单独的虚拟机网络， 而是直接使用宿主机物理网络， 
			  pod甚至可以在k8s环境之外的节点直接访问(与node节点的网络被打通)， 相当于把pod当桥接模式的虚拟机使用， 
			  比较方便k8s环境以外的访问访问k8s环境中的pod中的服务， 而且由于主机使用的宿主机网络， 其性能最好。
	- 事实上，考虑到当今公有云底层网络的功能限制，Overlay网络反倒是一种最为可行的容器网络解决方案，仅那些更注重网络性能的场景才会选择Underlay网络