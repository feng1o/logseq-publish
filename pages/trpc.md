- 一个服务进程可能会监听多个端口，在每个端口上支持不同的业务协议，这种在同时兼容多个业务协议时是非常有帮助的。因此server层的设计就必须将进程、服务、逻辑服务的概念进行进一步的抽象设计。
- 提炼出了进程、服务（server)、逻辑服务（service）的概念。通常一个进程包含一个server，每个server可以包含一个或者多个逻辑service。
- [example](https://LW1rLXdhLWNtLQo=/group/37444/articles/show/474712?kmref=search&from_page=1&no=4)
	- ```
	  mux := http.NewServeMux()
	  	mux.Handle("/abc/xxx", Handler(&struct{}) 对象，不是函数)； how to router?
	  
	  client 对server的服务发现？  无name服务，直接指定server
	  ```
- [[trpc-server]]  [[trpc-client]] 开发
- [pb-validate-PGV](https://LWdpdC13YS1jbS0K/devsec/protoc-gen-secv)
- 示例是： 服务作为一个Proxy -- proxy实现？，接收标准HTTP服务请求，然后转化成tRPC协议格式向后端的tRPC服务发送请求。 示例代码如下：
- <span> <a class=ask>是否all struct可通过pb定义，如何取舍 </a>  <span class=" bg-green white  subw hblack hover"> [[2022-09-08 Thu]] </span></span>
- <p class="gray subw  inline_box underline"><span style="color: red;background-color: lightblue;font-weight:bold;font-size:11px"> 总体Tip:</span>pb定义message类型后，通过service服务，生成对应的pb文件，serveice只是生成interface定义+stub注册方法，在调用时regist用到这里其他就是具体实现，可重复regist</p>
	- ```
	  pb.RegisterIsoService(s, &isoImpl{})
	  //s.Register(pb.IsoServer_ServiceDesc, &isoImpl{})
	  ```
	- 一个服务进程监听多个port：通过service:里的配置多个 &&  在pb里定义对应的service
	- ```
	  service Hello {  
	        rpc SayHello (HelloRequest) returns (HelloReply) {option (trpc.alias) = "/cgi-bin/hello";};
	  }
	      
	  // 工具生成后这就有2个服务要register，
	  service Hello2 {
	        rpc SayHello (HelloRequest) returns (HelloReply) {option (trpc.alias) = "/cgi-bin/hello";};
	  }
	  			trpc.test.rpchttp ---- server名字， hello:是proto里的service，定义多个这里就多个
	              pb只需要定义一个service，register的时候会自动注册到配置的所有service上。
	              https://LWdpdC13YS1jbS0K/trpc-go/trpc-go/tree/master/server
	  
	  
	      - name: trpc.test.rpchttp.Hello      #service的路由名称
	        ip: 127.0.0.1                            #服务监听ip地址 可使用占位符 ${ip},ip和nic二选一，优先ip
	        #nic: eth0
	        port: 8000                #服务监听端口 可使用占位符 ${port}
	        network: tcp                             #网络监听类型  tcp udp
	        protocol: http               #应用层协议 trpc http
	        timeout: 1000                            #请求最长处理时间 单位 毫秒
	        
	      - name: trpc.test.rpchttp.Hello2      #service的路由名称
	        ip: 127.0.0.1                            #服务监听ip地址 可使用占位符 ${ip},ip和nic二选一，优先ip
	        #nic: eth0
	        port: 8001                #服务监听端口 可使用占位符 ${port}
	        network: rpc                             #网络监听类型  rpc   
	        protocol: http               #应用层协议 trpc http
	        timeout: 1000                            #请求最长处理时间 单位 毫秒
	  ```
	- step:
		- <span class="subw8">a.定义proto，几个service(proto里定义的，conf里的service和proto一致，可多不可少), 参数？ 比如一个管理dev的，一个管理inst的，并且可能分在多个端口不同协议http rpc等</span>
		- <span class="subw8">b.工具生成服务代码，包含proto和rpc的一些interface，stub等； 这里定义了对应service的interface，应该怎么实现impl； response均作为参数指针，函数返回只有error，可改</span>
		- <span class=subw8>c.proto定义决定了有几个service regist，如何拆分，其他就是配置项</span>
		- <span class=subw8>d.regist里的即是proto里定义的service具体方法的实现，也就是基本的业务逻辑</span>
		- <span class="subw8">e.最后根据生成的stub interface实现对应service的方法，并在server里regist</span>
		- <span class="subw8">f.-[trpc_sign_management.git](livecenter_toB/trpc_sign_management.git) - </span>
- DONE -
	- [[trpc反向代理]]
	- [[service映射关系]]
	- <span> <a class=ask href=https://mk.LW9hLWNtLQo=/search?keyword=context%20deadline%20exceeded>trpc超时管理- </a>  <span class=" bg-green white  subw hblack hover"> [[2022-09-20 Tue]] </span></span>
- ##### TIP
	- service注册 [http-rpc-test.tgz -- code详见](../assets/http-rpc-test_1666582547554_0.tgz)
		- http-rpc的服务，可以通过http比如/cgi-bin/hello 调用，如果注册的时候支持了其他协议，如rpc一样可以调用`trpc-cli -func /cgi-bin/hello   -target ....`
		- `127.0.0.1:8000/trpc.test.rpchttp.Hello2/SayHello` 比如这个hello2，proto service没有指定注册路由，就是默认server desc 里描述的路径
		- ```go
		  var HelloServer_ServiceDesc = server.ServiceDesc{                                                                                                        
		      |   ServiceName: "trpc.test.rpchttp.Hello",
		      |   HandlerType: ((*HelloService)(nil)),
		      |   Methods: []server.Method{
		      |   |   {
		      |   |   |   Name: "/cgi-bin/hello",    -----能调用的方式 --能以什么方式调用取决于开启的server种类，和regist的方式，调用host一定这个注册的
		      |   |   |   Func: HelloService_SayHello_Handler,
		      |   |   },
		      |   },
		  }
		  // Hello2Server_ServiceDesc descriptor for server.RegisterService
		  var Hello2Server_ServiceDesc = server.ServiceDesc{                                                                                                                       
		  |   ServiceName: "trpc.test.rpchttp.Hello2",
		  |   HandlerType: ((*Hello2Service)(nil)),
		  |   Methods: []server.Method{
		  |   |   {
		  |   |   |   Name: "/trpc.test.rpchttp.Hello2/SayHello",
		  |   |   |   Func: Hello2Service_SayHello_Handler,
		  |   |   },
		  |   },
		  }
		  ```
		- ```
		   trpc create --protofile hello.proto --alias --protocol http  --rpconly
		   trpc create --protofile hello.proto --alias --protocol http  --rpconly -o hello/stub/Z2l0LWNkLQo=LW9hLWNtLQo=/trpcprotocol/test/rpchttp/
		   //在重新生成prc时，这里指定http不是重点，支持哪种协议是配置的server里的service，生成后都是有的，regist对应service即可
		  ```
		- ```protobuf
		      syntax = "proto3";
		      package trpc.test.rpchttp;
		      option go_package="Z2l0LWNkLQo=LW9hLWNtLQo=/trpcprotocol/test/rpchttp";
		      import "trpc.proto";
		  
		      service Hello {
		        rpc SayHello (HelloRequest) returns (HelloReply) {option (trpc.alias) = "/cgi-bin/hello";};
		      }
		      service Hello2 {
		        rpc SayHello (HelloRequest) returns (HelloReply) {};
		      }
		      // 请求参数
		      message HelloRequest {
		        string msg = 1;
		        string name = 2;
		      }
		      // 响应参数
		      message HelloReply {
		        string msg = 1;
		      }
		      
		      //trpc create --protofile hello.proto --alias --protocol http
		  ```
		- ttt:: 为什么这个可以??? curl -X POST -d '{"msg":"hello----","name":"-name"}' -H "Content-Type:application/json" http://127.0.0.1:8000/trpc.test.rpchttp.Hello2/SayHello
		  <span class=subw>curl -X POST -d '{"msg":"hell--"}' -H "Content-Type:application/json" http://127.0.0.1:8000/cgi-bin/hello
		  trpc-cli -func /cgi-bin/hello   -target ip://127.0.0.1:8001 -body '{"msg":"hello"}'
		  
		  curl -X POST -d '{"msg":"helloe"}' -H "Content-Type:application/json"http://127.0.0.1:8000/trpc.test.rpchttp.Hello2/SayHello
		  trpc-cli -func /trpc.test.rpchttp.Hello2/SayHello  -target ip://127.0.0.1:8001 -body '{"msg":"hello"}</span>
- [[my-do]]