- [quote-all](https://blog.csdn.net/guyongqiangx/article/details/118866795).    -> [quote-url](https://zhuanlan.zhihu.com/p/257084586)
	- ```bash
	  LIBS= -lssl   -lz -lcrypto  
	  ./init-db
	  ./update-cache  t.md
	  
	  .dircache/
	  ├── index
	  └── objects
	      ├── 00
	      │   └── 0767ab77f497b7c105d0c14a31c0363acaefee
	      ├── 01
	      ├── 02
	      ├── 03
	      ├── 04
	      
	  ./cat-file   000767ab77f497b7c105d0c14a31c0363acaefee  //需要加上obj下的00、前缀, 辅助工具，看暂存区obj的内容
	  	temp_git_file_9JZydt: blob
	  cat ./temp_git_file_9JZydt
	  
	  修改t.md
	  ./show-diff  #see diff
	  
	  ```
	- ./show-diff
		- 工作区和暂存区中的文件差异。
		  读取并解析索引文件：.dircache/index。
		  循环遍历变更文件信息，比较工作区中的文件信息和索引文件中记录的文件信息差异。
		  无差异，显示 : ok。
		  有差异，调用 diff 命令输出差异内容。
	- write-tree：写入到tree
		- write-tree 作用将保存在索引文件中的多个objects对象归并到一个类型为tree的objects文件中，该文件即Git中重要的对象：tree。
		- 读取并解析索引文件：.dircache/index。
		  循环遍历变更文件信息，按照指定格式编排变更文件信息及内容。
		  压缩并存储到objects文件中，该object文件为tree对象。
		- tree 对象用于存储多个提交文件的信息。tree 对象由
			- type + size + [[#red]]==[(文件模式mod + 文件名称 + 文件sha1值)f1,   ...fn]==
	- ./read-tree
		- 解析sha1值。
		  读取对应sha1值的object对象。
		  输出变更文件的属性、路径、sha1值。
	- /commit-tree
		- commit-tree 把本地变更提交到版本库里，具体是基于一个tree对象的sha1值创建一个commit对象。
		- 参数解析。
		  获取用户名称、用户邮件、提交日期。
		  写入tree信息。
		  写入parent信息。
		  写入author、commiter信息。
		  写入comments（注释）。
		  压缩并存储到objects文件中，该object文件为commit对象。
		  commit 对象存储一次提交的信息，包括所在的tree信息，parent信息以[及提交的作者等信息](https://zhuanlan.zhihu.com/p/257084586)
			-
	- objects文件:
		- 存储重要对象：blob、tree、commit，经过zlib压缩
	- blob 对象
		- ./update-cache会更新blob
		- blob内容是
			- ascii的文本实际上就是你文件的内容快照，格式为:  [[#red]]==type==  [[#green]]==size== [[#blue]]==file-content== ，经过zlib --> binary文件
			- ./cat-file可以吧blob文件给读出来到当前目录，可看到内容  -- cat-file只是一个工具实际工程无用
			- ./update-cache加到暂存区后，show-diff就无差异了，此时已经把工作区的修改文件快照加入到了blob(每次新增都有个一个blob)，可以看到blob相比文件有3倍的压缩，比如txt文件新增后10k，新的blob文件大致是3k，而且这个blob里的内容就是全部的，非增量的
	- tree对象
		- ./write-tree触发
	- commit对象
		- ./commit-tree触发，会有一些映射到obj、tree
	- index文件
		- ./update-cache时会将文件的一些ctime、mod、size等记录下来
-