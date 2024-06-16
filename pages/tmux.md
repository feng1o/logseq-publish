- ```
  Tmux 就是会话与窗口的"解绑"工具，将它们彻底分离。然后可以attached上去，tmux a -t xx; 
  session, pane, window概念； 一个window可以split多个pane（窗格），pane之间切换prefix 箭头，ctr箭头调整大小；
  prefx % " 拆分 pane；；多个window是prefix c，然后还是要attach到session，session可以有多个window； 
  一个window可以拆分多个pane
  
  window： -c 一般可以搞多个，比如进入session后，ctrl+b c就创建一个窗口，左下角显示数量，选择ctrl+b 1..n
           -b 关闭：ctrl+b & ，或者exit
           -w 窗口列表
        
  pane:  -% "  切分 
         -x 关闭
         -o 转pane
         -; 切换到最近的
  tmux: 关闭 ctrl + d； 等价于exit，是推出了；不是detach； detach后还可以attach上去继续操作；
  					tmux detach #0 断开当前0会话，会话在后台运行
  tmux: session 里的 key需要 ctr+ b激活，？显示帮助，
  tmux new -s <name>  新建session
  tmux ls；   tmux attach -t 0；  tmux kill-session -t 0； tmux switch -t 0
  tmux split-window -h;  tmux select-pane -UDLR; 移动格子tmux swap-pane -UD
  ```
- 常用：
	- tmux
	- tmux ls
	- ctrl b + c    创建一个窗口
	- ctrl b + w   list 窗口
	- ctrl b + & 关闭一个 窗口
	- ctrl b + "  分pane
	- ctrl b + ;  最近pane
	- ctrl b + o 转
	- ctrl b + x 关闭pane
	- ctr d  推出session
	- tmux detach #0  推出session后台
	- tmux atach -t 0 进入
- 看历史输出： ctrl b + [进入查看模式   ---- iterm2上没生效？
- [[$green]]==全屏==  ctrl  b + z  切多个pane后，可把当前pane全屏
- mac: resize pane
	- Ctrl+B, then Esc + (arrow key)
	- ctrl + b之后命令行:  resize-pane -L  3， 可左移动
-
-