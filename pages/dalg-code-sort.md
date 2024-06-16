- ((64035686-22b2-48e0-9e35-4dd105dc33c6))
	- id:: 61124197-10ac-4206-9836-ab6f16bff013
	  ```c++
	  int partition(vector<int>& nums, int l, int r) {
	    int pivot = nums[r];
	    int i = l - 1;
	    for (int j = l; j <= r - 1; ++j) {
	      if (nums[j] <= pivot) {
	        i = i + 1;
	        swap(nums[i], nums[j]);
	      }
	    }
	    swap(nums[i + 1], nums[r]);
	    return i + 1;
	  }
	      int partitionx(vector<int> &nums, int l, int r) {
	          int rr = rand() % (r-l+1) + l; // int rr = l;
	          swap(nums[rr], nums[l]);
	          int flag = nums[l];
	          int index = l;
	          for (int i = l+1; i<=r; i++) {
	              if (nums[i] <= flag) {
	                  index = index+1;
	                  swap(nums[i], nums[index]);
	              }
	          }
	          swap(nums[l], nums[index]);  //  ---》 最关键的一步，必修swap之后才能把其拉倒中间正确的有序位置
	          return index;
	      }
	  
	      void quickSort(vector<int> &nums, int l, int r) {
	          if (l >= r) return;
	          int index = partition(nums, l, r);
	          quickSort(nums, l, index-1);
	          quickSort(nums, index+1, r);
	      }
	  
	      vector<int> sortArray(vector<int>& nums) {
	          //quickSort(nums, 0, nums.size()-1);
	          mergeSort(nums, 0, nums.size()-1);
	          srand(unsigned(time(NULL)));
	          return nums;
	      }
	  ```
		- ```c
		      void mergeSort(vector<int> &nums, int l, int r) {
		          if (l >= r) return;
		          int mid = l + (r -  l) / 2;
		          mergeSort(nums, l, mid);
		          mergeSort(nums, mid+1, r);  // 这里必须是和mid mid + 1 ； 而quick sort是可以跳过中间的，因为中间的是有序的
		          vector<int> tmp;
		          tmp.resize(nums.size()); // 比如resize初始化！！！
		          int l1 = l;
		          int r1 = mid+1;
		          int index = 0;
		          while(l1 <= mid && r1 <= r) {
		              tmp[index++] = nums[l1] <= nums[r1] ?  nums[l1++] : nums[r1++];
		          }
		          while(l1 <= mid) {
		              tmp[index++] = nums[l1++];
		          }
		          while(r1 <= r) {
		              tmp[index++] = nums[r1++];
		          }
		          for (int i = 0; i < r-l+1; ++i) {
		              nums[l+i] = tmp[i];
		          }
		      }
		  ```
-
- ((6403621a-c92a-4885-9aed-6826ee814fe3))
	- id:: 640363f0-d73c-4b7f-ac97-e8b7ca08a518
	  ```c
	  // 找边界，排序数组的上下标
	  int searchLeftOrRightBound(vector<int>& nums, int target, const string& bound) {
	          int left = 0, right = nums.size() - 1;
	          int res = -1;
	          while (left <= right) {
	              int mid = (left + right) >> 1;
	              if (nums[mid] < target) {
	                  left = mid + 1;
	              }
	              else if (nums[mid] > target) {
	                  right = mid - 1;
	              }
	              else {   // 边界问题没直接通过>比较过程取，单独处理
	                  res = mid;   // 关键
	                  if (bound == "left") {
	                      right = mid - 1;
	                  }
	                  else if (bound == "right") {
	                      left = mid + 1;
	                  }
	                  else {
	                      // 异常处理段
	                  }
	              }
	          }
	          return res;
	      }
	  ```