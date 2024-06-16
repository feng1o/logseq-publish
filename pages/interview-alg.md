page-type:: [[Algorithm]] #interview

- {{renderer :tocgen2, [[]], auto, 1}}
- {{cards [[interview-alg]] }}
- #####  0.[[计划]]
- #### 1. 滑动窗口 [[滑动窗口]] ((62303a0c-2f26-40aa-bc7a-adc6e299fe72))
  collapsed:: true
	- > a. 无重复最长子串  3
	- id:: 63f63c42-328e-4806-8912-3ed01748ea3e
	  ``` cpp
	  int lengthOfLongestSubstring(string s) {
	          unordered_map<char, int> mp;
	          int l = 0, r = 0;
	          int res = 0;
	  
	          while (r < s.size()) {
	              char c = s.at(r);
	              r++;
	              mp[c]++;
	              while(mp[c] > 1) {
	                  char d = s[l];
	                  l++;
	                  mp[d]--;
	              }
	              res = max(res, r - l);
	          }
	          return res;
	      }
	  ```
- #### 2.backtrace [[回溯]] ((fa46fb8b-f417-4457-aae7-bcfacfda375d))
	- id:: 63fcb11e-cf94-49ec-b947-a0d63e720e14
	  query-table:: false
	  #+BEGIN_QUERY 
	  {:title [:h5.font-bold.blue.opacity-40"3. query (and BFS (and dalg (not  tpl)) )"]
	  :query (and "回溯" (and "dalg" (not  "tpl")) )
	  :result-transform (fn [result]
	                          (sort-by(  fn [h]
	                                    (get h :db/id 1)  ) > result))
	  :breadcrumb-show?  false
	  :collapsed? false
	  }
	  #+END_QUERY
	- ((63f7088c-681a-4fae-a9f0-3712420bbe3c))
	- > a. 子集问题 ---  78  是个[[$red]]==组合，无序==的（1,2) == (2,1)
	  > a.  n内k个数组合   --- 77  和78类似   
	  > b. 无重复元素的全排列  --- 046  排列有序(1,2) != (2,1)
	  > c. N皇后问题   --- 51   为何带n结束条件
		- 这俩差异:: [[$red]]==循环位置，为什么要取start和从0，不用for的dfs理解==
		- ((64040012-65eb-4357-b031-cee3bd635613))
		- ```cpp
		      vector<vector<int>> permute(vector<int>& nums) {  //46 无重复全排列
		           vector<bool> visited(nums.size(), false);   。。。
		           trace(nums, visited, tmp, res);
		           return res;
		      }
		  
		      void trace(vector<int> &nums, vector<bool> &visited, vector<int> &tmp, vector<vector<int>> &res) {
		          if (nums.size() == tmp.size()) {
		              res.push_back(tmp);
		              return;
		          }
		          for (int i = 0; i < nums.size(); ++i) {  // 无重复，全排列，所有都要有
		              if (visited[i]) 
		                  continue;
		              tmp.push_back(nums[i]);
		              visited[i] = true;
		              trace(nums, visited, tmp, res);
		              tmp.pop_back();
		              visited[i] = false;
		            //trace(nums, visited, tmp, res); // 为什么不继续trace？
		          }
		      }
		  ```
		- ```shell
		  void trace(vector<string> &v, int r, int n, vector<vector<string>> & res) {  // n queue后问题
		          if (n == r) {
		              res.push_back(v);
		              return;
		          }
		  
		          for (int i = 0; i < n; ++i) {
		              if (!isValid(v, r, i)) {
		                  continue;
		              }
		              v[r][i] = 'Q';
		              trace(v, r+1, n, res);
		              v[r][i] = '.';
		          }
		      }
		  ```
- #### 3.binary tree [[二叉树&递归]]  ((62559f2d-97ee-4213-89a0-1e49113cb45b))
  collapsed:: true
  > 翻转list   daoyu-nums
	- #+BEGIN_QUERY 
	  {:title [:h5.font-bold.blue.opacity-40:color.red"3.query (and  (or 递归  二叉树) (and dalg (not  tpl)) )"]
	  :query (and  (or "递归"  "二叉树") (and "dalg" (not  "tpl")) )
	  :result-transform (fn [result]
	                          (sort-by(  fn [h]
	                                    (get h :db/id 1)  ) > result))
	  :breadcrumb-show?  false
	  :collapsed? false
	  }
	  #+END_QUERY
