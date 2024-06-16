- query-table:: false
  #+BEGIN_QUERY 
  {:title [:h5.red.weight.opacity-40.border"04. query (and BFS (and dalg (not  tpl)) )"]
  :query (and "BFS" (and "dalg" (not  "tpl")) )
  :result-transform (fn [result]
                          (sort-by(  fn [h]
                                    (get h :db/id 1)  ) > result))
  :breadcrumb-show? false
  :collapsed? false
  }
  #+END_QUERY
-
- <html><a  class="alg-easy"       href=
  https://leetcode-cn.com/problems/cong-shang-dao-xia-da-yin-er-cha-shu-ii-lcof/><span class="width-55-hide bg-lightgray-del">
  102.binary tree level order traveral<span class="hide">dalg</span>
  <span class="gray subw8">
  BFS按层</span></span></a>  <a 
  class="indent1  subw8 blue    width-13-hide                                        " >BFS</a><a 
  class="indent1 subw8 gray    width-18-hide  underline  DarkOrchid  " >.</a><a 
  class="indent1 subw gray     width-3-hide  underline  red                  " >1</a>
  </html>
-