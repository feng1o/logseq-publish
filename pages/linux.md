icon:: 🐧

- {{renderer :tocgen2, [[]], auto, 2}}   [doc-all-pic](http://note.wcoder.com/)
- collapsed:: true
  #+BEGIN_QUERY
   {:title  [:h4.red.border.shadow.underline.border  "toc列表"]
     :query (and (and [[linux]] ) [[toc]])
    :collapsed? true
  }
  #+END_QUERY
- <a class="alg-4stars" href=https://fanlv.wiki/2020/09/13/note/linux-in-action/>linux内核技术实战-blog <span class=" bg-green white  subw hblack hover"> 深入介绍page cache；page cache回收不足等引起的load问题 </span></a>
  id:: 62b144ad-fa7d-43a4-9758-19032dd31044
	- ![WX20220530-232519.png](../assets/WX20220530-232519_1653924350509_0.png){:height 252, :width 495}
- [[升级glibc从2.12-2.17]] #toc
- [[page cache]] #toc
- [[LXC]] #toc
	- [[namespace]]
- [[cgroup]] #toc
  id:: 65d810fe-6cb8-4ca0-a3a7-1f8a09a667e2
	- {{embed ((63c34bce-ac77-4dfb-a686-92b45a693374))}}
	- query-table:: true
- [[net/ifconfig]] #toc
	- [[tcp-ip协议]] #toc
	- ![暗-图解网络-小林.pdf](../assets/暗-图解网络-小林_1644839240185_0.pdf)
	- ![亮-图解网络-小林.pdf](../assets/亮-图解网络-小林_1644839219471_0.pdf)
	- [[RDMA]] ![RDMA原理分析、对比和技术实现解析.pdf](../assets/RDMA原理分析、对比和技术实现解析_1703818792670_0.pdf)  [[hls__RDMA原理分析、对比和技术实现解析_1699947652401_0]]
- [[shell]]
- [[进程线程]] #toc #interview
- [[io多路复用]] [[Unix网络编程中的五种IO模型]] [[IO模型]]#toc #interview #card
  card-last-interval:: 4
  card-repeats:: 2
  card-ease-factor:: 2.22
  card-next-schedule:: 2024-03-02T03:34:09.793Z
  card-last-reviewed:: 2024-02-27T03:34:09.793Z
  card-last-score:: 3
- [[linux-profile]]
	- ltrace能够跟踪进程的库函数调用
	- truss和strace用来跟踪一个进程的系统调用或信号产生的情
	- 而ltrace跟踪同样的程序，输出的信息则相对比较简单，只有库函数API和信号：
	- 2.trace和ltrace对比：
		- [http://m.blog.csdn.net/hustsselbj/article/details/47438667](http://m.blog.csdn.net/hustsselbj/article/details/47438667)
		- [3.](http://m.blog.csdn.net/hustsselbj/article/details/47438667)使用:[https://www.cnblogs.com/lidabo/p/5490200.html](https://www.cnblogs.com/lidabo/p/5490200.html)
		- truss -o ls.truss ls -al： 跟踪ls -al的运行，将输出信息写到文件/tmp/ls.truss中。
		- strace -f -o vim.strace vim： 跟踪vim及其子进程的运行，将输出信息写到文件vim.strace。
		- ltrace -p 234： 跟踪一个pid为234的已经在运行的进程。
	- 5.valgrind: [https://phenix3443.github.io/notebook/software-engineering/debug/valgrind-practices.html](https://phenix3443.github.io/notebook/software-engineering/debug/valgrind-practices.html)
		- install: check: [https://www.cprogramming.com/debugging/valgrind.html](https://www.cprogramming.com/debugging/valgrind.html)
		- valgrind报告内存问题：[https://shigaro.org/2019/07/05/valgrind-2/](https://shigaro.org/2019/07/05/valgrind-2/)
- [[linux-tools]]
- [[linux-service]]
- [[linux性能实战]]
-