- ### 4.sort [[排序]] ((63fdf602-873c-45c6-affd-25a14d6e2b99))
  collapsed:: true
	- query-table:: false
	  #+BEGIN_QUERY 
	  {:title [:h5.font-bold.blue.opacity-40"3. query (and BFS (and dalg (not  tpl)) )"]
	  :query (and "排序" (and "dalg" (not  "tpl")) )
	  :result-transform (fn [result]
	                          (sort-by(  fn [h]
	                                    (get h :db/id 1)  ) > result))
	  :breadcrumb-show?  false
	  :collapsed? false
	  }
	  #+END_QUERY
- #### 5.dp [[DP]] ((63fec8c0-d83e-41fc-b105-3137fcbd4d0a))
  collapsed:: true
	- #+BEGIN_QUERY 
	  {:title [:h5.font-bold.blue.opacity-40"3. query (and dp(and dalg (not  tpl)) )"]
	  :query (and "dp" (and "dalg" (not  "tpl")) )
	  :result-transform (fn [result]
	                          (sort-by(  fn [h]
	                                    (get h :db/id 1)  ) > result))
	  :breadcrumb-show?  false
	  :collapsed? false
	  }
	  #+END_QUERY
- #### 6.other [[other]] ((64045f17-dac7-4f0f-bca0-208825eebcb0))
  id:: 640556a9-df91-4d7e-a0c8-c48c36d0473f
  collapsed:: true
	- {{embed ((64045f17-dac7-4f0f-bca0-208825eebcb0))}}
	- {{embed ((64046053-0313-4955-9830-a16b6e5aa0c8))}}
