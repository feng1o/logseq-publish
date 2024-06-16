- vercel
	- 作为镜像直接导入
	- 配置域名 [[#red]]==nameservice==为:: ns1/2.vercel-dns.com  加了这两个，如果默认的去掉买的域名会报错，应该是受限等，
	- 此时也不需要在canme到github..io了，简单理解应该是直接用了vercel的解析，只要在vercel上配置了域名就可以找到
	- 只配置了一个: A 指定vercel的127.x.0.1    和www都指向vercel这个地址， 没有ssl问题了，混合github的地址会有ssl问题(待验证)
	- ![image.png](../assets/image_1677839684730_0.png){:height 96, :width 543}
	- 把其他的都去掉，nameserver 加2个到4个，加上了vercel的两个服务
	-
- wechat [微信markdown编辑器](https://doocs.github.io/md/)
	- ```markdown
	  # MTU、及TCP流量控制机制
	  > 测试下发布工具
	  ## MTU
	  ![](https://fastly.jsdelivr.net/gh/filess/img3@main/2023/04/04/1680576883905-c86d03b7-e73d-4284-9a03-d7fb8aea127f.png)
	  ![](https://cdn-doocs.oss-cn-shenzhen.aliyuncs.com/gh/doocs/md/images/1648303019705-c161ce00-d245-446a-b81c-42ec91474a40.gif)
	  ## TCP流量控制
	  ![](https://fastly.jsdelivr.net/gh/filess/img7@main/2023/04/04/1680576943682-4d8dd3a3-cf43-4ae5-8f86-49402fb280ea.png)
	  
	  #### 推荐阅读
	  - [阿里又一个 20k+ stars 开源项目诞生，恭喜 fastjson！](https://mp.weixin.qq.com/s/RNKDCK2KoyeuMeEs6GUrow)
	  
	  ---
	  欢迎关注我的公众号“**风oneo**”，原创内容第一时间推送。
	  <center>
	      <img src="https://images-1253243403.cos.ap-guangzhou.myqcloud.com/1718001556563-738acba5-b4c2-4fb1-938c-62cb41ec9cca.png" style="width: 200px;">
	  </center>
	  ```
	- 可通过插件发布到多个平台； 二维码是用网上生成的
		- ![image.png](../assets/image_1680596032417_0.png){:height 92, :width 117}
		- [openwrite收费的](http://admin.openwrite.cn/#/diffusion/setting)
		- Lk6SpBSabakxGoSArrzz vV0ZH3qnntuj
		- -- / images-1253243403
		- css配置：
			- ```
			  /*
			    按Ctrl/Command+F可格式化
			  */
			  /* 一级标题样式 */
			  h1 {
			      /*margin: 1em 0em 0em 4em; */ /* 这里设置了导致居中不太准， 上右下左*/
			    align-content: center;
			  }
			  /* 二级标题样式 */
			  h2 {
			    margin: 2em 0em 0em 0em; /* 上右下左*/
			    background: red;
			  }
			  /* 三级标题样式 */
			  h3 {
			  }
			  /* 四级标题样式 */
			  h4 {
			  }
			  /* 图片样式 */
			  image {
			  }
			  /* 引用样式 */
			  blockquote {
			    margin: 0.2em 0em 0em 0em;
			  }
			  /* 引用段落样式 */
			  blockquote_p {
			    margin: 0em 0em 0em 0em;
			    font-size: 86%;
			    background-color: ;
			  }
			  /* 段落样式 */
			  p {
			  }
			  /* 分割线样式 */
			  hr {
			  }
			  /* 行内代码样式 */
			  codespan {
			    font-size: 80%;
			    color: blue;
			  }
			  /* 粗体样式 */
			  strong {
			  }
			  /* 链接样式 */
			  link {
			  }
			  /* 微信链接样式 */
			  wx_link {
			  }
			  /* 有序列表样式 */
			  ol {
			  }
			  /* 无序列表样式 */
			  ul {
			  }
			  /* 列表项样式 */
			  li {
			  }
			  /* 代码块样式 */
			  code {
			   margin: 0em 0em 0em 0em;
			    font-size: 75%;
			  }
			  
			  ```
- hugo发送github.io
-
