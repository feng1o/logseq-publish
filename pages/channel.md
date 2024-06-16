- ==summary-channel==
  id:: 654da43f-a6d0-40df-b754-05a07169eb9f
	- [channel任务分发、优雅关闭退出](https://blog.csdn.net/u014618114/article/details/113108144)  [如何优雅关闭通道](https://gfw.go101.org/article/channel-closing.html)
		- 利用close(channel)接受默认，`<- chan struct{}`
		- `for range` 在chan关闭时退出
		- `for select` 无感知关闭chan能力，需要case: v, ok := <- chan， 通过ok判定，关闭后把这个置空nil(阻塞)，多个chan都关闭退出, [see](logseq://graph/logseq?block-id=654da5b9-9d12-4449-b73f-a39e0d8796b8)
		- ctx关闭，多层的子goroutine通知推迟机制
	- dead lock或leak resource
		- 无buffer的channel注意导致的阻塞(无consumer，或consumer的goroutine退出了）
		- 重复close，可用`0nce.Do(...close(ch))`
		- `for range`必须close才会退出，小心leak
		- `signal.Notify( c,syscall.SIGINT, syscall.SIGKIL...) , select { cas sig := <- c .....}`
- [go并发设计模式active object](https://mp.weixin.qq.com/s/D-3-Bpl5UZ_w_tnUHh6UaA) [[多线程模式Active Object]]    也叫    [[Actor/模型]]
  id:: 63778095-02d7-40fd-9f76-61973b719554
	- <span class="subw8">Active Object设计模式主要是解耦调用、和执行; 方法的调用和方法的执行运行在不同的线程之中(或goroutine)</span>
		- id:: 637782b7-d2b9-4287-aae4-e7b3a87daacf
		  ```java
		  ActiveObject ao=...;   ActiveObj是一个对外的类，给业务调用
		  Future<string> future = ao.doSomething("data");  // 真正执行调用，doSomething是一个线程安全的
		  // 执行其它操作
		  String result = future.get();
		  System.out.println(result);
		  </string>
		  ```
- practise
	- id:: 654da5b9-9d12-4449-b73f-a39e0d8796b8
	  ```go
	  go func()
	  // in for-select using ok to exit goroutine
	  for (
	  select {
	    case x,ok := <-in1if !ok {
	      in1 = nil
	  		// Process
	      case y, ok := <-in2if !ok {in2 = nil
	  		// Process
	      case <-t.C:
	  		fmt.Printf("Working，processedCnt = %d\n"，processedCnt
	  		// If both in channel are closed, goroutine exit
	       if in1 == nil && in2 == nil {
	  	return
	  )
	  ```
-