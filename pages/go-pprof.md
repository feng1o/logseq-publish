- ```
  https://jvns.ca/blog/2017/09/24/profiling-go-with-pprof/ 列了很多pprof资料
  
  https://xguox.me/go-profiling-optimizing.html/  ***** 
  https://colobu.com/2019/05/22/profilinggo/  例子，未test，繁杂
  
  1. net/http/pprof
  仍然使用runtime/pprof，只是封装页面了，对于常驻后台server可以用； 但好像不支持cpu trace看；建议还是用runtime/pprof
  1.https://www.cnblogs.com/ghj1976/p/5473693.html
  
  a. https://www.infoq.cn/article/f69uvzJUOmq276HBp1Qb how use 结果展示分析不太明确 这个说明如果按照graphviz，可以看到火焰图？ 
  https://xguox.me/go-profiling-optimizing.html/
  
  b. 通过web页面不能看 profile和strace； 具体见1解释
  c. 命令
  go tool pprof http://localhost:20201/debug/pprof/profile?seconds=30
      top
      list
  
  go tool pprof -png  http://localhost:20201/debug/pprof/heap?seconds=3 > x.png 需要装graphviz        
  
  2. runtime/pprof
  https://blog.csdn.net/Vivid_110/article/details/100561459
  
  
  3. go-torch
  
  go.1.11后支持了？
  yum install 'graphviz*'
  
  go get github.com/uber/go-torch
  生成二进制，并加入到go的工具目录
  git clone https://github.com/brendangregg/FlameGraph.git
  将FlameGraph的目录加入到PATH中
  
  -       // 01. use net/http/pprof  can not get cpu trace by web
  -       //go func() {
  -       //      TLog.Info(http.ListenAndServe("127.x.0.1:20201", nil))
  -       //
  -       //}()
  -
  -       // 02. use runtime/pprof
  -       f, err := os.OpenFile("/data/profile.pub", os.O_RDWR|os.O_CREATE, 0644)
  -       if err != nil {
  -               TLog.Errorf("error, err:%v", err)
  -       }
  -       defer f.Close()
  -       pprof.StartCPUProfile(f)
  -       defer pprof.StopCPUProfile()
  -
          agent := NewApp() //start do
  
  
  
  
  
  运行；
  a.获取prof文件，go tool pprof -svg ./audit_agent  profile.pub 生成svg文件图 
  
  b.go tool pprof  ./audit_agent  profile.pub 直接调试防止代码到编译路径，查找cpu开销
  top 
  
  c.生成火焰图
  go-torch --binaryname=../audit_agent  --binaryinput=profile.pub
  ```
