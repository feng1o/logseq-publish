icon:: 

- ==summary==
  id:: 6235a27f-ff19-4ef8-a918-bfd822c1c0f5
	- [[golang-im]]
		- NOW [[GMP调度器]] [<sub>GMP分析-手撸goroutine pool</sub>](https://strikefreedom.top/high-performance-implementation-of-goroutine-pool)
		  :LOGBOOK:
		  CLOCK: [2022-03-04 Fri 00:50:16]--[2022-03-04 Fri 00:51:26] =>  00:01:10
		  CLOCK: [2022-03-04 Fri 00:51:27]--[2022-03-04 Fri 00:51:30] =>  00:00:03
		  CLOCK: [2022-03-04 Fri 01:04:59]--[2022-03-04 Fri 01:05:00] =>  00:00:01
		  CLOCK: [2022-03-04 Fri 01:05:01]--[2022-03-04 Fri 01:05:01] =>  00:00:00
		  CLOCK: [2022-03-04 Fri 01:05:02]--[2022-03-04 Fri 01:05:02] =>  00:00:00
		  CLOCK: [2022-03-04 Fri 01:05:03]--[2022-03-09 Wed 14:37:15] =>  133:32:12
		  CLOCK: [2022-03-09 Wed 23:43:14]
		  :END:
	- [[#red]]==DOC-PATH==
		- [[go语言设计与实现]] [[go专家编程]] [[go语言高性能编程]]
		- [[go-interview宝典]] #toc
		  id:: 63f36d90-90cc-49dd-80b5-65701c28f1a4
	- <a href =https://github.com/golang-standards/project-layout/blob/master/README_zh-CN.md class="apple underline">golang项目结构规范 <span class=" bg-green white  subw hblack hover">[[2022-03-25 Fri]] </span></a>
		- 项目pkg下的log怎么和调用方一致？错误怎么管理，比如可能外层必传的配置、[[变量等？比如gConf这个怎么传递更好?
		  SCHEDULED: <2023-11-14 Tue 15:19 .+3d>
		  :LOGBOOK:
		  CLOCK: [2022-03-26 Sat 23:38:27]--[2022-03-26 Sat 23:38:28] =>  00:00:01
		  :END:
	- NOW 日志如何管理？pkg下的日志是怎么和main里的独立或者联动？ [exapmle](https://github.com/golang-standards/project-layout/blob/master/pkg/README.md)
	  :LOGBOOK:
	  CLOCK: [2022-03-28 Mon 17:57:01]--[2022-09-01 Thu 15:40:30] =>  3765:43:29
	  CLOCK: [2022-09-01 Thu 15:40:34]
	  :END:
	- [golang高性能环形队列mpmc](https://hedzr.com/algorithm/golang/ringbuf-index/)   [[$sub8-blue]]==这个环形队列实现的细节思考==
	- golang怎么判定一个struct是否实现了一个interface <a class="ask"></a> `var _ InterFaceStruct = (*StructName) (nil)`
	-
- [[go-import gomod 工具]] #toc
- [[golang-caveat]] #toc #interview
	- [[sync.pool]]
	- [interview-question-exam](https://static.kancloud.cn/qq5202056/gomianshi/2657210) #interview  <a class="alg-hard"></a>
	- [go问答101](https://gfw.go101.org/article/unofficial-faq.html#method-set-relation) #interview #card
	  card-last-interval:: 8.32
	  card-repeats:: 3
	  card-ease-factor:: 2.08
	  card-next-schedule:: 2024-03-06T10:39:01.882Z
	  card-last-reviewed:: 2024-02-27T03:39:01.882Z
	  card-last-score:: 3
	- DONE [go-interview题list](https://geektutu.com/post/qa-golang.html)
- [[golang反射]] #toc
- [[go泛型]]
- [[golang内存管理]]
- [[go-code-pattern]] #toc
- [[golang-pkg]][[cobraCLI]]  看etcd或者hugo这里用法  [retry](https://github.com/gotidy/retry/blob/main/strategies.go)
  :LOGBOOK:
  CLOCK: [2023-06-15 Thu 19:54:05]--[2023-06-15 Thu 19:54:05] =>  00:00:00
  :END:
- [[worker-job-queue]] #toc
- [[channel]] #toc
	- {{embed ((654da43f-a6d0-40df-b754-05a07169eb9f))}}
- [[go-pprof]] #toc
- [[cgo]]
- [[go-ut]] [doc-goconvey-gomonkey](https://note.youdao.com/s/RpQwVfQU)
- TODO  [Authorization签名算法在http中封装方法](https://www.volcengine.com/docs/6396/70458)
	- https://github.com/volcengine/volc-openapi-demos/blob/main/signature/golang/sign.go
	- https://github.com/volcengine/volc-sdk-golang/blob/main/example/imagex/create_image_content_task.go  sdk里的签名方法imagex入口
	- "volcengine/volc-signer-golang" 封装的签名引入方法
	- https://www.tencentcloud.com/zh/document/product/1024/34672