- ```
  go get -u github.com/golang/protobuf/protoc-gen-go
  go get -u -t -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
  go install  github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
  ```
- [go-trpc-ex1](https://eddycjy.gitbook.io/golang/di-5-ke-grpcgateway/hello-world)  -contain exam - 01
  id:: 6369fc1f-1ada-43ee-8eec-1606c058000b
- grpc-gateway提供http和rpc服务 [doc](https://www.liwenzhou.com/posts/Go/grpc-gateway/)
	- 没有启用 TLS加密通信，所以这里使用 `h2c` 包实现对HTTP/2的支持。h2c 协议是 HTTP/2的非 TLS 版本。如果是非h2c需要启动TLS加密 ((6369fc1f-1ada-43ee-8eec-1606c058000b)) 有注解
	- ```
	  /data/golang/work_space/src/grpc-proj/helloworld/greeter
	  protoc -I=proto    --go_out=proto --go_opt=paths=source_relative    --go-grpc_out=proto --go-grpc_opt=paths=source_relative    --grpc-gateway_out=proto --grpc-gateway_opt=paths=source_relative    helloworld/hello_world.proto
	  # 把main里的 github.com/grpc-ecosystem/grpc-gateway/v2/runtim  没使用v2
	  
	  proto文件在子目录的 proto/下，在当前目录执行
	  protoc -I=proto    --go_out=proto --go_opt=paths=source_relative    --go-grpc_out=proto --go-grpc_opt=paths=source_relative    --grpc-gateway_out=proto --grpc-gateway_opt=paths=source_relative    ./proto/audit.proto
	  ```