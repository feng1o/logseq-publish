alias:: tpl
icon:: 

- ### 1. daily work report tpl
  background-color:: #978626
- [[Daily work report]]  #t
  template:: daily-tpl
	- [[daily-plan]]
	- [[daily-done]]
		-
	- [[developer]]
		- query-table:: true
		  #+BEGIN_QUERY 
		  {:title [:h5.font-bold.red.opacity-40"查询关键work"]
		  :query (and "work-plan" (not "tpl") (not "done")) 
		  :result-transform (fn [result]
		                          (sort-by(  fn [h]
		                                    (get h :block/id 1)  ) result))
		  :breadcrumb-show? false
		  }
		  #+END_QUERY
	- [[daily-alg]]
		- ((6221ab64-4eb7-4b67-afe2-d8ead98f61bd))
		- [[seesee]]
		- [-question-](https://static.kancloud.cn/qq5202056/gomianshi/2657252) #interview  <a class="alg-hard"></a>
		-
- ### 2. -例子tpl<span class="hide">work-plan</span>
  background-color:: #978626
- 2. tpl <span class="hide">work-plan</span>
- <span class="hide">work-plan</span>
  template:: work-plan-tpl
-
- ### 3. <p class="gray subw  inline_box underline"><span style="color: red;background-color: lightblue;font-weight:bold;font-size:12px"> 区别:</span>回溯也用到递归，过的</p>
  background-color:: #978626
- <p class="gray subw  inline_box underline"><span style="color: red;background-color: lightblue;font-weight:bold;font-size:12px"> 递归回溯区别:</span>回溯也用到递归，但是相比递归多了条件剪纸，结束条件等； 而递归就是回调自身，斐波那契数列为例，不存在发现结果不对倒回去的步骤； 回溯比如一个格子里走出去，走不通了回去继续换个路劲，一般要有个状态记录走过的</p>
  template:: highlight-h-tpl
-
- ### 4.   inblock高亮加框注释
  background-color:: #978626
  <p class="bsize"><span class=inblock>span ansg agd</span> I am a paragraph and this is a test inside that paragraph. A span is an inline element and so does not respect width and height.asgasgkasgkasngasklgnalksgnaslgnlakgklasgagasgasgasgsgajaj,askgnag,agna,akgnagag
  </p>
- <style>
  template:: inblock-tpl
  .bsize {
    /*width: 500px;
    height: 150px;*/
  }
  </style>
  <p class="bsize"><span class=inblock>提示标记</span> -------内容-------
  </p>
-
- ### 5. <a href =https://github.com/golang-standards/project-layout/blob/master/README_zh-CN.md class="apple underline">day-tag-tpl例子 <span class=" bg-green white  subw hblack hover">[[2022-03-25 Fri]] </span></a>
  background-color:: #978626
- <span class=" bg-green white  subw hblack hover">/</span>
  template:: day-tag-tpl
-
- ### 6.测试标签 -- 类tpl
  background-color:: #978626
	- <a class="alg-1stars bd-blue">2star</a>
	- <a class="alg-2stars bd-blue">2star</a>
	- <a class="alg-3stars bd-blue">2star</a>
	- <a class="alg-4stars bd-blue">2star</a>
	- <a class="alg-easy bd-blue">2star</a>
	- <a class="alg-medium bd-blue">2star</a>
	- <a class="alg-hard bd-blue">2star</a>
	- <a class="apple bd-blue">apple</a>
-
- ### 7.算法列表
  background-color:: #978626
- <html><a  class="alg-2stars"       href=
  id:: 64034177-211f-4de2-82aa-90cbfaf6cbc5
  
  🌶https://leetcode-cn.com/problems/maximum-points-in-an-archery-competition🌶
  
  ><span class="width-55-hide bg-lightgray-del">
  
  🌶6029.射箭比赛中的最大=====>🌶
  
  <span class="hide">dalg</span>
  <span class="gray subw9">
  -tip-
  </span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >😁双指针</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >😭注释asgasgasg</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >😄次数asdgasg</a>
  </html>
	- #### 7.1  dalg
		- <html><a  class="alg-2stars"       href=
		  template:: dalg-tpl2
		  
		   http:///xxx.com
		  
		  ><span class="width-55-hide bg-lightgray-del">
		  
		  6029.射箭比赛中的最大=====>
		  
		  <span class="hide">dalg</span>
		  <span class="gray subw9">
		  
		  -tip-
		  
		  </span></span></a>  <a 
		  class="indent1  subw8 blue    width-13-hide                                        " >回溯</a><a 
		  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >comment</a><a 
		  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
		  </html>
	- ##### 7.2 hot100
		- <html><a  class="alg-2stars"       href=
		  template:: hot100-tpl
		  
		  http:://xxx.com
		  
		  ><span class="width-55-hide bg-lightgray-del">
		  
		  2.两数相加
		  
		  <span class="hide">dalg</span><span class="hide">hot100</span>
		  <span class="gray subw9">
		  
		  -tip-hot100- 
		  
		  <span class=" bg-green white  subw hblack hover"> [[2022-08-30 Tue]] </span>
		  </span></span></a>  <a 
		  class="indent1  subw8 blue    width-13-hide                                        " >链表</a><a 
		  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >comment</a><a 
		  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
		  </html>
- <html><a style="width:30%;border: 1px solid black; display:inline-block;">  d1 </a><a style="width:20%;border: 1px solid red; display:inline-block;">d2</a></html>
- <html><a  class="alg-2stars"       href=
  
  ><span class="width-55-hide bg-lightgray-del">
  
  2.两数相加
  
  <span class="hide">dalg</span><span class="hide">hot100</span>
  <span class="gray subw9">
  
  -tip-hot100 <span class=" bg-green white  subw hblack hover"> [[2022-08-30 Tue]] </span>
  
  </span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >链表</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >dummy结点</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
  </html>
- ###### win-dal-tpl
	- <html><a  class="alg-2stars"       href=
	  template:: dalg-tpl-2
	  
	  🌶https://leetcode-cn.com/problems/maximum-points-in-an-archery-competition🌶
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  
	  🌶6029.射箭比赛中的最大=====>🌶
	  
	  <span class="hide">dalg</span>
	  <span class="gray subw9">
	  
	  -tip-
	  
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >指针</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >common</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
	- <html><a  class="alg-2stars"       href=
	  template:: hot10-tpl-2
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  
	  2.两数相加
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  
	  tip-hot100 
	  
	  <span class=" bg-green white  subw hblack hover"> [[2022-08-30 Tue]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >链表</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >common</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
- ### 8.english words
  background-color:: #978626
- <a>idempotent <span class="blue subw9">  aɪ.demˈpoʊ.t̬ənt</span></a>
  template:: english-word-tpl
-
- ### 9.css template
  background-color:: #978626
- |des|effects|comment|other|
  |--|--|--|--|
  |改字大小|<span class="subw8">subw8</span>|subw8| subw7 8 9|
  |下划线|<span class="underline"> 测试</span>|underline||
  |颜色|<span class="blue"> 颜色</span>|blue|red blue gray...|
  |背景颜色|<span class="bg-yellow"> 背景颜色</span>|bg-yellow|bg-blue gray |
  |行后加标记 伪元素|<a class="alg-2stars bd-blue">2star</a>|alg-2stars| 3 4 1|
  |- |<a class="alg-easy bd-blue">2star</a>|alg-easy|easy medi hard|
  | - |<html><a style="width:30%;border: 1px solid black; display:inline-block;">  d1 </a><a style="width:20%;border: 1px solid red; display:inline-block;">d2</a></html>|加border inline后||
  |-|<a class="apple">2star</a>|apple|coffee pear|
  |||||
	- <span class="subw8">subw8</span>
	  template:: tpl-subw8
- ### 10.ask
  background-color:: #978626
	- <span> <a class=ask>  ask </a>  <span class=" bg-green white  subw hblack hover"> [[2022-09-08 Thu]] </span></span>
	  template:: ask-tpl
	- <a class=ask>如何确保新的从库拥有主库数据的精确副本</a>
- ### 11.***
  background-color:: #978626
- <span class=" bg-red red  subw9 hblack hover">***</span>
  template:: tpl-*
- ### 12.markdown 折叠
  background-color:: #978626
- <details> <summary>Title</summary>
  template:: markdown-code-tpl
  
  <code>
  
  
  </code>
  </details>
-
- ### 13. TODO master
- #+BEGIN_QUERY
  {:title "{{renderer :todomaster}}"
      :query [:find (pull ?h [*])
              :in $ ?start ?next
              :where
              [?h :block/marker ?marker]
              [?h :block/refs ?p]
              [?p :block/journal? true]
              [?p :block/journal-day ?d]
              [(> ?d ?start)]
              [(< ?d ?next)]]
      :inputs [:today :7d-after]
      :collapsed? false}
  #+END_QUERY
	- DONE 1
	- DONE 2
	- {{renderer :todomaster}}
		- LATER 01
		- NOW 1 /TODO
		  :LOGBOOK:
		  CLOCK: [2024-02-04 Sun 17:18:00]--[2024-02-04 Sun 17:18:01] =>  00:00:01
		  CLOCK: [2024-02-04 Sun 17:18:01]--[2024-02-04 Sun 17:18:02] =>  00:00:01
		  CLOCK: [2024-02-04 Sun 17:18:04]
		  :END:
		- TODO x
- ### 14. toc gen
- {{renderer :tocgen2, [[删除此处]], auto, 1}}
  template:: tpl-tocgen
-