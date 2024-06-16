- [shadowshocks ](http://note.youdao.com/noteshare?id=0c790ed72ff4013e166bbd524f1b78ac&sub=87BD83F9613E47ABB591315699AD411A)
	- ![shadowsocks.pdf](../assets/shadowsocks_1648052990734_0.pdf)
- windows #tools
	- 翻译插件 ==ImTranslator==
	- utools 快捷打开应用 管理
	- [桌面应用管理整理-coodesker-对比fence](https://www.coodesker.com/)
	- windows wsl安装：应用管理开启wsl服务，开启：
		- 管理员权限运行--powershell并运行：Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
		- xshell登录：
		  ```
		     23  ifconfig
		     24  sudo apt-get remove --purge openssh-server  # 删除
		     25  sudo apt-get install openssh-server  # install
		     26  sudo rm /etc/ssh/ssh_config          ## 删配置文件，让ssh服务自己想办法链接
		     27  sudo service ssh --full-restart     ## 放到service.sh里
		     30  vim service.sh  # 每次机器重启，需要执行一次
		  登录？必须先登录非root账号，然后su passwd ? 非root密码，输入root密码，why，不追究
		  ```
		- 必须注意path变量，需加入win上的配置目录
- [[mac]]
	- [brew zsh rz-sz](https://note.youdao.com/s/ArFx6U5L)  安装这个后，加载的不是bashrc了，需要改这个
	- <span class=" bg-green white  subw hblack hover"> [[2022-03-26 Sat]] </span>
	- nomachine  --  win键盘 映射 cmd键 -- input里的grab要勾选(client)
	- [[iterm2]]
-
- [[linux-tools]]
	- [[tmux]]
	- [[gnome]]
	- [[rm删除恢复]]
	- [[markdown]]
	-
- [[git]]
	- git lfs 大文件可用  git lfs install; git lfs track xxx/*  ；  git lfs clone可下lfs
	- git lfs导致push失败，即本地么有，远程也无，重新fetch也不行，应该是误删除或者合并丢失。 最后是全部git reset提交，把对应的文件改动去掉，然后push是ok的了。   其实就是找不到了，基本无解，要么本地有要么服务器上有。
	- git lfs很多图片都变成100多Byte了，损坏，怎么fix？
		- `git lfs install    git lfs pull` 恢复
	-
- [[logseq]]
- [[vscode]]
- [[vim]]
- [[blog-all]]
-
-
- [[CR]] <a class=apple href=https://mp.weixin.qq.com/s/7HYl2XjONrEVBvZbcIPSCA>阅读源码工具</a>
  id:: 624ab0c0-fb1f-44de-8a14-d072bb80d0b5
	- 补充：浏览器插件，sourcegraph  gitzip  octree
	- <a href=https://sourcegraph.com/search class="perfect">sourcegraph直接在线看</a>
	- [代码gen pic](https://carbon.now.sh)
	- ((655437e4-54f2-4132-9226-8ca2396e53bb))
-
- [画图工具](https://mp.weixin.qq.com/s/X2YAGDYe5I0PFL1z9k-iCw)
	- excalidraw  手绘风格比较好用
	- graphviz 来绘制复杂的关系图，timeline图。
	  它系出名门，出自大名鼎鼎的的AT&T实验室，类似微软出的「Visio」，但两者有个本质的差别， 描述好自动生成
	-
	- 而[plantuml](https://plantuml.com/) 就是这样一个绘图组件，支持绘制各种程序开发需要用到的图。免不了撰写各种设计方案，绘制各种序列图，类图，活动图，状态机图等等各种UML图。plantuml 依赖的底层组件就有前文提到的graphviz，所以plantuml的语法也类似graphviz, 通过自定义的标记语言，来描述不同图形之间的关系，「自动布局」并绘制。
	- 微信支付线的[Xwatt团队](https://LWlrLXdhLWNtLQo=/pages/viewpage.action?pageId=386634071)推出了Xwatt 画图工具  替代了plantuml 更好，好像
	- matplotlib 主要是用来绘制各种图表，比如折线图，饼图，直方图等 ![image.png](../assets/image_1677060022980_0.png){:height 154, :width 193}
	- ![image.png](../assets/image_1677060071639_0.png){:height 278, :width 566}
- [[others]]
	- pdf合并切割工具::  online https://tools.pdf24.org 非常niubility
	- [ Unsplash - 极具美感的无版权图库 - 知乎专栏](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjX58OHraj9AhUYgFYBHchTCZgQFnoECBsQAQ&url=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F144627176&usg=AOvVaw008tKri9hwPtTO0Lf8hjXc) ----> [unsplash](https://unsplash.com/t/nature)
	- [[$red]]==infinity tab==主页收集 [infinityBackup-2023-2-22.infinity](../assets/infinityBackup-2023-2-22_1677048667286_0.infinity)
- [[chat-GPT-bing]]
  id:: 65d810f8-81d1-430b-b390-035ee94a6b29
	- 注册需要[sms](https://sms-activate.org/cn/freePrice#activation)，俄罗斯的一个可以买手机号，收验证码
	- bing直接注册，开通即可，bing画图也可以；Sorry, looks like your network settings are preventing access to this feature” modheader可以改 X-Forwarded-For   127.x.0.1
- clion不能跳转到implement::  右键项目文件夹，点击Mark Directory as->Projects Sources and Headers
