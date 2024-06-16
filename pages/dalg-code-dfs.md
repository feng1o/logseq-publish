- ((6403f848-a47e-4051-8677-d9a5d0aeb6e3))
	- id:: 640556a8-65bf-4813-b800-8c346032eb4e
	  ```
	      // 递归的含义：从 i 位置开始，所能偷窃到的最高金额
	      int dfs(int i, vector<int>& nums)
	      {
	          int n = nums.size();
	          // 处理越界时候的情况
	          if (i == n || i == n + 1)
	              return 0;
	  
	          // 偷当前位置
	          int way1 = nums[i] + dfs(i + 2, nums);
	  
	          // 不偷当前位置
	          int way2 = dfs(i + 1, nums);
	  
	          // 返回两种情况下的最大值
	          return max(way1, way2);
	      }
	      
	      int dfs(int i, vector<int> &nums) {
	      	if (i >= nums.size()) {
	          	return 0;
	          }
	          
	          for(int j = 1; j < nums.size()-i; j++) {
	          	
	          }
	      }
	  ```