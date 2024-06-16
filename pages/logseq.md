icon:: 🐾

- logseq技术
	- [CRDT和OT算法](https://www.cnblogs.com/WindrunnerMax/p/17114099.html)
	- 熟悉 Clojure(Script) 或熟悉其它函数式编程 、熟悉图数据库
	-
- [[logseq配置]]
	- <a class="alg-2stars bd-blue" href=https://zhuanlan.zhihu.com/p/548640615>参考配置</a> [bullet火箭头操作参考](https://discuss.logseq.com/t/css-highlights-current-path-bullets-color/371/3) 字体-代码块字体-颜色-icon-pdf背景...
	- custom.css配置注意，alg开头的css控制width，尽量不要改
		- [[#red]]==怎么通过css修改样式？== [example](https://zhuanlan.zhihu.com/p/548640615)
		  collapsed:: true
			- - **Alt** → **View **→ **Toggle Developer Tools **  --》 打开开发者debug
			- 可看到elements 、styles页面（这里就是css）
			- element 选择按钮，选中某部分内容可跳转到对应的位置，看style内容，直接copy后修改即可
			- ![image.png](../assets/image_1687016619057_0.png)
			- ```
			   .ls-hl-colored .block-content[data-hl-color=yellow] .prefix-link:before{
			  	content: "-yellow- ";
			  }
			  
			  // copy源代码丢到配置里无效  是sass less语法，是css的超级，customer.css应该是不支持的！！！需转换css后ok
			  .ls-hl-colored .block-content {
			    &[data-hl-color=blue] {
			      .prefix-link {
			        &:before {
			          content: "🔵 ";
			          @apply tie tie-pdf-highlight pr-1;
			          color: var(--color-blue-500);
			        }
			      }
			    }
			  
			    &[data-hl-color=yellow] {
			      .prefix-link {
			        &:before {
			          /*@apply tie tie-pdf-highlight pr-1;*/
			          content: "🟡--yellow- ";  /*未生效*/
			        }
			      }
			    }
			  }
			  ```
			-
		- 修改search高亮
			- ```
			  .ui__list-item-highlighted-span {
			      background-color:yellow;
			  }
			  ```
	- logseq.edn里default-queries:  journal query now  later  overtime....
	- logseq.edn新增配置解决code代码换行后选择换行默认到第一行问题
		- ```bash
		  :editor/extra-codemirror-options 
		    { :lineWrapping true }
		  ```
- [[plugin]]
	- 页面字体大小是在 logseq-styler插件设置里调整的，这个可以调整页面宽度，字体大小颜色等，比较 <span class=" bg-green white  subw hblack hover"> [[2023-03-04 Sat]] </span>
	- agenda的modify scheduler异常 ？
- ##### other
	- DONE  页面第一行的 title:: xxxx 和template一样的标签怎么来的？
	- DONE Done  -- cmd + enter 直接切换
	- td:模式切换 Sound like you're in document mode. Click on the space at the side of the page then type t d this will change to bullet mode.
	- DONE 两个：可输入注释，不能包含,会导致编程链接点击跳转空页面
		- common:: 无逗号的; 无英文 `common:: xxxx`
		- common::  有逗号，dagdag
	- DONE 可配置ide的css：Documents/logseq_dir/logseq/custom.css  比如配置背景、h1标签等信息 [[logseq配置]]   使用styler插件管理
	- DONE query: 命令分解，可以配置到config.edn里来完成一些自动汇总  doc即可
	- DONE journal页面的now没有page信息，但是点每行的圆点是可以跳过去的，去掉sort配置是可以显示page的
	- 在线pdf `![pdf名字](地址)`
- ##### alias:
	- 每个page的第一个block加个： alias::xxx就可以通过xxx跳转过去了 [[template]] -- [[tpl]]
- query:
	- [dynamic variables比如today,yesterday,current page,laster Friday...可在sql里替换](https://logseq.github.io/#/page/Dynamic%20Variables)
	- sort-by里的get h :db/id 为何不能desc？
	- :breadcrumb-show? false 可以做到类似table的效果
	- query也可以和高级query混用，注意排序看block的 show block data可看到有哪些atrribute
	- ![image.png](../assets/image_1647876833125_0.png){:height 364, :width 489}
- Feat:
	- ![image.png](../assets/image_1676963550028_0.png){:height 79, :width 344}
		- ```
		  main, header, nav, article, aside, footer, section {
		       background-color: rgba(29, 149, 63, 0.5);
		       /*padding: 1%; 这个1 会导致顶部覆盖一部分,长了一点点*/
		        padding: 1%;                                                                                                                                                                           
		   }
		  ```
	- 主题1 [[logseq_falvor1/css]]
	  collapsed:: true
		- ```
		  <!DOCTYPE html>
		  <html>
		  <head>
		  
		  <style type="text/css" rel="stylesheet">
		   p {
		    color: red;
		    width: 500px;
		    border: 1px solid black;
		  }
		  
		  h1,h2 {
		    margin: 0;
		    padding: 20px 0;
		    color: #00539F;
		    text-shadow: 3px 3px 1px black;
		  }
		  
		  html {
		    background-color: #00539F;
		  }
		  
		  body {
		    width: 1300px;
		    margin: 0 auto;
		    background-color: #FF9500;
		    padding: 10px 20px 20px 20px;
		    border: 3px solid black;
		  }
		  </style>
		  
		   <link href="https://fonts.googleapis.com/css?family=Noto+Sans+SC" rel="stylesheet">
		    <link href="styles/style.css" rel="stylesheet">
		    <meta charset="utf-8">
		  </head>
		  
		  <body> </body>
		  </html>
		  ```
	-
- [[query_example]]
- 测试scheduled and deadline
	- DONE 会在每日daily node中加入这个[[计划]]，scheduled最近3天  ； 加上Todo后再doing切换会触发LOGBOOK 
	  SCHEDULED: <2023-11-15 Wed 15:25 .+1d>
	  DEADLINE: <2023-11-16 Thu>
	  :LOGBOOK:
	  * State "DONE" from "TODO" [2023-11-14 Tue 15:28]
	  CLOCK: [2023-11-14 Tue 15:28:15]--[2023-11-14 Tue 15:28:18] =>  00:00:03
	  CLOCK: [2023-11-14 Tue 15:28:21]--[2023-11-14 Tue 15:28:22] =>  00:00:01
	  CLOCK: [2023-11-14 Tue 15:28:22]--[2023-11-14 Tue 15:28:23] =>  00:00:01
	  * State "DONE" from "TODO" [2023-11-14 Tue 15:29]
	  CLOCK: [2023-11-14 Tue 15:29:31]--[2023-11-14 Tue 15:29:38] =>  00:00:07
	  * State "DONE" from "DOING" [2023-11-14 Tue 15:29]
	  :END:
- [[logseq-blog]]
	- 例子:  [logseq-pro](https://logseq.pro/#/page/logseq%20pro%E2%80%99s%20best%20practice)
	- [利用github大家logseq的bolog](https://garden.1900.live/?ref=1900.live#/page/%E5%88%A9%E7%94%A8github%20workflows%E5%8F%91%E5%B8%83logseq%E5%88%9B%E5%BB%BA%E6%95%B0%E5%AD%97%E8%8A%B1%E5%9B%AD)
	- [配置首页和侧边栏](https://logseq.abosen.top/#/page/logseq%20%E5%8F%91%E5%B8%83%E4%B8%BA%E5%85%AC%E5%BC%80%E9%A1%B5%E9%9D%A2%E6%97%B6%EF%BC%8C%E9%85%8D%E7%BD%AE%E9%A6%96%E9%A1%B5%E5%92%8C%E4%BE%A7%E8%BE%B9%E6%A0%8F)
		- [logseq接入评论](https://github.com/qbosen/qbosen.github.io/discussions/5) giscus
		-