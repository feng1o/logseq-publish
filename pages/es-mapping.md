- <a class=apple> es-mapping </a>
	- 作用：等同于db里的表定义，define index  item name and type,  倒排索引的相关配置，比如是否索引、记录position等
	- mapping定义：index.mapping.total_fields.limit：字段的最大数量，默认 1000
	  index.mapping.depth.limit：字段的最大深度，以内部对象的数量来计算，默认是20; 最外层{{{x多少}}}
	  index.mapping.nested_fields.limit：索引中嵌套字段的最大数量，默认是50
	- text和keyword区别：text全文检索，模糊查询； keyword 精确查询 排序 聚合
		- <a href=https://blog.csdn.net/weixin_43859729/article/details/107914539 class=inline-box>映射参数<span class=gray>fields：</span></a>
		  ```
		  "ZD" : {
		    "type" : "text",
		    "norms" : false,
		    "fields" : {
		      "keyword" : {
		        "type" : "keyword",
		        "index" : false
		      }
		    }
		  }  // term精确查询用 ZD.keyword；  ​ match分词查询时用 ZD
		  		  
		  主类型是：keyword  映射是text
		  "ZD" : {
		    "type" : "keyword",
		    "fields" : {
		      "index_oxye" : {
		        "type" : "text",
		        "anaylzer" : "index_oxye"
		      }
		    }
		  }  // term精确查询用 ZD  ​ match分词查询时用 ZD.index_oxye
		  
		  如果es中索引mapping里该字段是type：“text”，filed中再定义type：“keyword”的话，查询中不加keyword会查不到
		  
		  ```
		-
- _temp ate模板，控制index的自动生成滚动，比如按天，条数等 _temp late/xx
-