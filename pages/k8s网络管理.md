- [[k8s-ingress]]
	- Kubernetes Ingress定义了如何将外部流量定向到集群内部的服务
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