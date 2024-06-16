title:: tc-net_cls

- 1. docs
  ```
  1.https://www.lartc.org/LARTC-zh_CN.GB2312.pdf  linuxLinux 的高级路由和流量控制 HOWTO ***
  
  2.cgroup资源介绍 https://www.v2ex.com/member/jerry017cn  ******
  3.https://ggaaooppeenngg.github.io/zh-CN/2017/05/19/cgroup-%E5%AD%90%E7%B3%BB%E7%BB%9F%E4%B9%8B-net-cls-%E5%92%8C-net-prio/  cgroup 子系统之 net_cls 和 net_prio   ***
  
  4. https://hanjianqiao.github.io/2017/10/22/cgroup_net_cls/ 操作步骤en
  5. tc介绍：https://tonydeng.github.io/sdn-handbook/linux/tc.html *****
  inc: https://tldp.org/HOWTO/Traffic-Control-HOWTO/components.html#c-class   官方*****
  inc: https://blog.csdn.net/dog250/article/details/40483627 **** 图
  
  tc由qdisc、fitler和class三部分组成：
  qdisc通过队列将数据包缓存起来，用来控制网络收发的速度
  class用来表示控制策略
  filter用来将数据包划分到具体的控制策略中
  qdisc
  qdisc通过队列将数据包缓存起来，用来控制网络收发的速度。实际上，每个网卡都有一个关联的qdisc。它包括以下几种：
  无分类qdisc（只能应用于root队列）
  [p|b]fifo：简单先进先出
  pfifo_fast：根据数据包的tos将队列划分到3个band，每个band内部先进先出
  red：Random Early Detection，带带宽接近限制时随机丢包，适合高带宽应用
  sfq：Stochastic Fairness Queueing，按照会话对流量排序并循环发送每个会话的数据包
  tbf：Token Bucket Filter，只允许以不超过事先设定的速率到来的数据包通过 , 但可能允许短暂突发流量朝过设定值
  有分类qdisc（可以包括多个队列）
  cbq：Class Based Queueing，借助EWMA(exponential weighted moving average, 指数加权移动均值 ) 算法确认链路的闲置时间足够长 , 以达到降低链路实际带宽的目的。如果发生越限 ,CBQ 就会禁止发包一段时间。
  htb：Hierarchy Token Bucket，在tbf的基础上增加了分层
  prio：分类优先算法并不进行整形 , 它仅仅根据你配置的过滤器把流量进一步细分。缺省会自动创建三个FIFO类。
  注意，一般说到qdisc都是指egress qdisc。每块网卡实际上还可以添加一个ingress qdisc，不过它有诸多的限制
  ingress qdisc不能包含子类，而只能作过滤
  ingress qdisc只能用于简单的整形
  如果相对ingress方向作流量控制的话，可以借助ifb（ Intermediate Functional Block）内核模块。因为流入网络接口的流量是无法直接控制的，那么就需要把流入的包导入（通过 tc action）到一个中间的队列，该队列在 ifb 设备上，然后让这些包重走 tc 层，最后流入的包再重新入栈，流出的包重新出栈。
  
  6.http://codeshold.me/2017/01/tc_detail_inro.html
  
  7. https://leeweir.github.io/posts/linux-packet-loss/ 网络丢包解析  ***** 丢包分析
  8. http://www.liangsonghua.com/archives/399 谈谈Linux中的TCP重传抓包分析 
  9. https://guanjunjian.github.io/2017/11/20/study-11-hierachical-token-bucket-source-code-2/  htb源码解析
  10.https://www.cnblogs.com/acool/p/7779159.html  htb算法包选择class方法
  
  ```
- 2. ![Linux 的高级路由和流量控制 tc-netfilters.pdf](../assets/Linux_的高级路由和流量控制_HOWTO_1661353832336_0.pdf)
- 3. [[tunnel]]