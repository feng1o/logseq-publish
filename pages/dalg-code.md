- ((64034178-53c8-42e1-b032-0f6891062c4e))
	- id:: 64004daa-40d8-4cc9-9b6b-88122497c40b
	  ```cpp
	      void mark(vector<vector<char>> &grid, int r, int c, vector<vector<bool>> &visited) {
	          if ( r< 0 || c < 0 || r>grid.size()-1 || c>grid[0].size()-1 || visited[r][c] || grid[r][c] != '1') return;
	          visited[r][c] = true;
	  
	          /*mark(grid, r+1, c, visited);
	          mark(grid, r-1, c, visited);
	          mark(grid, r, c+1, visited);
	          mark(grid, r, c-1, visited);
	           */
	          if (r+1 < grid.size() ) mark(grid, r+1, c, visited);
	          if(r-1>=0 ) mark(grid, r-1, c,  visited);
	          if(c+1 < grid[0].size() ) mark(grid, r, c+1, visited);
	          if(c-1>=0 ) mark(grid, r, c-1, visited);
	  
	          if (r+1 < grid.size() && !visited[r+1][c]) mark(grid, r+1, c, visited);
	          if(r-1>=0 && !visited[r-1][c]) mark(grid, r-1, c,  visited);
	          if(c+1 < grid[0].size() && !visited[r][c+1]) mark(grid, r, c+1, visited);
	          if(c-1>=0 && !visited[r][c-1]) mark(grid, r, c-1, visited);
	      }
	      void dfs(vector<vector<char>> &grid, int r, int c, int &res, vector<vector<bool>> &visited) {
	          if (grid[r][c] == '1' && !visited[r][c] ) {
	              mark(grid, r, c, visited);
	              res++;
	          }
	          if (r+1 < grid.size() ) dfs(grid, r+1, c, res, visited);
	          if(r-1>=0 ) dfs(grid, r-1, c, res, visited);
	          if(c+1 < grid[0].size() ) dfs(grid, r, c+1, res, visited);
	          if(c-1>=0 ) dfs(grid, r, c-1, res, visited);
	      }
	  
	      int numIslands(vector<vector<char>>& grid) {
	          if (grid.size() == 0) {
	              return 0;
	          }
	  
	          int res = 0;
	          vector<vector<bool>> visited(grid.size(), vector<bool>(grid[0].size(), false));
	          //dfs(grid, 0, 0, res, visited);
	          for (int i = 0; i < grid.size(); ++i) {
	              for (int j = 0; j < grid[0].size(); ++j) {
	                  if (grid[i][j] == '1' && !visited[i][j]) {
	                      ++res;
	                      mark(grid, i, j , visited);
	                  }
	              }
	          }
	          return res;
	      }
	  ```