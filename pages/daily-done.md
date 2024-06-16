query-table:: false
#+BEGIN_QUERY
{:title "Journal blocks in last 7 days with a page reference of daily-done"
 :query [:find (pull ?b [*])
         :in $ ?start ?today ?tag
         :where
         (between ?b  ?start  ?today)
         (page-ref ?b  ?tag)
] :inputs [:-7d :today "daily-done"]}
#+END_QUERY
