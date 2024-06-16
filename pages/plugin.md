banner:: false
icon:: <img src="https://raw.githubusercontent.com/logseq/logseq/master/resources/icons/logseq.png" alt="logseq" style="max-height:1em;width:auto;height:auto;display:inline-block" />

- YnRkCg==-mac机器plugin [[#red]]==包含所有plugin和settings，可直接导入到.logseq下 [plugin_YnRkCg==_mac_2024-01-25.tgz](../assets/plugin_YnRkCg==_mac_2024-01-25_1706152407381_0.tgz)
- date-formatter:可配置格式，安装主题、plugin必须开启developer模式，清空cache，不要改中英文；
	- 手动安装， 下载后放在~/.logseq/plugin/xxx ， 这个xxx必须和看到的插件id名字一致
-
- ```shell
  已安装：~/.logseq/plugins#  theme是主题、dev和bonofix                                                               
  journals-calendar-0.10.1  logseq-bullet-threading   logseq-heatmap            logseq-markdown-table     logseq-random-note        logseq-wrap
  logseq-dev-theme          logseq-kanban-plugin      logseq-pdf-export-plugin  logseq-tabs
  logseq-bonofix-theme      logseq-doc                logseq-mark-map           logseq-plugin-gpt3-openai vim-shortcuts
  logseq-plugin-tocgen  可以设置打开任何any，{{renderer :tocgen2, *, calc(100vh - 131px)}} 目录里写这个自动生成页面的
  logseq-awesome-styler 可以调整页面背景、左右中宽度size例，可以调整各种颜色 字体大小，操作页面大小
  logseq-agend ---这个可以生成一些统计信息
  banners:  --- 可以配置天气，天气widget可指定id，比如关闭可，页面上 banner:: false  --- 用处不大，占用页面，可只开journal - shanchu
  
  logseq-agenda/
  logseq-awesome-links/        awesome-content 会改todo/canban等   logseq-awesome-styler/
  logseq-bonofix-theme/        logseq-bullet-threading/           logseq-calendars-plugin/     logseq-dev-theme/
  logseq-doc/                  logseq-heatmap/                    logseq-journals-calendar/    logseq-kanban-plugin/
  logseq-link-preview/         logseq-mark-map/                   logseq-markdown-table/       logseq-pdf-export-plugin/
  logseq-plugin-gpt3-openai/   logseq-random-note/                logseq-tabs/                 logseq-tags/
  logseq-tocgen/               logseq-todo-master/                logseq-todo-plugin/          logseq-vim-shortcuts/ 
  logseq-wrap/                 随机设置children背景color            logseq-wrap/                 luckysheet 插入表格还不错
  ```
- DONE ![image.png](../assets/image_1646388386115_0.png){:height 30, :width 464} cmd 双击会锁定🔐 tabs plugin
- new-plugin:: Doc View Exporter 导出插件-导出为文本方式，缩进没了
- agenda:: 插件比较强，需要了解使用方法
- logseq-awesome-links: 可以设置页面或者块的图标，比如页面properties里加: color要加shift enter换行:  icon:: 🔥 
  color:: "red" color里可以配置各种颜色css的即可
- 最关键的:: [[$red]]==logseq-awesome-styler==这个插件, 设置主题，背景色等
- styler插件:: 使用pic汇总
	- > 这个插件有点问题，在多个style中切换后，颜色有点稍微变化，有问题可以多切换几次试试
		- ![image.png](../assets/image_1679035120194_0.png){:height 120, :width 307}
		- [[#blue]]==这个颜色是，left sidebar accent:的颜色 #BD93F9==  awesome-styler的配置决定的
		- ![整个样式模式-image.png](../assets/image_1706152433523_0.png){:height 254, :width 486}
			- 这个左边的下面颜色是： left sidebar bg:   EDE4D4
			- 中间那个输入页的背景颜色是content bg： FEF8EC
			- 内容中的： 提示prop:: xxxx，这样写法的bg是：props bg： F1EBDF
			- reference bg： 这个改了导航右边很多也会变 F0E9DB
			- logseq层级的布局颜色记录:  升级等操作后、设置，常规，accent color记得去掉选择，否则可能会被覆盖配置
				- ![image.png](../assets/image_1712128765642_0.png){:height 218, :width 422}
	- 图片
		- [❄️🌲](https://images.unsplash.com/photo-1675091348285-f594d17d8cd0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3948&q=80)
		  collapsed:: true
		- [金黄色树 🌴](https://images.unsplash.com/photo-1523712999610-f77fbcfc3843?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80)
- {{renderer :kanban_oihbkuv}}
	- kanban
		- plugn2 <a class="ask"></a>
			- b
		- plugn3
			- c
- #### [[$red]]==agenda使用--强大==
	- [doc](https://haydenull.github.io/logseq-plugin-agenda/zh/introduction/events.html#example)
	- tomato钟： agenda:  start pomodoro timer >[🍅 2min](#agenda-pomo://?t=p-1686569571338-91)
	- DONE 转换为task，即todo 才可以进入插入修改时间event中 、 >[2023-09-05 19:45 - 20:15](#agenda://?start=1693914306000&end=1693916106000&allDay=false)
- #### todomaster:
	- `{{renderer :todomaster}}`  {{renderer :todomaster}}
- #### TextWrap
	- [svg图共享-perfect](https://tablericons.com/)[[svg]]
	  background-color:: green
		- [svg path显示](https://svg-path-visualizer.netlify.app/#M2%2C2%20L8%2C8)    [online svg图选择](https://www.svgviewer.dev/s/367879/size)
	- svg图选择，直接选中[svg图](https://www.svgviewer.dev/s/162950/font) 里的svg后贴入配置即可，不要修改
	- 修改logseq的custom.yaml配置，按照textwrap的  [自定义样式改](https://github.com/sethyuan/logseq-plugin-wrap#自定义工具栏样式)
- #### awesome-content会改todo、canban等 [[$sub8-red]]==2023-11-30 Thu==
	- 该插件card修改、task status修改关闭
	- #quote
		- 1
			- 3
	- 测试.kanban功能，比较实用！ #.kanban
		- 先#。kanban后下一行tab
			- 先输入好这个blob的所有子blob内容？
			-
		- tab2
			- tab2的子block
-