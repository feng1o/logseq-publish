title:: tc-net_cls2

- <p class="blue subw  inline_box underline"><span style="color: red;background-color: lightblue;font-weight:bold;font-size:12px"> leaf class/node:</span>只有leafclass才可以缓存网络包,innerclass是没有网络包的.如果步骤1,2最终选到了innerclass怎么处理？既然是innerclass,肯定有自己的subclass.innerclass会顺着树往下找,找到一个子孙leafclass.</p>
- ### cmd
	- ```
	  tc filter delete dev eth1  parent 1: protocol ip pref 49151 cgroup
	  tc qd  delete  dev eth1 root
	  
	  tc -s filter show  dev eth1;tc -s qd show  dev eth1;tc -s class show  dev eth1
	  
	  iperf -c x.x2.x3.xx  -i 1 -t 600  -P 6
	  ```
- DONE  net_ask <span class=" bg-green white  subw hblack hover"> [[2022-09-02 Fri]] </span>
  :LOGBOOK:
  CLOCK: [2022-09-02 Fri 16:40:42]--[2022-09-02 Fri 16:40:59] =>  00:00:17
  CLOCK: [2022-09-02 Fri 16:41:00]--[2022-09-02 Fri 16:41:01] =>  00:00:01
  :END:
	- 1. <a class=ask>为何class有了子class后，对全局的限速失效？ 为何parent的限制sub可超</a>
	- [是从底部匹配的？](https://www.cnblogs.com/acool/p/7779159.html)
	- 2. <a class=ask>cgroup的filter，不需要handle ：classid，实际任意制定一个即可</a>
		- ![image.png](../assets/image_1661353538011_0.png){:height 469, :width 467}
	- 3. <a class=ask>多个网卡bond模式？2个网卡限制哪个</a> [bond模式6种](https://developer.aliyun.com/article/503848) 
	  4.- <a class=ask>eth1为何出流量能限制，入流量限制eth0能有效(也比给的更大？)</a>
	  5.-  <a class=ask>基于问题4怎么看网络流量路径,走的哪个网卡？</a> [tnul详解拆分](https://LW1rLXdhLWNtLQo=/group/545/articles/show/115052?kmref=search&from_page=1&no=2)
	- 6. - <a class=ask> 为何可直接绕过class 走leaf node </a> ![image.png](../assets/image_1661414430092_0.png){:height 151, :width 437}
	  7.  - [tc-video待看](https://www.youtube.com/watch?v=Ylf4J736JIg)
- qdisc:
	- （Queueing Discipline）排队规则，管理设备队列的算法
- class:
	- 可以简单的理解为对要限速的流量进行分类，比如我们将不同的进程进行分类，分成不同的 class，然后每个 class 里面配置对应的限速策略
- filter 过滤器:
	- 分类过程可以通过过滤器（filter）完成。过滤器包含许多的判 断条件，匹配到条件之后就算 filter 匹配成功了。
- handle:
	- 每个 qdisc 和 class 都会分配一个相应的 handle（句柄），可以指定 handle 对 qdisc 进行配置。有了 handle 我们可以将 qdisc、class 组成一个树形的结构。每个 handle 由两部分组成，:，major，minor取值范围是0-65535，书写规范上协作16进制。按照惯例，root qdisc 的 handle 为 1:，这是 1:0 的简写，每个 qdisc 的 minor number 永远是 0
- ![image.png](../assets/image_1661346922843_0.png){:height 593, :width 839}
-
- ![image.png](../assets/image_1661348942324_0.png)为什么这个能被限制速度？ 为何有了字class就不能自动限速了？
- ![image.png](../assets/image_1661350247935_0.png)
- [[net-htb算法]]
