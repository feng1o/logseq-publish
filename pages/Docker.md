- Docker和vm区别？
	- docker轻量级，vm需要虚拟一个完整的软硬件系统
- Docker安装：
	- 默认工作路径var.lib.docker:: 可通过软连接把路径指向其他，然后重启，或者修改配置mv /var/lib/docker  /data/docker/lib/ &&  ln -s /data/docker/lib/docker /var/lib/docker
	- 镜像(image) :: docker images , docker rmi， 删除必须停止容器  docker rm xxx
	- 容器(container) image运行的实体，process <sub>可以拥有自己的 root 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间</sub>
		- <span class=" bg-green white  subw hblack hover">容器不应该向其存储层内写入任何数据，容器存储层要保持无状态化。所有的文件写入操作-volume 或bind宿主目录</span>
		- 容器由image的实例化而来的； 可抽象为：镜像是文件，容器是进程
	- 仓库(registery)
- docker命令
	- docker version
	- docker images
		- docker commit -m 'test-image' b24bf04dc3ef  'add-nginx'
		- docker rmi a092fca4ede1
		- 对于同一个image的不同镜像，docker rmi  xxx2:version
	- docker run ---》 本机找？ 没有，去docker hub找---》下载本地----》运行
		- docker run -p 8080:80 -d(daemon)
		- docker ps [-a]
		- [docker run -it --rm ubuntu:18.04 bash  ](https://yeasy.gitbook.io/docker_practice/image/pull)
	- docker system df  *命令来便捷的查看镜像、容器、数据卷所占用的空间*
	- docker stop/rm $(docker ps -a -q)
- docker镜像
	- 分层存储
	- 虚悬镜像(dangling image) :  docker image ls -f dangling=true
		- pull或build，新版本发布，旧的名字就变成none了
	- 中间层镜像：docker image ls -a  <span class='gray'>会看到很多无标签的镜像，与之前的虚悬镜像不同，这些无标签的镜像很多都是中间层镜像，是其它镜像所依赖的镜像</span>
	- 镜像体积:: docker system df
	- 展示：
		- docker image ls -f 过滤/  指定镜像， ls展示顶层镜像
		- docker image ls --digests
		- docker image ls -q  格式化输出 <span class=blue>docker image ls --format "{{.ID}}: {{.Repository}}"</span>
	- 删除
		- docker image rm
		- untagged  和deleted：  <span class=gray>镜像的唯一标识是其 ID 和摘要，而一个镜像可以有多个标签</span>, <span class=gray>求删除某个标签的镜像。所以首先需要做的是将满足我们要求的所有镜像标签都取消，这就是我们看到的 Untagged 的信息</span>
	- 利用 [commit](https://yeasy.gitbook.io/docker_practice/image/commit) 看image构成
		- commit可以用来保存现场等。但是不用用docker commit构建镜像，应该使用dockerfile
		- docker run --name webserver -d -p 80:80 nginx
		- docker exec -it webserver bash    <span class="bg-yellow blue">通过该命令可修改内容</span>
		- docker diff webserver     可看到改动
		- ``` 存储为镜像
		  	docker commit \
		      --author "Tao Wang <twang2218@gmail.com>" \
		      --message "修改了默认网页" \
		      webserver \
		      nginx:v2
		  sha256:07e33465974800ce65751acc279adc6ed2dc5ed4e0838f8b86f0c87aa1795214
		  ```
		- docker history nginx:v2
		- docker-commit:: 意味着所有对镜像的操作都是黑箱操作，生成的镜像也被称为 ==黑箱镜像==, 就是只有commit的人知道改了什么，其他人不知道，还一个会加入很多非必要的文件
		- 比如基于一个continer:  docker exec后修改了内容，然后docker commit 保存为一个新的image
- docker数据卷
- [dockerfile](https://yeasy.gitbook.io/docker_practice/image/build)
	- FROM - base image  RUN - main中执行的命令 COPY  ADD CMD  EXPORSE WORKDIR ENV  ENTRYPOINT入口  USER  VLUME
	- scratch::  不以任何镜像为基础，是个空的。比如linxu下静态编译的程序，并不需要有操作系统支持，所需的一切都在bin文件里了。使用go语言一般可通过这种方式做镜像
	- ```rrshell
	  FROM ubuntu   #scratch
	  MAINTAINER lf
	  #RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
	  RUN apt-get update \
	  && apt-get install -y nginx 
	  # RUN apt-get install -y nginx   # 每次执行run就是一层，所以一般是放在一个run里执行 通过&& \连起来
	  COPY index.html /var/www/html   # 不是复制执docker build 命令所在的目录下的 .
	                                  # 也不是复制 Dockerfile 所在目录下的 package.json，而是复制 上下文（context） 目录下的 package.json。
	  ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
	  EXPOSE 80	
	  ```
	- docker build [doc](https://yeasy.gitbook.io/docker_practice/image/build)
		- 构建上下文：
			- ![image.png](../assets/image_1653493636741_0.png)
		- docker build 还支持从 URL 构建，比如可以直接从 Git repo 中构建：$ docker build -t hello-world https://github.com/docker-library/hello-world.git#master:amd64/hello-world
		- COPY: ADD能自动解压
			- COPY 指令将从构建上下文目录中 <源路径> 的文件/目录复制到新的一层的镜像内的 <目标路径> 位置
		- ENTRYPOINT 和CMD类似： 场景 1.镜像当命令使用，2. app应用准备工作[doc](https://yeasy.gitbook.io/docker_practice/image/dockerfile/entrypoint)
			- 总结来说，**Entrypoint是指定容器启动时要执行的默认命令，它在运行容器时不能被覆盖。** **而Cmd是指定容器启动时要执行的默认命令参数，它可以被覆盖**。 通常情况下，Entrypoint用于指定容器启动时要运行的应用程序，而Cmd用于指定应用程序的默认参数。 简单理解，docker run  xxx  ping  127.1 ， 这个如果xxx里有cmd这里ping就给改了，entrypoint不能被改(希望只跑定义好的可用这个方式)
			- shell和exec表示法:
			  id:: 64c3ae6f-f375-4ee7-9dd4-61892e806f1e
				- CMD  executable param1  param2      `跑的是shell，ps -f看这个executable的父进程pid=1是sh`
				- CMD ["executable", "param1", "param2"]    `这个是直接exec跑，不依赖于sh`
		- ARG 和 env
		- EXPOSE 和run -P
		- WORKDIR : 指定工作目录.后续所有工作都在这个目录下 [doc](https://yeasy.gitbook.io/docker_practice/image/dockerfile/workdir)
		- HEALTHCHECK 指令是告诉 Docker 应该如何进行判断容器的状态是否正常
		- Dockerfile 多阶段构建
	- 构建支持多种系统架构的docker镜像
- 操作容器
	- docker  run -it -p80:80. xxx:v. tag -d ....
	- docker container ls  -- docker ps   # continer 是后面加的为了分类命令
	- ```
	  docker container ls --all --quiet --no-trunc --filter "name=web-server-10"  #显示container 长id
	  ```
	-
	- docker exec -i xxxid bash     |  docker attach 退出后container也结束
	- docker export import 导入出
- 访问registory [doc](https://yeasy.gitbook.io/docker_practice/repository/dockerhub)
	- docker pull 到本地
	- docker push 到dockerhub
	- docker  tag  ubuntu:latest 127.0.0.1:5000/ubuntu:latest 可以给ubuntu加个tag，然后push到regstory
	- <span> <a class=ask>  比如本地docker images? 然后加个docker tag， 在docker push； push的时候指定的后缀就是空间和名字？ </a>  <span class=" bg-green white  subw hblack hover"> [[2023-01-04 Wed]] </span></span>
	- ```
	  docker tag 3c127c5afaaa mirrors.tencent.com/zyp-cdboss/qta_test_oxj-name:oxj-name
	  docker push mirrors.tencent.com/zyp-cdboss/qta_test_oxj-name:oxj-name
	  
	  也可以通过dokcer save > xx.tar 然后docker load < xx.tar来通过机器换； 然后再dock tag [id] xxx:version
	   docker export和import可以导入出容器(这个会丢失历史和元数据)
	  ```
- 数据管理[doc](https://yeasy.gitbook.io/docker_practice/data_management)
	- volumes
		- 可以在容器之间共享和重用, container删除不会消失； 镜像中的被指定为挂载点的目录中的文件会复制到数据卷中（仅数据卷为空时会复制）。
		- >  docker volume create/rm my-vol    | docker volume prune
		  docker volume ls
		  docker volume inspect  my-vol
		- ```c
		  $ docker run -d -P \
		      --name web \
		      # -v my-vol:/usr/share/nginx/html \
		      --mount source=my-vol,target=/usr/share/nginx/html \
		      nginx:alpine
		  
		  # 挂载本机的一个目录到volume
		  $ docker run -d -P \
		      --name web \
		      # -v /src/webapp:/usr/share/nginx/html \
		      --mount type=bind,source=/src/webapp,target=/usr/share/nginx/html \
		      nginx:alpine
		  ```
		-
	- bind mounts: 挂载主机目录
- docker网络 [doc](https://yeasy.gitbook.io/docker_practice/network/port_mapping)
	- docker port  container可看
	- 容器互联： 随着 Docker 网络的完善，强烈建议大家将容器加入自定义的 Docker 网络来连接多个容器，而不是使用 --link 参数
	- $ docker network create -d bridge my-net； 然后run的时候指定；多个就docker compose
	- 配置DNS:
	-
	- docker的mac上，宿主机是无法ping通容器的ip的，mac [docker](https://LWN0Y3QtY20tCg==/product/tke?from_column=20065&from=20065) 实现的桥接网络是通过了一个linux 虚拟机实现,并不是直接在mac宿主机上创建虚拟网卡,导致无法ping通
		- [docker-connector 可打通](https://xyzghio.xyz/ConnectBridgeNetInDocker/)
	-
- docker compose[doc](https://yeasy.gitbook.io/docker_practice/compose/compose_file)
	- 定位是 「定义和运行多个 Docker 容器的应用（Defining and running multi-container Docker applications）」，其前身是开源项目 Fig；管理多个容器，可能还有相互依赖的问题
	- 通过一个单独的 docker-compose.yml 模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）
	-
- <span> <a class=ask>  docker ps -a看到的历史container，里的volume，怎么理解？ 必须rm container才能清理 vlume </a>  <span class=" bg-green white  subw hblack hover"> [[2022-09-08 Thu]] </span></span>
- docker run -d --name myMysql -p 20198:20198 -v/Users/用户/go/work_space/src/glue/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=oxj-nametest mysql:5.7
- docker exec -it 91a28f5ba993 bash
-
- `example-做一个镜像并push`<span class=" bg-green white  subw hblack hover"> [[2023-01-06 Fri]] </span>
	- ```
	  FROM  mirrors.xxxx.com/xdevcloud_ci/xlinux:1
	  MAINTAINER x 
	  RUN  mkdir -p /data/x/
	  #&& apt-get install -y nginx 
	  # RUN apt-get install -y nginx   # 每次执行run就是一层，所以一般是放在一个run里执行
	  COPY  txt  /data/x/
	                                  # 也不是复制 Dockerfile 所在目录下的 package.json，而是复制 上下文（context） 目录下的 package.json。
	  #ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
	  #EXPOSE 80
	  ```
	- 命令:: docker build -t  mirrors.xxx.com/oxj-name-space/mtlinux:latest .(.值conte上下文目录当前，有个txt文件),build的时候不指定-tag，结束后需对镜像加tag，然后push
	- push::  docker push mirrors.xxx.com/oxj-name-space/mlinux:latest
- [[docker-faq]]
- [[docker-examp]]
- commonsense
	- Docker 容器里应用的日志，默认会保存在宿主机的 /var/lib/docker/containers/{{. 容器 ID}}/{{. 容器 ID}}-json.log 文件里