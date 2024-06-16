- ==summary-dp==
  id:: 63fec8c0-d83e-41fc-b105-3137fcbd4d0a
	- 公式推导、空间换时间
- collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.font-bold.blue.opacity-40"3. query (and BFS (and dalg (not  tpl)) )"]
  :query (and "dp" (and "dalg" (not  "tpl")) )
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show?  false
  :collapsed? true
  }
  #+END_QUERY
- <html><a  class="alg-medium"       href=
  https://leetcode.cn/problems/gu-piao-de-zui-da-li-run-lcof/solution/mian-shi-ti-63-gu-piao-de-zui-da-li-run-dong-tai-2/><span class="width-55-hide bg-lightgray-del">
  股票卖一次最多能赚多少<span class="hide">dalg</span>
  <span class="gray subw9">
  -理解dp思想- <span class=" bg-green white  subw hblack hover"> [[2022-05-10 Tue]] </span>
  </span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >dp</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >dp</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
  </html>
- <html><a  class="alg-medium"       href=
  https://leetcode.cn/problems/longest-palindromic-substring/submissions/
  ><span class="width-55-hide bg-lightgray-del">
  
  5.最长回文
  <span class="hide">dalg</span><span class="hide">hot100</span>
  <span class="gray subw9">
  
  -dp理解-hot5 <span class=" bg-green white  subw hblack hover"> [[2022-09-04 Sun]] </span>
  
  </span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >dp</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >理解</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
  </html>
- <html><a  class="alg-2stars"       href=
  id:: 640556a9-e257-4bbe-bd18-4e33f1d8180e
  https://leetcode.cn/problems/counting-bits/solutions/627418/bi-te-wei-ji-shu-by-leetcode-solution-0t1i/
  
  ><span class="width-55-hide bg-lightgray-del">
  
  338. 0-n的二进制1的个数
  
  <span class="hide">dalg</span><span class="hide">hot100</span>
  <span class="gray subw9">
  
  -tip-dp-进制转换easy <span class=" bg-green white  subw hblack hover"> [[2022-10-17 Mon]] </span>
  
  </span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >dp</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >dp</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
  </html>
- <html><a  class="alg-2stars"       href=
  id:: 640556a9-7812-45dc-b382-e1b07bfb855e
  
   https://leetcode.cn/problems/trapping-rain-water/
  
  ><span class="width-55-hide bg-lightgray-del">
  
  42.接雨水-能装多少
  
  <span class="hide">dalg</span>
  <span class="gray subw9">
  
  连边最高
  
  </span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >dp</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >dp</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
  </html>
- <html><a  class="alg-2stars"       href=
  id:: b9201066-8fca-47d2-8c2e-c933942baa88
  
  https://leetcode.cn/problems/house-robber/solution/dong-tai-gui-hua-jie-ti-si-bu-zou-xiang-jie-cjavap/
  ><span class="width-55-hide bg-lightgray-del">
  
  198.打家劫舍 
  <span class="hide">dalg</span>
  <span class="gray subw9">
  
  理解dp为什么不需要fn-3
  
  </span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >dp</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >dp</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
  </html>
	- 关键理解:: fn=max(n+fn-1, fn-2)， 实际上是可以选择n或者fn-1 - 0之间任意一个，即fn=max(n+fn-2, fn-1, man(n, n-1) + fn-3 ....)
	- id:: 6403f848-a47e-4051-8677-d9a5d0aeb6e3
	  打家劫舍:: 不可连续选，[dalg-code-   dfs写法](logseq://graph/logseq?block-id=64041e1e-af18-4294-973b-222040e91885)
		- logseq://graph/logseq?block-id=64041e1e-af18-4294-973b-222040e91885
	- 53. 最大子数组和 [推演方法](https://leetcode.cn/problems/maximum-subarray/)