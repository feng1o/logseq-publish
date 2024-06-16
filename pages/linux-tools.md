- fzf ag工具
	- ```
	   fzf
	  
	  cloud devnet need source config in current tty~
	  
	  2.界面配置：export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
	  
	  reverse翻转输入框上下！
	  
	  https://keelii.com/2018/08/12/fuzzy-finder-full-guide/  配置使用--tip
	  
	  alias fv='vim $(fzf)'
	  alias cdf='cd $(dirname $(fzf))'
	  -----------------------------------------------
	  安装ag:
	  yum install epel-release 
	  yum install the_silver_searcher  # debian apt-get install silversearcher-ag
	  ```
	-
- ```
  
      常用：
          Ctrl L ：清屏
          Ctrl M ：等效于回车
          Ctrl C : 中断正在当前正在执行的程序
  
      历史命令：
          Ctrl P : 上一条命令，可以一直按表示一直往前翻
          Ctrl N : 下一条命令
          Ctrl R，再按历史命令中出现过的字符串：按字符串寻找历史命令（重度推荐）
  
      命令行编辑：
          Ctrl A ： 移动光标到命令行首
          Ctrl E : 移动光标到命令行尾
          Ctrl B : 光标后退
          Ctrl F : 光标前进
          Alt F : 光标前进一个单词 esc - F
          Alt B : 光标后退一格单词 esc - B
          Ctrl ] : 从当前光标往后搜索字符串，用于快速移动到该字符串
          Ctrl Alt ] : 从当前光标往前搜索字符串，用于快速移动到该字符串
          Ctrl H : 删除光标的前一个字符
          Ctrl D : 删除当前光标所在字符
          Ctrl K ：删除光标之后所有字符
          Ctrl U : 清空当前键入的命令
          Ctrl W : 删除光标前的单词(Word, 不包含空格的字符串)
          **Ctrl \ ** : 删除光标前的所有空白字符
          Ctrl Y : 粘贴Ctrl W或Ctrl K删除的内容
          Alt . : 粘贴上一条命令的最后一个参数（很有用）
          Alt [0-9] Alt . 粘贴上一条命令的第[0-9]个参数
          Alt [0-9] Alt . Alt. 粘贴上上一条命令的第[0-9]个参数
          Ctrl X Ctrl E : 调出系统默认编辑器编辑当前输入的命令，退出编辑器时，命令执行
  
  ```