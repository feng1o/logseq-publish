- golang多版本
	- ```json
	  # golang version
	  MYGOVERSION="1.21.9"
	  export GOROOT="/usr/local/go/go$MYGOVERSION"
	  
	  #export GOPATH="/Users/xxx/go/go$MYGOVERSION"
	  export GOPATH="/Users/xxx/go/"
	  # 默认的goroot
	  #GOROOT='/usr/local/go'
	  export PATH=$PATH:$GOROOT/bin
	  ```
- pkg dir 工具问题： [ck](https://www.jb51.net/article/181319.htm)
	- ```
	  （1） 一个包确实可以由多个源文件组成，只要它们开头的包声明一样 package p1
	  （2）一个包对应生成一个*.a文件，生成的文件名并不是包名+.a
	  （3） go install ××× 这里对应的并不是包名，而是路径名！！  --- > go mod管理后会是mod名字,标注的github.com/xx/xx模式
	  （4） import ××× 这里使用的也不是包名，也是路径名-mod后还是mod
	  （5） ×××××.SayHello() 这里使用的才是包名！
	  （6） go install 遇到的问题
	  		A.无gomod=off，可以编译，因为set了gopath后，会去当前dir找目录包，能找到，底层gomod也无关联其他的
	          B.gomod=on后，go install  xxxx； 
	          	a.报错包不标注需要xx.com/格式， b.改gomod为xx.com/p后会提示.package p is not in GOROOT 
	  		需要指定github.comf/xxx/xxx 会去拉代码到pkg/gomod？ 然后编译，本地怎么搞？本地cd到对应目录ok，但是不符合预期？
	          C.报错：github.comf/xxx/xxx？go-get=1 404是因为去github.com去远程拖项目了，本地没有；
	             那本地怎么有？
	          D. local import后不能go install 外面； 如任何地方能go install github.com/xx必须路径对，能拖代码，本地不行，本地需要cd到对应目录
	          E. go install如果任意地方都阔，不可包含replace； 必须在github.com/name/bap下有个go.mod且名字对，
	   				go install github.com/name/bap/xxx，因其会去一层层递归查询有就clone袭来
	  （7） 新版支持相对路径导入 ./xxxx 和xxxx是不一样的，xxx要去goroot gopath找包(目录)
	  （8） go get去哪里？gopath， 如gomod在GOPATH/pkg/mod里
	  ```
	- gomod   ==export GO111MODULE=on; go env GO111MODULE==
		- 没开gomod会到gopath下找文件路径，比如go install xxxxx就是找xxx目录；gomod后必须是标注格式github.com/xxx/xxxx会去下载，或者本地有就本地
		- 一个项目不同目录都可以有一个gomod，不过gomod如果能被get，必须满足：github.com/your_name/pkg_name 这个是可下载的路径 
		  比如： go.mod --- github.com/your_name/pkg_name
		  ```
		  有如下路径： main.go
		             pkg/p1
		  如果P1想直接被get到，p1下没有gomod，必须go get github.com/your_name/pkg_name； 
		  					然后import  github.com/your_name/pkg_name/p1 
		  
		  也可以直接在p1下面： go mod ---> github.com/your_name/pkg_name/p1 
		  					这样可以直接go get github.com/your_name/pkg_name/p1
		  ```
- goland自动打印函数变量，err日志，打印变量
	- 导入如下设置到goland，file->manage ide settings-> import setttings  [settings.zip](../assets/settings_1717160575395_0.zip)
	- 使用说明
		- 打印函数入参：在函数内输入`/li`，按tab即可
		- error处理：在error下面，输入`/er`，按tab即可
		- 打印变量：复制要打印的变量，然后在要加log的位置输入`/lc`，按tab即可
		- ```go
		  func (jm *JobManager) OperateJob(jobId string, operate Operate) error {
		    	// li tab
		  	log.Info("OperateJob[:1]: jobId = %v, operate = %v", jobId, operate)
		  	// err tab
		      if err != nil {
		  		log.Error("%v", err)
		  		return
		  	}
		  	var copyVar = 110
		    	// copy copyVar lc tab
		  	log.Debug("OperateJob: copyVar = %+v", copyVar)
		  }
		  ```
	-
