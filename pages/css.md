- <ol> 
  <li> <a class="apple underline"> example1 </a></li>
  </ol>
-
- 了解基本 [[html]]   <a href="https://developer.mozilla.org/zh-CN/docs/Learn/Getting_started_with_the_web/CSS_basics"> mdn css基础</a>
- CSS -- need
	- 层叠样式表（Cascading Style Sheet)  --  页面样式  布局
	- > css规则，选择器 属性  值；
	   css是怎么生效的，继承方式，应该怎么布局，怎么选择元素、class、id等的
	  **盒模型**：margin pading border问题，display:inline flex block区别，一个box contain怎么控制大小边框边距内容区大小，怎么让其均匀分布，怎么改还能挤开其他元素
	-
	-
- html加入css外面的<link href="styles/style.css" rel="stylesheet">
  :LOGBOOK:
  CLOCK: [2022-03-07 Mon 23:52:44]--[2022-03-07 Mon 23:54:38] =>  00:01:54
  CLOCK: [2022-03-07 Mon 23:54:41]
  :END:
- CSS规则集
	- ![image.png](../assets/image_1646281848267_0.png){:height 148, :width 426}
		- 声明：用来指定添加样式元素的属性
		- 每个规则集（除了选择器的部分）都应该包含在成对的大括号里（{}）：和；
		- 属性速记：简写，background: red url(bg-graphic.png) 10px 10px repeat-x fixed;   ---》 background-color: red;  background-image:   ..position    ..-repeat:    ..-attachment:
		-
- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Selectors> <span style="color:red"><strong>选择器</span>元素-p.  class=x  id=x </a>
	- ![image.png](../assets/image_1646282217873_0.png){:height 361, :width 588}
	- body h1 + p .special   --> 在<body>之内，紧接在<h1>后面的<p>元素的内部，类名为 special。h1+p 就是相邻在h1后的第一个p一个层级
	- a:hover a:visited  根据状态改，比如鼠标放上去了hover
	- DONE [mdn-css-selector](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Selectors)
		- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Selectors> 选择器参考表</a>
		  :LOGBOOK:
		  CLOCK: [2022-03-09 Wed 16:22:59]
		  :END:
	- 多个选择器可构成选择器列表，分割； 类 元素和id选择器，class是.class_name, id是#id
	  :LOGBOOK:
	  CLOCK: [2022-03-09 Wed 16:23:20]
	  CLOCK: [2022-03-09 Wed 16:23:21]
	  CLOCK: [2022-03-09 Wed 16:23:22]
	  CLOCK: [2022-03-09 Wed 16:23:23]
	  CLOCK: [2022-03-09 Wed 16:24:21]
	  :END:
	- class多个  <span class="ca cb cd"> ....可定义多个spa.ca, spa.cb或者span.ca.cb {
	  :LOGBOOK:
	  CLOCK: [2022-03-09 Wed 16:24:35]
	  CLOCK: [2022-03-09 Wed 16:24:36]
	  CLOCK: [2022-03-09 Wed 16:24:38]
	  :END:
	- 标签属性选择器：a[href="https://example.com"] { } 如果href是这个就会被选中
	  :LOGBOOK:
	  CLOCK: [2022-03-09 Wed 16:25:21]
	  CLOCK: [2022-03-09 Wed 16:25:22]
	  CLOCK: [2022-03-09 Wed 16:25:24]
	  :END:
		- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Selectors/Attribute_selectors>属性选择器</a>
			- li[class]    li[class="a"]  Li[class~="a"]
			  :LOGBOOK:
			  CLOCK: [2022-03-09 Wed 16:25:43]
			  :END:
			- li[class$="a"]匹配了任何值结尾为a的属性，于是匹配了第一和第三项。 ^开头 *包含
			  :LOGBOOK:
			  CLOCK: [2022-03-09 Wed 16:26:48]
			  CLOCK: [2022-03-09 Wed 16:26:49]
			  :END:
	- 伪类选择器： a:hover {}  伪元素选择器：p::first-line {}    article p:first-child {
	  :LOGBOOK:
	  CLOCK: [2022-03-09 Wed 16:27:01]
	  :END:
		- 用户行为伪类：状态伪类：a:hover
		  :LOGBOOK:
		  CLOCK: [2022-03-09 Wed 16:28:03]
		  :END:
		- 伪元素：双冒号 ::
		- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Selectors/Pseudo-classes_and_pseudo-elements class=apple> 伪类伪元素选择器参考</a>
		  :LOGBOOK:
		  CLOCK: [2022-03-09 Wed 16:28:40]
		  CLOCK: [2022-03-09 Wed 16:28:41]
		  :END:
		- 比如P::first-line会把第一行生效，且每一行长度可变，如果用span必须是提前固定的，做不到
		  :LOGBOOK:
		  CLOCK: [2022-03-09 Wed 16:28:55]
		  CLOCK: [2022-03-09 Wed 16:28:56]
		  :END:
		- article p:first-child::first-line  伪元素 伪类 第一段第一行
		- 关系选择器:
		  :LOGBOOK:
		  CLOCK: [2022-03-09 Wed 16:29:33]
		  CLOCK: [2022-03-09 Wed 16:29:34]
		  CLOCK: [2022-03-09 Wed 16:29:37]
		  CLOCK: [2022-03-09 Wed 16:29:38]
		  :END:
			- .box p 后代box类里的p；  article > p子代关系选择器，+ 临接-只有紧接的一个有效；   ~ 通用，这个是所有的 h1 ~ p那h1后的p都有
			  :LOGBOOK:
			  CLOCK: [2022-03-09 Wed 16:29:47]
			  CLOCK: [2022-03-09 Wed 16:29:48]
			  :END:
			-
- DONE [#k] - <a class="weight red coffee" href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/The_box_model> 盒模型</a>
  id:: 6228657c-aede-49f7-9939-a21f9f56e68e
  :LOGBOOK:
  CLOCK: [2022-03-09 Wed 16:34:49]--[2022-03-12 Sat 00:29:24] =>  55:54:35
  :END:
	- 一切皆盒子
		- ![image.png](../assets/image_1647013709616_0.png){:height 112, :width 500}
		- ![image.png](../assets/image_1647013721401_0.png){:height 201, :width 349}
			- <style>
			  .box2 {
			    border: 10px solid rebeccapurple;
			    background-color: gray;
			    padding: 30px;
			    margin: 10px;
			    width: 60px;
			    height: 10px;
			    display: inline-flex;
			  }</style>
			  <div class="box2">b2</div>  **boder就是边框的那个线条宽度；边框**
			-
	- **块级盒子**：==通过对盒子display 属性的设置，比如 inline 或者 block==
	  id:: 622866af-ebcb-4a05-b4b3-537031c0092c
		- 盒子会在内联的方向上扩展并占据父容器在该方向上的所有可用空间，在绝大数情况下意味着盒子会和父容器一样宽
		    每个盒子都会换行
		    width 和 height 属性可以发挥作用
		    内边距（padding）, 外边距（margin） 和 边框（border） 会将其他元素从当前盒子周围“推开”
		- 除非特殊指定，诸如标题(<h1>等)和段落(<p>)默认情况下都是块级的盒子。
	- **内链盒子**：
		- 盒子不会产生换行。
		     width 和 height 属性将不起作用。; 比如
			- > <span>，并对其应用了宽度、高度、边距、边框和内边距。可以看到，宽度和高度被忽略了
		- 外边距、内边距和边框是生效的
		    垂直方向的内边距、外边距以及边框会被应用但是不会把其他处于 inline 状态的盒子推开。
		    水平方向的内边距、外边距以及边框会被应用且会把其他处于 inline 状态的盒子推开。
		- 用做链接的 <a> 元素、 <span>、 <em> 以及 <strong> 都是默认处于 inline 状态的。
	- 块布局：inline flex 容器和段落在一行上而不是像块级元素一样换行
	- ==display 属性可以改变盒子的外部显示类型是块级还是内联，这将会改变它与布局中的其他元素的显示方式==
	- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/The_box_model#%E4%BD%BF%E7%94%A8display_inline-block> display: inline-block:中间状态</a>
		- 置width 和height 属性会生效。      padding, margin, 以及border 会**推开其他**元素。
		- <style>
		  .p {
		  width: 500px;
		    height: 150px;
		  }
		  .ib {
		    margin: 10px;
		    padding: 5px;
		    width: 80px;
		    height: 50px;
		    background-color: lightblue;
		    border: 2px solid blue;
		    display: inline-block;} 
		  </style>
		  <p class="p">
		     <span class="ib">span</span> I am a paragraph and this is a test inside that paragraph. A span is an inline element and so does not respect width and height.
		  </p>
		- {{embed ((9374c530-4426-441e-8048-2362e98c3b7b))}}
- 字体和文本
	- 可以下载某个字体，然后使用<link href="https://fonts.font.im/css?family=Open+Sans" rel="stylesheet" type="text/css"> 引用这个会自动下载对应字体
- DONE  - <a href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Backgrounds_and_borders>背景与边框</a>
  :LOGBOOK:
  CLOCK: [2022-03-12 Sat 00:29:07]--[2023-06-25 Sun 14:25:08] =>  11293:56:01
  :END:
	- background-color: #567895;
	- background-image: url(balloons.jpg);   图片做背景
	- background-image: url(star.png);
	    background-repeat: repeat-x;  控制背景平铺的，x方向平铺，不如一串
	    background-size: 100px 10em;  postition top center;  
	    gradient 颜色渐变
- ---
	-
- <a style="color: blue;background-color: yellow"  href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/First_steps/How_CSS_is_structured> 构建css </a>
	- 外部样式：单独写一个css文件
	- 内联样式： 放在head内，或者直接在<h1 style="color: blue;background-color:
	- [构建基础](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Cascade_and_inheritance) 层叠与继承
	- cascade就是顺序的，优先级：class比元素优先级高,  !important 改变了层叠的常规工作方式，它会使调试 CSS 问题非常困难
	- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/Building_blocks/Cascade_and_inheritance#%E6%8E%A7%E5%88%B6%E7%BB%A7%E6%89%BF>控制与继承</a>
		- 常识判定，也可指定inherit  unset 等, 甚至去除所有属性，保持浏览器的特性
		-
	-
- <a style="color: blue;background-color: gray"  href=https://developer.mozilla.org/zh-CN/docs/Learn/CSS/First_steps/How_CSS_works> css如何运行 </a>
	- ![image.png](../assets/image_1646403617599_0.png){:height 113, :width 292}
-
-
-
- <!DOCTYPE html>
    <html>
    <head>
    <style type="text/css" rel="stylesheet">
  p {
   color: red;
   width: 1000px;
   border: 1px solid black;
    }
  
    * {
    margin:0px;
    }
  
    h1,h2 {
   margin: 0;
   padding: 10px 0;
   color: #00539F;
   text-shadow: 3px 3px 1px black;
    }
  
    html {
   background-color: #00539F;
    }
  
    ul {margin:0;}
    body {
   width: 1300px;
   margin: 0 auto;
   background-color: #FF9500;
   padding: 10px 20px 20px 20px;
   border: 3px solid black;
    }
  
    p {
    margin:1px;
    }
    </style>
  
   <meta charset="utf-8">
    </head>
    <body>
    <hr/>
  <p>这里的style会改变当前页面背景，布局等</p>
  <ul>
     <li>思考者</li>
   </ul>
    <p>我们致力于让信：开放平台的协作对于人的发展至关重要，也决定着我们共同的未来。</p>
    <p>为了达成我们共同的理想，我们遵循一系列的价值观和理念，请参阅 <a href="https://www.mozilla.org/zh-CN/about/manifesto/">Mozilla 宣言</a>。</p>
  <span style='font-size:0.8em;'> 1em大小测试</span>
  </body>
    </html>
-