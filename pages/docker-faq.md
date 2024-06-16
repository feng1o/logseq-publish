- container和宿主机的目录
	- ```bash
	  # 通过docker的container id，在宿主机之间cp文件
	  docker container ls --all --quiet --no-trunc --filter "name=web-server-10"
	  docker inspect -f '{{.GraphDriver.Data.UpperDir}}'   container的id
	  # /var/lib/docker/overlay2/b87977de70f18f70a898e16e8a781d997f8bc54b320e5b9f7051386a5234d4e6/diff 可将文件copy到此处，在container
	  
	  # k8s和宿主机之间，pod的container id，通过container id查询本地var找到，再cp，同上
	  
	  ```
	-
- docker宿主机目录
	- ```cpp
	  root@10.80:/var/lib/docker# tree -L 2
	  ├── builder
	  │   └── fscache.db
	  ├── buildkit
	  │   ├── cache.db
	  │   ├── content
	  │   ├── executor
	  │   ├── metadata.db
	  │   └── snapshots.db
	  ├── containerd
	  │   └── daemon
	  ├── containers      # docker run 加
	  │   ├── 1a2add212c0cf4f6dd4869623498eab7a1ac4cdd5e4781e5640af047b417ef54
	  │   ├── 2b55e4854f24f4da6436ac2aea8b3d3c9d47c2b8f598a12c803c8dd05b0aab5f
	  ├── image
	  │   └── overlay2  #overlay和overlay2(Docker1.12+)是docker的存储驱动
	  ├── network
	  │   └── files
	  ├── overlay2  # docker pull 这里
	  │   ├── 06edb398dc194f080ae45bddd7281ea54d4b1f7ee142d36211a346c94a89753e
	  │   ├── 1ab700106cebacd6da6e3e045398996a72cc98656b58c7632e6a93c6b76195e3
	  │   └── l
	  ├── plugins
	  │   ├── storage
	  │   └── tmp
	  ├── runtimes
	  ├── swarm
	  ├── tmp
	  ├── trust
	  └── volumes
	      └── metadata.db
	  ```
