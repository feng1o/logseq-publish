- [example-网站1](https://roy-tian.github.io/learning-area/html/introduction-to-html/structuring-a-page-of-content-finished/) [html_example.tgz](../assets/front_end/page1/page1.tgz) 
  [page1](../assets/front_end/page1/page1.html)
  ![image.png](../assets/image_1646322907527_0.png){:height 131, :width 233}
-
- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/Getting_started_with_the_web/HTML_basics> mdn html基础</a>
	- html元素详解
		- ![image.png](../assets/image_1646279601046_0.png){:height 91, :width 190}
		- 嵌套元素： < _p>我的猫咪脾气<strong>暴躁</strong>:)</p>
			- 块级元素  内联元素
			- 空元素： <img src="images/firefox-icon.png" alt="测试图片">  内容空的
		- 属性：<p class= "edit-note"> ...class属性给元素赋了一个识别的名字（id），这个名字此后可以被用来识别此元素的样式信息和其他信息
		-
	- html文档详解
		- ```
		  <!DOCTYPE html>            — 文档类型
		  <html>   <html></html>     — <html>  元素。该元素包含整个页面的内容，也称作根元素。
		    
		    <head>                   - <head>  元素。不可见，如面向搜索引擎的搜索关键字（keywords）、
		                                       页面描述、CSS 样式表和字符编码声明等
		      <meta charset="utf-8">
		      <title>测试页面</title>      - title元素 标题
		    </head>
		    
		    <body>                        - body元素  页面内容
		      <img src="images/firefox-icon.png" alt="测试图片">
		    </body>
		  </html>
		  ```
		- alt="测试图片" 是图片不可显示的时候提示信息
	- 标记文本
		- 标题<h1-->
		- 段落<p-->
		- list列表 ul  or有序无需
			- ```
			  <ol>
			    <li>l2</li>
			    <li>l3</li>
			    <li>l1</li>
			  </ol> 
			  <p>我们致力于……</p>
			  ```
	- 链接
		- 描  anchor <a> .... <a>miao 无href属性，无法跳转</a>
		- <a href=""  title="鼠标放上去提示”   target="_blank-新页打开"> ......title:=鼠标放上去提示”   target="_blank-新页打开" </a>
		- meta元数据
			- 可以给页面加一些描述性数据：比如搜索引擎  description 作者信息
		- 自定义图标 <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
		- link元素
			- <link> 元素经常位于文档的头部。这个link元素有2个属性，rel="stylesheet"表明这是文档的样式表，而 href包含了样式表文件的路径
			-
			- - 仅仅影响表象而且**没有语义**，被称为表象元素（presentational elements）并且不应该再被使用 b i u
			  - <a href='https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Introduction_to_HTML/Creating_hyperlinks' title="超链接">超链接 a标签  </a>
			  - 文档片段： 就是超链接到文档指定部分(文档片段)，必须给对应位置元素分一个id属性
			  - <p>本页面底部可以找到 < a href="#pd1">跳转文档片段pd1</a>。</p>
			  - download="firefox-latest-64bit-installer.exe"
			  -
			  - 描述列表 dl  dt dl
			  - 引用：<cite>孔子</cite>  <q> xxxxxqxxxx</q>
			  - ==abbr==>——它常被用来包裹一个缩略语或缩写，并且提供缩写的解释（包含在title属性中）
			  - <p>第 33 届 <abbr title="夏季奥林匹克运动会">奥运会</abbr> 将于 2024 年 8 月在法国巴黎举行。</p>
			  - address 地址联系方式
			  - sub sup上下标  -- css vertical-align: sub super
			  - 日期和时间 time
			  - <!-- 标准简单日期 -->
			  <time datetime="2016-01-20">20 January 2016</time>
			  <!-- 只包含年份和月份-->
			  <time datetime="2016-01">January 2016</time>
			  <!-- 只包含月份和日期 -->
			  <time datetime="01-20">20 January</time>
			  <!-- 只包含时间，小时和分钟数 -->
			  <time datetime="19:30">19:30</time>
			  <!-- 还可包含秒和毫秒 -->
			  <time datetime="19:30:01.856">19:30:01.856</time>
			  <!-- 日期和时间 -->
			  <time datetime="2016-01-20T19:30">7.30pm, 20 January 2016</time>
			  <!-- 含有时区偏移值的日期时间 -->
			  <time datetime="2016-01-20T19:30+01:00">7.30pm, 20 January 2016 is 8.30pm in France</time>
			  <!-- 调用特定的周 -->
			  <time datetime="2016-W04">The fourth week of 2016</time>
			  -
			  - <a href=https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Introduction_to_HTML/Document_and_website_structure  title=mdn构建网站架构html >  用语义标签构建文档-搭建网站架构</a>
			  - 文档基本组成：[page1](../assets/front_end/page1/page1.html)
			  - 页眉header   导航栏nav   主内容main   侧边栏aside <sub><span style="color:red">一般嵌套在main中</span></sub>  页脚footer
			  - ![image.png](../assets/image_1646301843898_0.png){:height 433, :width 651}
			  -
			  - 无语义元素
			  - 应配合使用 class 属性提供一些标签，使这些元素能易于查询
			  - u b  i
			  - span
			  - div
			  - ---
			  - <a href=https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Multimedia_and_embedding alter=”多媒体与嵌入" target="_blank"> <strong> <span style="color:red">多媒体与嵌入</span></strong></a>
			  - <img>
			  ```css
			  <img src="images/dinosaur.jpg"
			       alt="一只恐龙头部和躯干的骨架，它有一个巨大的头，长着锋利的牙齿。"
			       width="400"
			       height="341"
			       title="A T-Rex on display in the Manchester University Museum">
			  ```
			  - figure： img加描述： 比如可以加div放个p；
			  - ```css
			   <figure>
			     <img src="https://raw.githubusercontent.com/mdn/learning-area/master/html/multimedia-and-embedding/images-in-html/dinosaur_small.jpg"
			        alt="一只恐龙头部和躯干的骨架，它有一个巨大的头，长着锋利的牙齿。"
			        width="400"
			        height="341">
			     <figcaption>曼彻斯特大学博物馆展出的一只霸王龙的化石</figcaption>
			   </figure>
			   ```
			  - css加图片：background-image : url("xxx)  这个没有语义，只能装饰；不能有任何备选文本，也不能被屏幕阅读器识别。这就是 HTML 图片有用的地方了
			  - **总而言之，如果图像对您的内容里有意义，则应使用HTML图像。 如果图像纯粹是装饰，则应使用CSS背景图片**
			  - video/audio
			  - ```css
			  <video src="rabbit320.webm" controls>
			    <p>你的浏览器不支持 HTML5 视频。可点击<a href="rabbit320.mp4">此链接</a>观看</p>
			    <source src="rabbit320.mp4" type="video/mp4">
			    <source src="rabbit320.webm" type="video/webm"> 可能不同浏览器支持不同，src到此处自动适配匹配的
			  
			        <track kind="subtitles" src="subtitles_en.vtt" srclang="en">  字幕的视频
			  </video>
			  ```
			  - iframe: 嵌入其他网页
			  - ```html
			  <iframe src="https://developer.mozilla.org/en-US/docs/Glossary"
			          width="100%" height="500" frameborder="0"
			          allowfullscreen sandbox>
			    <p> <a href="https://developer.mozilla.org/en-US/docs/Glossary">
			      Fallback link for browsers that don't support iframes
			    </a> </p>
			  </iframe>
			  ```
			  - embed嵌入flash
			  - object嵌入pdf
			  - ```html
			  <object data="mypdf.pdf" type="application/pdf"
			          width="800" height="1200" typemustmatch>
			    <p>You don't have a PDF plugin, but you can <a href="myfile.pdf">download the PDF file.</a></p>
			  </object>
			  ```
			  - svg矢量图：和位图相比，存储的是算法规则；放大不会虚化
			  - ```HTML
			  <svg width="300" height="200">
			      <rect width="100%" height="100%" fill="green" />
			  </svg>
			  也可用iframe加入svg图； 还一个用img
			  
			  ```
			  - 响应式/自适应图片：
			  - ```css
			  <img srcset="elva-fairy-320w.jpg 320w,
			               elva-fairy-480w.jpg 480w,
			               elva-fairy-800w.jpg 800w"
			       sizes="(max-width: 320px) 280px,
			              (max-width: 480px) 440px,
			              800px"
			       src="elva-fairy-800w.jpg" alt="Elva dressed as a fairy"> 
			  <picture>
			    <source media="(max-width: 799px)" srcset="elva-480w-close-portrait.jpg">
			    <source media="(min-width: 800px)" srcset="elva-800w.jpg">
			    <img src="elva-800w.jpg" alt="Chris standing up holding his daughter Elva">  //根据页面选择最适合的
			  </picture>
			  
			  ```
- <a href=https://developer.mozilla.org/zh-CN/docs/Learn/HTML/Tables/Basics  target="_blank"  alter="表格" > 表格 </a>
	- > 使用表格布局而不使用 CSS layout techniques 是很糟糕的
	- 定义整列数据的样式信息：就是 <col> 和 <colgroup> 元素
	- thead tbody  tfoot
	- <-caption>行⭐️数据表all</caption> <a href=https://roy-tian.github.io/learning-area/html/tables/assessment-finished/planets-data.html>link<iframe src=https://roy-tian.github.io/learning-area/html/tables/assessment-finished/planets-data.html></iframe></a>
-
-
- [[css]] 开---> [css-link](https://developer.mozilla.org/zh-CN/docs/Learn/CSS/First_steps)