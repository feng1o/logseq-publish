filters:: {"template" true}

- query-table:: false
  collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h4.font-bold.red.opacity-40"1. 查询alg题目列表，按id顺序 asc desc"]
  :query (and "dalg" (not "tpl")) 
  :result-transform (fn [result]
                          (sort-by (  fn [h]
                                    (get h :db/id 2) ) > result
                           ) )
  :breadcrumb-show? false
   :collapsed? true
  }
  #+END_QUERY
- query-table:: true
  query-sort-by:: block
  query-sort-desc:: false
  collapsed:: true
  #+BEGIN_QUERY
   {:title  [:h5.shadow.underline.border "2. 只查dalg标记，排序不准--不要点击block的排序"]
     :query (and (and "dalg" (not "tpl"))  (sort-by created-at desc))
     :collapsed? true
  }
  #+END_QUERY
- query-table:: true
  collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.font-bold.blue.opacity-40"3. query (and BFS (and dalg (not  tpl)) )"]
  :query (and "BFS" (and "dalg" (not  "tpl")) )
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show?  false
  :collapsed? true
  }
  #+END_QUERY
- collapsed:: true
  #+BEGIN_QUERY 
  {:title [:h5.font-bold.blue.opacity-40"4. query (and hot100 (and dalg (not  tpl)) )"]
  :query (and "hot100" (and "dalg" (not  "tpl")) )
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show?  false
  :collapsed? true
  }
  #+END_QUERY