- #### 7. hot100
  background-color:: red
	- <html><a  class="alg-2stars"       href=https://leetcode.cn/problem-list/2cktkvj/
	  template:: 100hot
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  
	  1.两数和
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  
	  hash存在否
	  
	  <span class=" bg-green white  subw hblack hover"> [[2023-03-12 Sun]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >hash</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >hash</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
	- <html><a  class="alg-2stars"       href=https://leetcode.cn/problem-list/2cktkvj/
	  template:: 100hot
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  2.两数相加
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  
	  链表进位记录
	  <span class=" bg-green white  subw hblack hover"> [[2023-03-12 Sun]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >无</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >无</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
	- <html><a  class="alg-2stars"       href=https://leetcode.cn/problem-list/2cktkvj/
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  3.无重复最长子串
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  
	  滑动窗口
	  <span class=" bg-green white  subw hblack hover"> [[2023-03-12 Sun]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >滑动窗口</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >无</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
	- <html><a  class="alg-2stars"       href=https://leetcode.cn/problem-list/2cktkvj/
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  4.两个正序数组的中位数
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  
	  k/2一次剔除最小的一部分
	  <span class=" bg-green white  subw hblack hover"> [[2023-03-12 Sun]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >排序剔除</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >无</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
	- <html><a  class="alg-2stars"       href=https://leetcode.cn/problem-list/2cktkvj/
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  5.最长回文子串
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  中间扩展
	  <span class=" bg-green white  subw hblack hover"> [[2023-03-12 Sun]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >无</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >无</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
		- 10. 正则匹配
	- <html><a  class="alg-2stars"       href=https://leetcode.cn/problem-list/2cktkvj/
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  11.盛最多水的容器
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  
	  dp推演中间扩展选小的一边
	  <span class=" bg-green white  subw hblack hover"> [[2023-03-12 Sun]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >无</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >无</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
	- <html><a  class="alg-2stars"       href=https://leetcode.cn/problem-list/2cktkvj/
	  
	  ><span class="width-55-hide bg-lightgray-del">
	  15.三数之和
	  
	  <span class="hide">dalg</span><span class="hide">hot100</span>
	  <span class="gray subw9">
	  
	  类似2数之和，排序求另外两个i+1,n-1收缩
	  <span class=" bg-green white  subw hblack hover"> [[2023-03-12 Sun]] </span>
	  </span></span></a>  <a 
	  class="indent1  subw8 blue    width-13-hide                                        " >无</a><a 
	  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >无</a><a 
	  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
	  </html>
		- [17. 电话号码的字母组合](https://leetcode.cn/problems/letter-combinations-of-a-phone-number/?favorite=2cktkvj)<span class="subw">回溯</span>、
		- [19. 删除链表的倒数第 N 个结点](https://leetcode.cn/problems/remove-nth-node-from-end-of-list/?favorite=2cktkvj)  双指针]
	- #### 10
	  background-color:: red
		- [20. 有效的括号](https://leetcode.cn/problems/valid-parentheses/?favorite=2cktkvj)   栈
		- [21. 合并两个有序链表](https://leetcode.cn/problems/merge-two-sorted-lists/?favorite=2cktkvj)  [[$sub8]]==归并和双指针==
		- [22. 括号生成](https://leetcode.cn/problems/generate-parentheses/?favorite=2cktkvj) [[$sub8-red]]==回溯、剪枝方法==
		- [23. 合并K个升序链表](https://leetcode.cn/problems/merge-k-sorted-lists/?favorite=2cktkvj)  [[$sub8-gray]]==递归、两有序list合并==
		- [31. 下一个排列](https://leetcode.cn/problems/next-permutation/?favorite=2cktkvj)  规律，倒着找
		- [32. 最长有效括号](https://leetcode.cn/problems/longest-valid-parentheses/?favorite=2cktkvj) dp  栈 [[$red]]==有必要理解==  栈的方法要会 #interview #card
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:35:59.315Z
		  card-last-reviewed:: 2024-02-27T03:35:59.316Z
		  card-last-score:: 3
		- [33. 搜索旋转排序数组](https://leetcode.cn/problems/search-in-rotated-sorted-array/?favorite=2cktkvj)  画图理解，某部分有序
		- [34. 在排序数组中查找元素的第一个](https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/?favorite=2cktkvj)  二分查找、实在不行==单独处理
		- [39. 组合总和](https://leetcode.cn/problems/combination-sum/?favorite=2cktkvj)  可重复使用回溯
		- [42. 接雨水](https://leetcode.cn/problems/trapping-rain-water/?favorite=2cktkvj)  栈、看图分析比栈顶大的都直接入栈
	- #### 20
	  background-color:: green
		- [46. 全排列](https://leetcode.cn/problems/permutations/?favorite=2cktkvj)  回溯 visited标记，每个都要从0开始 #card
		  card-last-interval:: -1
		  card-repeats:: 1
		  card-ease-factor:: 2.5
		  card-next-schedule:: 2024-01-15T16:00:00.000Z
		  card-last-reviewed:: 2024-01-15T11:42:51.293Z
		  card-last-score:: 1
		- [48. 旋转图像](https://leetcode.cn/problems/rotate-image/?favorite=2cktkvj)  算下标 r c交换，n-c-1
		- [49. 字母异位词分组](https://leetcode.cn/problems/group-anagrams/?favorite=2cktkvj) - 排序hash -- [[$red]]==未做？== 答案中的c++map处理[可参考](https://leetcode.cn/problems/group-anagrams/solution/zi-mu-yi-wei-ci-fen-zu-by-leetcode-solut-gyoc/)  ((64129ba8-ac39-427d-953b-b8352cb9029b))
		- [53. 最大子数组和](https://leetcode.cn/problems/maximum-subarray/?favorite=2cktkvj)  dp方法值得思考，为什么一个前缀标记ok   ==分治方法未看==
		- [55. 跳跃游戏](https://leetcode.cn/problems/jump-game/?favorite=2cktkvj)   贪心，写法可看
		- [56. 合并区间](https://leetcode.cn/problems/merge-intervals/?favorite=2cktkvj)  排序-双指针找
		- DONE [62. 不同路径-只能向下右走](https://leetcode.cn/problems/unique-paths/?favorite=2cktkvj)  dp 实际上还有回溯
		- DONE [64. 最小路径和-下右走](https://leetcode.cn/problems/minimum-path-sum/?favorite=2cktkvj) 和62题差不多 #20231203
		- [70. 爬楼梯](https://leetcode.cn/problems/climbing-stairs/?favorite=2cktkvj)  简单迭代
			- [72. 编辑距离](https://leetcode.cn/problems/edit-distance/?favorite=2cktkvj)  dp思路，两个单词dp[i][j] 前i个改成前j个
	- #### 30
	  background-color:: blue
		- [75. 颜色分类](https://leetcode.cn/problems/sort-colors/?favorite=2cktkvj)  012原地转，三指针00 n-1移动
		- [76. 最小覆盖子串](https://leetcode.cn/problems/minimum-window-substring/?favorite=2cktkvj)   滑动窗口、两个mp对比 #resee
		- [78. 子集](https://leetcode.cn/problems/subsets/?favorite=2cktkvj)  回溯 lambdong的看
		- [79. 单词搜索](https://leetcode.cn/problems/word-search/?favorite=2cktkvj)  回溯走棋盘 理解 #20231203
		- [#A] [84. 柱状图中最大的矩形](https://leetcode.cn/problems/largest-rectangle-in-histogram/?favorite=2cktkvj)   栈-写法细节
			- [85. 最大矩形](https://leetcode.cn/problems/maximal-rectangle/?favorite=2cktkvj)
		- [94. 二叉树的中序遍历](https://leetcode.cn/problems/binary-tree-inorder-traversal/?favorite=2cktkvj)  非递归方法可看 [前后中非递归遍历](https://leetcode.cn/problems/binary-tree-preorder-traversal/solutions/87526/leetcodesuan-fa-xiu-lian-dong-hua-yan-shi-xbian-2/) #20231203
		- [96. 不同的二叉搜索树](https://leetcode.cn/problems/unique-binary-search-trees/?favorite=2cktkvj)  推算F(i,n)=以i为根，左右边成G(i)*G(n-i)，G(n)=F(1,...n,n)加的 dp #interview #card
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:35:43.113Z
		  card-last-reviewed:: 2024-02-27T03:35:43.114Z
		  card-last-score:: 3
		- [98. 验证二叉搜索树](https://leetcode.cn/problems/validate-binary-search-tree/?favorite=2cktkvj)   [[$red]]==必看递归方法== 前序遍历用一个标记对比 #interview #card #20231203
		  card-last-score:: 3
		  card-repeats:: 2
		  card-next-schedule:: 2024-03-02T03:35:50.983Z
		  card-last-interval:: 4
		  card-ease-factor:: 2.22
		  card-last-reviewed:: 2024-02-27T03:35:50.983Z
		- [230.二叉搜索树中第k小元素](https://leetcode.cn/problems/kth-smallest-element-in-a-bst/?envType=study-plan-v2&envId=top-100-liked)  中序遍历 #20231203
		- [199.二叉树的右视图](https://leetcode.cn/problems/binary-tree-right-side-view/description/?envType=study-plan-v2&envId=top-100-liked) #20231203
		- [101. 对称二叉树](https://leetcode.cn/problems/symmetric-tree/?favorite=2cktkvj) 递归dfs #interview #card
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:36:07.782Z
		  card-last-reviewed:: 2024-02-27T03:36:07.782Z
		  card-last-score:: 3
			- https://leetcode.cn/problems/symmetric-tree/?favorite=2cktkvj
			- https://leetcode.cn/problems/symmetric-tree/?favorite=2cktkvj
	- #### 40
	  background-color:: blue
	  collapsed:: true
		- [102. 二叉树的层序遍历](https://leetcode.cn/problems/binary-tree-level-order-traversal/?favorite=2cktkvj)  queue
		- [104. 二叉树的最大深度](https://leetcode.cn/problems/maximum-depth-of-binary-tree/?favorite=2cktkvj)  dfs bfs
			- 最小深度呢？
		- [105. 从前序与中序遍历序列构造二叉树](https://leetcode.cn/problems/construct-binary-tree-from-preorder-and-inorder-traversal/?favorite=2cktkvj)  dfs和迭代bfs可看细节 #interview #20231203
		- DONE [114. 二叉树展开为链表](https://leetcode.cn/problems/flatten-binary-tree-to-linked-list/?favorite=2cktkvj)  递归方法理解  [[$red]]==非递归需会== #interview #card #20231203
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:35:31.603Z
		  card-last-reviewed:: 2024-02-27T03:35:31.603Z
		  card-last-score:: 3
		- [121. 买卖股票的最佳时机](https://leetcode.cn/problems/best-time-to-buy-and-sell-stock/?favorite=2cktkvj)  可看下
		- [124. 二叉树中的最大路径和](https://leetcode.cn/problems/binary-tree-maximum-path-sum/?favorite=2cktkvj)  递归计算、和计算直径类似 #interview #card
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:35:55.102Z
		  card-last-reviewed:: 2024-02-27T03:35:55.102Z
		  card-last-score:: 3
		- DONE [128. 最长连续序列](https://leetcode.cn/problems/longest-consecutive-sequence/?favorite=2cktkvj) ---  要看 hash-1没，+1遍历找[[$red]]==二面题==byte #interview #card
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:36:05.033Z
		  card-last-reviewed:: 2024-02-27T03:36:05.033Z
		  card-last-score:: 3
		- [136. 只出现一次的数字](https://leetcode.cn/problems/single-number/?favorite=2cktkvj) 位运算，简单
		- DONE [139. 单词拆分](https://leetcode.cn/problems/word-break/?favorite=2cktkvj)   DP方法最后x结尾去dp #20231203
		- [141. 环形链表](https://leetcode.cn/problems/linked-list-cycle/?favorite=2cktkvj) easy
	- #### 50
	  background-color:: green
	  collapsed:: true
		- [142. 环形链表 II](https://leetcode.cn/problems/linked-list-cycle-ii/?favorite=2cktkvj)  2低双指针、需要注意遇到后怎么找到入口node #20231203
		- [146. LRU 缓存](https://leetcode.cn/problems/lru-cache/?favorite=2cktkvj) #meet
	- [148. 排序链表](https://leetcode.cn/problems/sort-list/?favorite=2cktkvj)  链表归并的理解- h->next = tailf后h->next=null
		- [152. 乘积最大子数组](https://leetcode.cn/problems/maximum-product-subarray/?favorite=2cktkvj)
		- [155. 最小栈](https://leetcode.cn/problems/min-stack/?favorite=2cktkvj)
		- [160. 相交链表](https://leetcode.cn/problems/intersection-of-two-linked-lists/?favorite=2cktkvj)  hash 或两个指针
		- [169. 多数元素](https://leetcode.cn/problems/majority-element/?favorite=2cktkvj)
		- [198. 打家劫舍](https://leetcode.cn/problems/house-robber/?favorite=2cktkvj)
		- [200. 岛屿数量](https://leetcode.cn/problems/number-of-islands/?favorite=2cktkvj) #20231203
		- [206. 反转链表](https://leetcode.cn/problems/reverse-linked-list/?favorite=2cktkvj)
	- #### 60
	  background-color:: purple
		- DONE [207. 课程表](https://leetcode.cn/problems/course-schedule/?favorite=2cktkvj)  有向图 出入度 广度处理 #interview #card #20231203
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:35:36.982Z
		  card-last-reviewed:: 2024-02-27T03:35:36.982Z
		  card-last-score:: 3
			-
		- [208. 实现 Trie (前缀树)](https://leetcode.cn/problems/implement-trie-prefix-tree/?favorite=2cktkvj) #20231203
		- [215. 数组中的第K个最大元素](https://leetcode.cn/problems/kth-largest-element-in-an-array/?favorite=2cktkvj) 堆排序 #interview #card #20231203
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:36:14.999Z
		  card-last-reviewed:: 2024-02-27T03:36:14.999Z
		  card-last-score:: 3
		- [221. 最大正方形](https://leetcode.cn/problems/maximal-square/?favorite=2cktkvj)
			- TODO [207. 课程表](https://leetcode.cn/problems/course-schedule/?favorite=2cktkvj)  有向图 出入度 广度处理 #interview #card
			  card-last-interval:: 4
			  card-repeats:: 2
			  card-ease-factor:: 2.22
			  card-next-schedule:: 2024-03-02T03:35:40.216Z
			  card-last-reviewed:: 2024-02-27T03:35:40.217Z
			  card-last-score:: 3
				-
			- [208. 实现 Trie (前缀树)](https://leetcode.cn/problems/implement-trie-prefix-tree/?favorite=2cktkvj)
			- [215. 数组中的第K个最大元素](https://leetcode.cn/problems/kth-largest-element-in-an-array/?favorite=2cktkvj) 堆排序 #interview #card
			  card-last-interval:: 4
			  card-repeats:: 2
			  card-ease-factor:: 2.22
			  card-next-schedule:: 2024-03-02T03:36:12.583Z
			  card-last-reviewed:: 2024-02-27T03:36:12.583Z
			  card-last-score:: 3
			- [221. 最大正方形](https://leetcode.cn/problems/maximal-square/?favorite=2cktkvj)
		- [226. 翻转二叉树](https://leetcode.cn/problems/invert-binary-tree/?favorite=2cktkvj)
		- [234. 回文链表](https://leetcode.cn/problems/palindrome-linked-list/?favorite=2cktkvj)  递归  链表翻转 #interview #card
		  card-last-interval:: 4
		  card-repeats:: 2
		  card-ease-factor:: 2.22
		  card-next-schedule:: 2024-03-02T03:35:47.734Z
		  card-last-reviewed:: 2024-02-27T03:35:47.734Z
		  card-last-score:: 3
			- [236. 二叉树的最近公共祖先](https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-tree/?favorite=2cktkvj) #20231203
			- [238. 除自身以外数组的乘积](https://leetcode.cn/problems/product-of-array-except-self/?favorite=2cktkvj) [[$sub8-blue]]==双指针类似 值得看== #20231203
			- [239. 滑动窗口最大值](https://leetcode.cn/problems/sliding-window-maximum/?favorite=2cktkvj)  大根堆去判定 --可看 <a class="alg-hard"></a> #20231203
			- [240. 搜索二维矩阵 II](https://leetcode.cn/problems/search-a-2d-matrix-ii/?favorite=2cktkvj)
			- [279. 完全平方数](https://leetcode.cn/problems/perfect-squares/?favorite=2cktkvj)
			- [283. 移动零](https://leetcode.cn/problems/move-zeroes/?favorite=2cktkvj)
			- [287. 寻找重复数](https://leetcode.cn/problems/find-the-duplicate-number/?favorite=2cktkvj)
			- [297. 二叉树的序列化与反序列化](https://leetcode.cn/problems/serialize-and-deserialize-binary-tree/?favorite=2cktkvj)
			- [300. 最长递增子序列](https://leetcode.cn/problems/longest-increasing-subsequence/?favorite=2cktkvj) #20231203
			- [301. 删除无效的括号](https://leetcode.cn/problems/remove-invalid-parentheses/?favorite=2cktkvj)
			- [309. 最佳买卖股票时机含冷冻期](https://leetcode.cn/problems/best-time-to-buy-and-sell-stock-with-cooldown/?favorite=2cktkvj)
			- [312. 戳气球](https://leetcode.cn/problems/burst-balloons/?favorite=2cktkvj)
			- [322. 零钱兑换](https://leetcode.cn/problems/coin-change/?favorite=2cktkvj) #20231203
			- [337. 打家劫舍 III](https://leetcode.cn/problems/house-robber-iii/?favorite=2cktkvj)
			- [338. 比特位计数](https://leetcode.cn/problems/counting-bits/?favorite=2cktkvj)
			- [347. 前 K 个高频元素](https://leetcode.cn/problems/top-k-frequent-elements/?favorite=2cktkvj)
			- [394. 字符串解码](https://leetcode.cn/problems/decode-string/?favorite=2cktkvj)
			- [399. 除法求值](https://leetcode.cn/problems/evaluate-division/?favorite=2cktkvj)
			- [406. 根据身高重建队列](https://leetcode.cn/problems/queue-reconstruction-by-height/?favorite=2cktkvj)
			- [416. 分割等和子集](https://leetcode.cn/problems/partition-equal-subset-sum/?favorite=2cktkvj)
			- [437. 路径总和 III](https://leetcode.cn/problems/path-sum-iii/?favorite=2cktkvj)   递归思想值得看 #20231203
			- [438. 找到字符串中所有字母异位词](https://leetcode.cn/problems/find-all-anagrams-in-a-string/?favorite=2cktkvj) vector1==vector2比较 #interview #card
			  card-last-interval:: 4
			  card-repeats:: 2
			  card-ease-factor:: 2.22
			  card-next-schedule:: 2024-03-02T03:36:01.833Z
			  card-last-reviewed:: 2024-02-27T03:36:01.833Z
			  card-last-score:: 3
		- [448. 找到所有数组中消失的数字](https://leetcode.cn/problems/find-all-numbers-disappeared-in-an-array/?favorite=2cktkvj) easy原地修改下标和value对
		- [461. 汉明距离](https://leetcode.cn/problems/hamming-distance/?favorite=2cktkvj)  easy 位预算
		- [494. 目标和](https://leetcode.cn/problems/target-sum/?favorite=2cktkvj)   回溯理解  dp (sum-neg)-neg = target, neg= sum-target / 2最总算dp[i][neg] #interview #card
		  card-last-interval:: 8.32
		  card-repeats:: 3
		  card-ease-factor:: 2.08
		  card-next-schedule:: 2024-01-05T20:44:13.567Z
		  card-last-reviewed:: 2023-12-28T13:44:13.567Z
		  card-last-score:: 3
			- DONE [538. 把二叉搜索树转换为累加树](https://leetcode.cn/problems/convert-bst-to-greater-tree/?favorite=2cktkvj)   递归思路理解
		- DONE [543. 二叉树的直径](https://leetcode.cn/problems/diameter-of-binary-tree/?favorite=2cktkvj)  递归过程记录max值
		- [560. 和为 K 的子数组](https://leetcode.cn/problems/subarray-sum-equals-k/?favorite=2cktkvj) 前缀和  hash找 <a class="pin"></a>  [[$sub8-blue]]==这个注意前缀和必须统计可能相同结果的前缀和，需要用map记录同一个和出现次数==
		- [581. 最短无序连续子数组](https://leetcode.cn/problems/shortest-unsorted-continuous-subarray/?favorite=2cktkvj)  分析规律 两边各找
		- [617. 合并二叉树](https://leetcode.cn/problems/merge-two-binary-trees/?favorite=2cktkvj)  easy
		- [621. 任务调度器](https://leetcode.cn/problems/task-scheduler/?favorite=2cktkvj)   桶加len取最大
		- [647. 回文子串](https://leetcode.cn/problems/palindromic-substrings/?favorite=2cktkvj)   扩展
		- [739. 每日温度](https://leetcode.cn/problems/daily-temperatures/?favorite=2cktkvj)  栈
		- [41. 缺失的第一个正数](https://leetcode.cn/problems/first-missing-positive/solutions/304743/que-shi-de-di-yi-ge-zheng-shu-by-leetcode-solution/?envType=study-plan-v2&envId=top-100-liked)  hash方法标记理解 <a class="alg-hard"></a> <a class="pin"></a> #20231203
		- [24.两两交换链表中的结点](https://leetcode.cn/problems/swap-nodes-in-pairs/description/?envType=study-plan-v2&envId=top-100-liked)  递归方法值得理解 #20231203
		- [138.链表的复制](https://leetcode.cn/problems/copy-list-with-random-pointer/solutions/889166/fu-zhi-dai-sui-ji-zhi-zhen-de-lian-biao-rblsf/?envType=study-plan-v2&envId=top-100-liked) 递归方法 #20231203
		- [994.腐烂的橘子](https://leetcode.cn/problems/rotting-oranges/description/?envType=study-plan-v2&envId=top-100-liked) 标记、便利、走一次加 #20231203
		-
	- sword to offer:: start
		- [095最长公共子序列](https://leetcode.cn/problems/qJnOS7/)  dp[i][j]分别i和j个字符最长算到最后
	-
-
-