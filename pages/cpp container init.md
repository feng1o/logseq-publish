- #### map
	- ```cpp
	   std::unordered_map<int, std::string> m =
	      {
	          {1, "one"},   std::pair<int, std::string> (1, "one"),  std::make_pair(1, "one"),
	          {2, "two"}    std::pair<int, std::string> (2, "two"),
	      };
	   
	   m.insert(pair<int, string>(1, "one"))    m.insert(make_pair(1, "one"))
	   
	   m.erase(m.begin() + 1);  m.erase(2);
	      
	    pair<string, double> PAIR2("GeeksForGeeks", 1.23);
	    pair<string, double> PAIR3;
	    
	    PAIR1.first = 100;
	    PAIR1.second = 'G';
	  
	    PAIR3 = make_pair("GeeksForGeeks is Best", 4.56);
	  
	  ```
	- [自定义hasher方法](https://leetcode.cn/problems/group-anagrams/solution/zi-mu-yi-wei-ci-fen-zu-by-leetcode-solut-gyoc/)
	  id:: 64129ba8-ac39-427d-953b-b8352cb9029b
		- ```cpp
		  // 简单但低效的哈希
		  struct Hasher{
		      int operator()(const vector<int> &arr) const{
		          if(arr.size() == 0)
		              return -1;
		          int result = 0;
		          for(const int &num : arr)
		              result += num;
		          return result;
		      }
		  };
		  
		  // 官方相对高效的哈希
		  int hasher(const vector<int> &arr){
		      int hash_index = 0;
		      for(const int &num : arr)
		          hash_index = (hash_index << 1) ^ num;
		      return hash_index;
		  }
		  
		  class Solution {
		  public:
		      vector<vector<string>> groupAnagrams(vector<string>& strs) {
		          int n = strs.size();
		          vector<vector<string>> result;
		          unordered_map<vector<int>, int, int (*)(const vector<int>&)> m2i(0, hasher);    // 函数指针类型int (*)(const vector<int>&)
		          for(string &str : strs){
		              vector<int> count(26, 0);
		              for(char &ch : str)
		                  ++count[ch - 'a'];
		              if(m2i.count(count) == 0){
		                  result.emplace_back(initializer_list<string>{});
		                  int index = result.size() - 1;
		                  result[index].push_back(str);
		                  m2i[count] = index;
		              }
		              else
		                  result[m2i[count]].push_back(str);
		          }
		          return result;
		      }
		  };
		  ```
- #### string
	- ```
	  substr(0, len)   pop_back() push_back() find()
	  ```
-