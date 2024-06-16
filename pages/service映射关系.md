- [doc](https://LWdpdC13YS1jbS0K/trpc-go/trpc-go/tree/master/server)
- #### service映射关系
	- 配置文件也写了多个service，如：
	  
	  ```yaml
	  server:                                             #服务端配置
	     app: test                                        #业务的应用名
	     server: helloworld                               #进程服务名
	     close_wait_time: 5000                            #关闭服务时,反注册后到真正停止服务之间的等待时间,来支持无损更新,单位ms
	     service:                                         #业务服务提供的service，可以有多个
	   - name: trpc.test.rpchttp.Hello          #service的路由名称
	     ip: 127.0.0.1                                #服务监听ip地址 可使用占位符 ${ip},ip和nic二选一，优先ip
	     port: 8000                                   #服务监听端口 可使用占位符 ${port}
	     protocol: http                              #应用层协议 rpc http
	   - name: trpc.test.rpchttp.Hello2          #service的路由名称
	     ip: 127.0.0.1                                #服务监听ip地址 可使用占位符 ${ip},ip和nic二选一，优先ip
	     port: 8081                                   #服务监听端口 可使用占位符 ${port}
	     protocol: rpc                               #应用层协议 trpc http
	  ```
	- 首先创建一个server，svr := trpc.NewServer()，配置文件定义了多少个service，就会启动多少个service逻辑服务
	- 组合方式：
		- 单个proto service注册到server里面：pb.RegisterHelloServer(svr, helloImpl) 这里会将协议文件内部的hello server desc注册到server内部的所有service里面
			- ```go
			  pb.RegisterHelloService(s, &helloServiceImpl{})
			  pb.RegisterHello2Service(s, &hello2ServiceImpl{})  
			  	---  hello server desc全部注册到server[hello hello2]中
			  	// HelloServer_ServiceDesc descriptor for server.RegisterService
			      var HelloServer_ServiceDesc = server.ServiceDesc{                                                                                                        
			      |   ServiceName: "trpc.test.rpchttp.Hello",
			      |   HandlerType: ((*HelloService)(nil)),
			      |   Methods: []server.Method{
			      |   |   {
			      |   |   |   Name: "/cgi-bin/hello",    --------    能调用的方式
			      |   |   |   Func: HelloService_SayHello_Handler,
			      |   |   },
			      |   },
			      }
			  
			  curl -X POST -d '{"msg":"hell--"}' -H "Content-Type:application/json" http://127.0.0.1:8000/cgi-bin/hello
			  trpc-cli -func /cgi-bin/hello   -target ip://127.0.0.1:8001 -body '{"msg":"hello"}'
			  
			  curl -X POST -d '{"msg":"helloe"}' -H "Content-Type:application/json" http://127.0.0.1:8000/trpc.test.rpchttp.Hello2/SayHello
			  trpc-cli -func /trpc.test.rpchttp.Hello2/SayHello  -target ip://127.0.0.1:8001 -body '{"msg":"hello"}'
			  ```
		- 单个proto service注册到service里面：pb.RegisterByeServer(svr.Service("trpc.test.helloworld.Greeter1"), byeImpl) 这里只会将协议文件内部的bye server desc注册到指定service name的service里面
		- 多个proto service注册到同一个service里面pb.RegisterHelloServer(svr.Service("trpc.test.helloworld.Greeter1"),helloImpl) 
		  pb.RegisterByeServer(svr.Service("trpc.test.helloworld.Greeter1"), byeImpl)，这个Greeter1逻辑service同时支持处理不同的协议service处理函数
			- ```go
			  pb.RegisterHelloService(s.Service("trpc.test.rpchttp.Hello"), &helloServiceImpl{})
			  pb.RegisterHello2Service(s.Service("trpc.test.rpchttp.Hello"), &hello2ServiceImpl{})
			  
			  注册到service: trpc.test.rpchttp.Hello；那因为trpc.test.rpchttp.Hello都是http的，故hello和hello2都
			  只支持http的，rpc的未注册
			  
			  curl -X POST -d '{"msg":"hell--"}' -H "Content-Type:application/json" http://127.0.0.1:8000/cgi-bin/hello
			  curl -X POST -d '{"msg":"helloe"}' -H "Content-Type:application/json" http://127.0.0.1:8000/trpc.test.rpchttp.Hello2/SayHello
			  其他rpc-cli都失效
			  ```