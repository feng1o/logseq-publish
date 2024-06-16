title:: query_example

- <ol> <li>参考<a href=https://clojuredocs.org/clojure.core/sort-by> clojure文档</a></li> </ol>
- query-table:: true
  query-sort-by:: block
  query-sort-desc:: true
  #+BEGIN_QUERY
  {:title [:h5.red.border "01. All todos with tag project"]
   :query [:find (pull ?b [*])
         :where
         [?p :block/name "double_point"]
         [?b :block/ref-pages ?p]]}
  :collapsed? true
  #+END_QUERY
- query-table:: false
  background-color:: #787f97
  collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.red.shadow.font-bold.border.opacity-40"02. 查询alg题目列表，按id顺序 asc desc"]
  :query (and "dalg" (not "tpl")) 
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id )  ) > result))
  :breadcrumb-show? false
  
  :collapsed?  true
  }
  #+END_QUERY
- query-table:: true
  collapsed:: true
  #+BEGIN_QUERY
   {:title  [:h5.red.border.shadow.underline.border "03.只查dalg标记，排序不准--不要点击block的排序"]
     :query (and (and "dalg" (not "tpl"))  (sort-by created-at desc))
    :collapsed? true
  }
  #+END_QUERY
- collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.red.weight.opacity-40.border"04. query (and BFS (and dalg (not  tpl)) )"]
  :query (and "BFS" (and "dalg" (not  "tpl")) )
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show? false
  :collapsed? true
  }
  #+END_QUERY
- <span class=red>05. #  {{query (or (and [[lt]] [[页面]] )  [[标记--参考computer list]]) }}</span>
- ```
  #+BEGIN_QUERY 
  {:query (or (and [[lt]] [[computer list]] )  [[toc]]) 
  :breadcrumb-show? false  --->是否不显示父目录
  :collapsed? false}
  #+END_QUERY
  ```
-
- collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h4.font-bold.blue.opacity-40:color.red"6. query (and BFS (and dalg (not  tpl)) )"]
  :query (and "回溯" (and "dalg" (not  "tpl")) )
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show?  false
  :collapsed? true
  }
  #+END_QUERY
- collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.font-bold.blue.opacity-40:color.red"7. query (and (or BFS  x) (and dalg (not  tpl)) )"]
  :query (and  (or "递归"  "二叉树") (and "dalg" (not  "tpl")) )
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show?  false
  :collapsed? true
  }
  #+END_QUERY
- collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.red.shadow.font-bold.border.opacity-40"02. 查询alg题目列表，按id顺序 asc desc"]
  :query (page-tags [[pp]])
  :breadcrumb-show? false
  :collapsed?  false
  }
  #+END_QUERY
- ```
  {{query (and (between -1w today)  "daily-done") }}
  ```