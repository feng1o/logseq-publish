- https://github.com/hibiken/asynq  --  框架kekan <span class=alg-1stars> </span>
- DONE https://gist.github.com/harlow/dbcd639cf8d396a2ab73  -- 详细分析介绍
- [doc-all](https://blog.csdn.net/liyunlong41/article/details/108276550?csdn_share_tail=%7B%22type%22%3A%22blog%22%2C%22rType%22%3A%22article%22%2C%22rId%22%3A%22108276550%22%2C%22source%22%3A%22unlogin%22%7D) <span class=alg-3stars>im</span>
- > [[work]] practical
	- [example](https://medium.com/hdac/producer-consumer-pattern-implementation-with-golang-6ac412cf941c)   [complex-example](http://nesv.github.io/golang/2014/02/25/worker-queues-in-go.html) go并发的模式pattern
		- ```go
		  package main
		  
		  import (
		  	"fmt"
		  	"sync"
		  	"time"
		  )
		  
		  func fanOutUnbuffered(ch <-chan int, size int) []chan int {
		  	cs := make([]chan int, size)
		  	for i, _ := range cs {
		  		// The size of the channels buffer controls how far behind the recievers
		  		// of the fanOut channels can lag the other channels.
		  		cs[i] = make(chan int)
		  	}
		  	go func() {
		  		for i := range ch {
		  			/*
		  				// 这个是每个轮流消费一个消息
		  				for _, c := range cs {
		  					c <- i
		  				}
		  			*/
		  
		  			// 固定3个谁处理完继续，这里可等待的channel是硬编码的，无法动态
		  			/*
		  				select {
		  				case cs[0] <- i:
		  					fmt.Println("Write successful, 0 ", i)
		  				case cs[1] <- i:
		  					fmt.Println("Write successful, 1 ", i)
		  				case cs[2] <- i:
		  					fmt.Println("Write successful, 2 ", i)
		  					//case <-time.After(1 * time.Second):
		  					//fmt.Println("Write timeout occurred,", i)
		  				}
		  			*/
		  
		  			// 这里可设置多个动态channel等
		  			fmt.Printf("i from ch : %d\n", i)
		  			for /*必须有个大循环，否则内部的timeout多次后x+到3，就会丢掉一条消息*/ {
		  				for x := 0; x < 3; x += 1 {
		  					done := false
		  					select {
		  					case cs[x] <- i:
		  						fmt.Println("Write successful: ", i, " to ", x, " channel")
		  						done = true
		  						goto label
		  						break
		  					case <-time.After(1 * time.Second):
		  						fmt.Println("Write timeout occurred: ", x)
		  					}
		  					if done {
		  						break
		  					}
		  				}
		  			}
		  		label:
		  		}
		  		for _, c := range cs {
		  			// close all our fanOut channels when the input channel is exhausted.
		  			close(c)
		  		}
		  	}()
		  	return cs
		  }
		  
		  func producer(iters int) <-chan int {
		  	c := make(chan int)
		  	go func() {
		  		for i := 0; i < iters; i++ {
		  			c <- i
		  			//time.Sleep(3 * time.Second)
		  		}
		  		close(c)
		  	}()
		  	return c
		  }
		  
		  	for i := range cin {
		  		fmt.Printf("consumerg mgs(%d)\n", i)
		  		time.Sleep(5 * time.Second)
		  	}
		  	fmt.Println("-------done")
		  	wg.Done()
		  }
		  
		  func consumer(cin <-chan int) {
		  	for i := range cin {
		  		fmt.Println(i)
		  		time.Sleep(1 * time.Second)
		  	}
		  }
		  
		  func consumer2(cin <-chan int) {
		  	for i := range cin {
		  		fmt.Println(i)
		  		time.Sleep(time.Duration(2) * time.Second)
		  	}
		  }
		  
		  func consumerc(cins []chan int) {
		  	var wg sync.WaitGroup
		  	wg.Add(3)
		  	for i, cin := range cins {
		  		fmt.Println("start consumer: %d", i)
		  		go consumerg(cin, &wg)
		  	}
		  	wg.Wait()
		  }
		  
		  func main() {
		  	c := producer(10)
		  	chans := fanOutUnbuffered(c, 3)
		  	/*
		  		go consumer(chans[0])
		  		go consumer2(chans[2])
		  		consumer(chans[1])
		  	*/
		  	consumerc(chans)
		  
		  }
		  ```
	-
- [go利用channel做任务分发](https://blog.csdn.net/u014618114/article/details/113108144)
-