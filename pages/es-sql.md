- summary
  id:: 623950d3-cd2d-44f9-94f4-1038a415584d
	- ((623950e6-94b3-487b-9695-7f915e96365f))
	- ((639c213a-b2b5-452f-85a6-38a5920c1a3c))
	-
- query_string 分词后查询
  id:: 623950e6-94b3-487b-9695-7f915e96365f
	- [query_string语法](https://blog.51cto.com/u_15316394/3215826)
	- ```
	  res=$(curl -XPOST -d @- "$1:$2/$3*/_search" <<EOF 
	   {
	     "docvalue_fields": [ "timestamp", "sql.keyword", "business", "region", "db"],
	    "query": {
	          "bool": {
	              "filter": [
	                {"range": {
	                   "timestamp": {
	                  "gte":"2021-07-03T11:08:00.000+08:00",
	                  "lt":"2021-07-26T11:09:00.000+08:00",
	                  "format": "strict_date_optional_time",
	                  "time_zone": "+08:00"
	              }
	            }
	              },{
	                  "query_string": {
	                      "query": "(type:S) ANd (sql:select) "
	                  }
	              }]
	          }
	      }
	  }
	  EOF
	  );
	   echo $res | python -m json.tool
	  ```
- id:: 639c213a-b2b5-452f-85a6-38a5920c1a3c
  match:: 分词后查询，match_phrase 包含all分词，且连续的，顺序不可变，query_string就可以变顺序
  term:: 精确匹配
	- text字段会分词，而term不分词，所以term查询的条件必须是text字段分词后的某一个，如果多个是查询不出来的，分词后就是a,b
	  id:: 639c2684-8408-4a1e-af09-bf62296da9af
	- match查询keyword的，keyword部分词，match里必须包含all的keyword值才能匹配到；match查询text就分词匹配
	  id:: 639c2692-e1fa-45a6-aa09-79977429df42
	- ```
	  "query": {
	      "term": {
	        "sql.keyword": "SELECT @@session.tx_read_only"  # sql是text会报错，无index无法查询，必须把字段mapping设为keyword
	      }
	    }
	    
	  # 用多个结合匹配出text中的精确语句
	  {
	    "profile": false,
	    "docvalue_fields": [ "timestamp", "sql.keyword", "business", "region", "db"],
	    "query": {
	          "bool": {
	              "filter": [
	                {"range": {
	                   "timestamp": {
	                  "gte":"2022-12-14T11:15:00.000+08:00",
	                  "lt":"2022-12-14T11:22:00.000+08:00",
	                  "format": "strict_date_optional_time",
	                  "time_zone": "+08:00"
	              }
	            }
	              },{
	                  "query_string": {
	                      "fields": ["sql", "sqlType"],
	                      "query": "(SELECT 1) AND SELECT "
	                  }
	              },
	              {
	              "match_phrase": {"sql": "SELECT 1"} # 选择出select 1
	              }
	          ]
	          }
	      }
	  }
	  ```
	- [text中的匹配，match x.keyword或term & terms](https://www.cnblogs.com/musecho/p/15354576.html)