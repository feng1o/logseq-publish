- [[Mar 20th, 2022]] 
  ```css
  :default-queries
   {:journals
    [{:title "🔨 𝐍𝐎𝐖"
      :query [:find (pull ?h [*])
              ;;:in $ ?start ?today
              :where
              [?h :block/marker ?marker]
              [(contains? #{"NOW" "DOING"} ?marker)] ;;任务标记关键词 补了一个]
              [?h :block/ref-pages ?p]
              ]
              ;;[?h :block/page ?p]  ;;把这些条件都去掉了
              ;;[?p :block/journal? true]
              ;;[?p :block/journal-day ?d]
             ;; [(>= ?d ?start)]
             ;; [(<= ?d ?today)]]
     ;; :inputs [:30d :today]
     :result-transform (fn [result]
                          (sort-by (fn [h]
                                    (get h :block/priority "Z")) result))
      :collapsed? false}
     
     {:title "📅 𝐍𝐄𝐗𝐓"
      :query [:find (pull ?h [*])
              :in $ ?start ?next
              :where
              [?h :block/marker ?marker]
              [(contains? #{"LATER" "TODO"} ?marker)]
              [(missing? $ ?h  :block/scheduled)]  ;;排除标记了Sheduled的任务  加的
              [(missing? $ ?h  :block/deadline)]]  ;;排除标记了Deadline的任务  加的
             ;;[?h :block/ref-pages ?p]
             ;; [?p :block/journal? true]
             ;; [?p :block/journal-day ?d] ;; 变量d是来自这个，必须是journal才有d变量
             ;;[(> ?d ?start)]
             ;;[(< ?d ?next)]]
      :inputs [:today :100d-after]
      :collapsed? true}
     
     {:title "🚀 𝐂𝐥𝐨𝐬𝐞 𝐓𝐨 𝐃𝐞𝐚𝐝𝐥𝐢𝐧𝐞"
      :query [:find (pull ?b [*])
      :in $ ?start ?next
      :where
      [?b :block/deadline ?d]  ;;任务标记了deadline 
      [?b :block/marker ?marker]
      (not [?b :block/priority])  
      [(> ?d ?start)]
      [(< ?d ?next)]
      [(contains? #{"NOW" "LATER" "DOING" "TODO"} ?marker)]]  ;;任务标记关键词
      :inputs [:today :15d-after]   ;;检索未来7天的DeadLine
      :collapsed? true
      :breadcrumb-show? true}   ;;检索结果是否显示面包屑路径
     
     
     {:title "💊 𝐎𝐯𝐞𝐫 𝐃𝐞𝐚𝐝𝐥𝐢𝐧𝐞"
      :query [:find (pull ?b [*])
      :in $ ?start
      :where
      [?b :block/deadline ?d]
      [?b :block/marker ?marker]
      (not [?b :block/priority])    
      [(< ?d ?start)]
      [(contains? #{"NOW" "LATER" "DOING" "TODO"} ?marker)]]
      :inputs [:today]}
     
    ]}
  
  
  新增如下：解决code代码换行后选择切分默认到第一行的问题，
  :editor/extra-codemirror-options 
    { :lineWrapping true }
  
  ```
-
- custom.css
  ```css
  html {
    background-color: #00539F;
  } 
  
  main, header, nav, article, aside, footer, section {
      background-color: rgba(29, 149, 63, 0.5);
      padding: 1%;
  }
  
  h1,h2 {
    margin: 0;
    padding: 20px 0;
    color: #00539F;
    text-shadow: 1px 1px 1px #00539F;
  }
  
  /*2. 页面会有边框
  body {
    width: auto;
    margin: 1px  1px  1px  238px;
    background-color: #FF9500;
    padding: 5px 10px 10px 10px;
    border: 3px solid black;
  }
  */
  
  a[href="x"] { 
      font-weight: bold;
      /*text-decoration:underline;*/
  }  
  
  /*3.字体控制*/
  .subw {
      font-size: 70%;
      vertical-align: inline;
  }
  .underline {
      text-decoration:underline;
  }
  
  .gray {
      color: gray;
  }
  
  .red {
      color: red;
  }
  
  .blue {
      color: blue;
  }
  
  .weight {
      font-weight: bold;
  }
  
  /*4.伪元素,前后缀*/
  .coffee::after { 
      text-decoration:underline;
      content:"🥤";
  }   
  
  .perfect::after { 
      text-decoration:underline;
      content:"💯";
  }   
  
  .alg_1stars::after {
      content:"_※";
      text-decoration:underline;
      vertical-align: sub;
      color: red;
      /*background-color: yellow;*/
  }
  
  .alg_2stars::after {
      content:"_※※";
      text-decoration:underline;
      vertical-align: sub;
      color: red;
      /*background-color: yellow;*/
  }
  
  
  .alg_3stars::after {
      content:"_※※※";
      text-decoration:underline;
      vertical-align: sub;
      color: red;
      /*background-color: yellow;*/
  }
  
  .alg_easy::after {
      content:"_Easy";
      text-decoration:underline;
      vertical-align: sub;
      color: #2CB197;
  }
  
  .alg_medium::after {
      content:"_Medium";
      text-decoration:underline;
      vertical-align: sub;
      color: #F0A431;
  }
  
  .alg_hard::after {
      content:"_Hard";
      text-decoration:underline;
      vertical-align: sub;
      color: red;
  }
  
  .mediam::after {
      text-decoration:underline;
      content:"_*";
  }
  
  a.apple::after { 
      text-decoration:underline;
      content:"🍎";
  }   
  
  /*5.伪类*/
  a:hover {
      color:red;
  }
  
  /*6.block 内联盒子*/
  .inline_box {
      display: inline-flex;
  }
  /* -----------------------------------------toc list ----------------------start -----------*/
  ```
- custom.css [[2022-08-26 Fri]]  添加了子弹头bullet的配置调整
- ```shell
  :root{
     /*--ct-code-font-family: "Fira Code", Monaco, Menlo, Consolas, "COURIER NEW",
       monospace; */  /*字体暂时不改*/
     --ct-inline-code-font-size: 0.65em;
     --ct-inline-code-font-style: inherit;
   }
   
   /*代码块字体大小*/
  .code-editor * { 
       font-size: 95%;                                                                                                                                    
   }
  
  html {
    background-color: #00539F;
  } 
  
  main, header, nav, article, aside, footer, section {
      background-color: rgba(29, 149, 63, 0.5);
      padding: 1%;
  }
  
  /*影藏query 语句的head ttps://discuss.logseq.com/t/hide-query-table-property-heading/4296 */
  /*:collapsed? true这类消失， 不开启*/
  div:not(#today-queries) > div.custom-query > div > div.content, div:not(#today-queries) > div.custom-query > div > div.initial > div > div.flex {
    /*display: none */
  }
  
  .hide-query {
    div:not(#today-queries) > div.custom-query > div > div.content, div:not(#today-queries) > div.custom-query > div > div.initial > div > div.flex {
    display: none
  }
  }
  
  h1,h2 {
    margin: 0;
    padding: 20px 0;
    color: #00539F;
    text-shadow: 1px 1px 1px #00539F;
  }
  
  /*2. 页面会有边框
  body {
    width: auto;
    margin: 1px  1px  1px  238px;
    background-color: #FF9500;
    padding: 5px 10px 10px 10px;
    border: 3px solid black;
  }
  */
  
  .bd-blue {
      border: 1px solid blue;
  }
  
  a[href="x"] { 
      font-weight: bold;
      /*text-decoration:underline;*/
  }  
  
  /*3.字体控制*/
  .indent1 {
      text-indent: 1em;
  }
  .subw {
      font-size: 70%;
      vertical-align: middle;
      vertical-align: inline;
  }
  
  .subw8 {
      font-size: 80%;
      vertical-align: middle;
  }
  
  .subw9 {
      font-size: 90%;
      vertical-align: middle;
  }
  
  .underline {
      text-decoration:underline;
  }
  
  .hide {
      /*display:block;
      overflow:hidden;
      width:0;
      height:0;*/
      display:none;
  }
  .gray {
      color: gray;
  }
  
  .DarkOrchid  {
      color: #9932CC;
  }
  
  .white {
      color: white;
  }
  
  .red {
      color: red;
  }
  
  .blue {
      color: blue;
  }
  .bg-yellow {
      background-color: yellow;
  }
  
  .bg-green {
      background-color: rgba(29, 149, 63, 0.5);
      background-color: green;
  }
  
  .weight {
      font-weight: bold;
  }
  
  .width-3-hide {
      width:3em;
      overflow:hidden;
      /*border: 1px solid blue; */
      text-overflow:ellipsis;
      white-space:nowrap;
      display: inline-block;
  }
  
  /* vertical-align: sub; 会导致行距变大*/
  .width-18-hide {
      width:15%;
      overflow:hidden;
      white-space:nowrap;
      /*border: 1px solid blue; */
      text-overflow:ellipsis;
      display: inline-block;
  }
  
  .width-13-hide {
      width:13%;
      /*border: 1px solid blue; */
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
      display: inline-block;
  }
  
  .width-55-hide {
      width:55%;
      /*border: 1px solid green;*/ 
      overflow:hidden;
      white-space:nowrap;
      text-overflow:ellipsis;
      display: inline-flex;
  }
  
  
  .line2-hide {
      width:50%;
      /*border: 1px solid green;*/ 
      overflow : hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      /* autoprefixer: off */
      -webkit-box-orient: vertical;
      /* autoprefixer: on */
  }
  
  /*4.伪元素,前后缀*/
  .coffee::after { 
      text-decoration:underline;
      width: 4em;
      content:"🥤";
  }   
  
  .ask::after { 
      text-decoration:underline;
      width: 4em;
      content: "❓";
  }   
  
  .perfect::after { 
      text-decoration:underline;
      width: 4em;
      content:"💯";
  }   
  
  .alg-1stars::after {
      content:" ❶ ";
      text-decoration:underline;
      vertical-align: inline;
      letter-spacing: 0.202em;
      color: green;
      /*background-color: yellow;*/
  }
  
  .alg-1stars::after {
      content:" ❶ ";
      text-decoration:underline;
      vertical-align: inline;
      letter-spacing: 0.202em;
      color: green;
      /*background-color: yellow;*/
  }
  
  .alg-2stars::after {
      content:" ❷ ";
      text-decoration:underline;
      vertical-align: inline;
      color: #1E90FF;
      letter-spacing: 0.202em;
      /*background-color: yellow;*/
  }
  
  
  .alg-3stars::after {
      letter-spacing: normal;
      content:" ❸ ";
      text-decoration:underline;
      vertical-align: inline;
      letter-spacing: 0.202em;
      /*vertical-align: sub;*/
      color: #FF1493;
      /*background-color: yellow;*/
  }
  
  .alg-4stars::after {
      letter-spacing: normal;
      content:" ❹ ";
      text-decoration:underline;
      vertical-align: inline;
      /*保持和alg after效果一致，不可gai*/
      letter-spacing: 0.202em;
      /*vertical-align: sub;*/
      color: red;
      /*background-color: yellow;*/
  }
  
  
  .alg-easy::after {
      content:"_Easy";
      text-decoration:underline;
      vertical-align: inline;
      letter-spacing: 0.016em;
      font-size:80%;
      color: #2CB197;
  }
  
  .alg-medium::after {
      content:"_Medi";
      text-decoration:underline;
      vertical-align: inline;
      letter-spacing: 0.0001em;
      font-size:80%;
      color: #F0A431;
  }
  
  .alg-hard::after {
      content:"_Hard";
      text-decoration:underline;
      vertical-align: inline;
      letter-spacing: 0.0001em;
      font-size:80%;
      color: red;
  }
  
  .mediam::after {
      text-decoration:underline;
      content:"_*   ";
  }
  
  .apple::after { 
      text-decoration:underline;
      content:"🍎";
  }   
  
  /*5.伪类*/
  a:hover {
      color:red;
  }
  
  /* class是hblack的且hover类后状态*/
  .hblack:hover {
      background-color: yellow;
      color:black;
  }
  
  /*6.block 内联盒子*/
  .inline_box {
      display: inline-flex;
  }
  
  .inline-box {
      display: inline-flex;
  }
  
  .inline-blk {
      display: inline-block;
  }
  
  .inblock {
      margin: 10px;
      padding: 1px;
      /*width: 60px;
      height: 50px;*/
      background-color: lightgreen;
      border: 2px solid blue;
      display: inline-block;
  } 
  
  /*7.继承与控制*/
  .clear {
      all: unset;
  }
  /*8.背景颜色*/
  .bg-lightgray {
      background-color: lightgray;
  }
  /* -----------------------------------------toc list ----------------------start -----------*/
  
  /*=========================bullet start==========================*/     
  /*= highlight current path by cannnibalox v20210220 =*/ 
  /* https://discuss.logseq.com/t/css-highlights-current-path-bullets-color/371 */
  
  
  /* !important 否则会导致插件bulletshit覆盖这个效果 */
  .ls-block .bullet{
      background-color:#dd0707!important; /* hover后的颜色red */
    	color: red;
  }
  
  /*====== option: (:hover) to (:focus-whithin)高亮选择路径的bullets =======*/
  /* 默认的bullet的颜色,not hover */
  .ls-block:not(:hover) .bullet{
      background-color:var(--ls-block-bullet-color);
      background-color: lightgray!important;
      /*background-color: blue;*/
  }
  
  /* 高亮path */
  .block-children{border-left-color:#037ef3!important;}
  .block-children .block-children{border-left-color:#00c16e!important;}
  .block-children .block-children .block-children{border-left-color:#0cb9c1!important;}
  .block-children .block-children .block-children .block-children{border-left-color:#f48924!important;}
  .block-children .block-children .block-children .block-children .block-children{border-left-color:#f85a40!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#ffc845!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#52565e!important;}
  
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#037ef3!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#00c16e!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#0cb9c1!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#f48924!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#f85a40!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#ffc845!important;}
  .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children .block-children{border-left-color:#52565e!important;}
  
  .ls-block > .block-children:focus-within {
      border-left-width: 2px;
      margin-left: 20px!important;
      border-left-color:#6a3be4!important;
  }
  
  /* first-child规避第一列头部有个_,打开后有些又没有_*/
  /*  这个暂未生效, 对齐长度有问题*/ 
  /*.blocks-container div:not(:first-child) .ls-block:focus-within::before{ */
  .blocks-container > div:not(:first-child) .ls-block:focus-within::before{
      content: "";
      display: inline-block;
      left: -2px;
      top: 13px;
      width: 20px;
      position: absolute;
      height: 0;
      border-bottom: 2px solid #6a3be4;
      z-index: 1;
  }
  .blocks-container > div:not(:first-child) .ls-block>.flex-row{
    	position:relative;
    	z-index:10;
  }
  /*=========================bullet end==========================*/
  
  /* toc gen 加的配置 kef-tocgen-page 对应页面，kef-tocgen-block 对应块，.kef-tocgen-active-block 对应编辑中的块 */
  .kef-tocgen-page {
    cursor: pointer;
    /*background-color: #DCDCDC;*/
    line-height: 1.6;
    /*border: 1px dashed gray;*/
  }
  .kef-tocgen-block {
    line-height: 1.4;
    font-size: 75%;
    text-decoration:underline;
    color: #0000FF;
  }
  .kef-tocgen-active-block {
    font-size: 1.1em;
    font-weight: 600;
    color: #0001FF;
  }
  /* 无活动页面的时候显示的  比如选中日志*/
  .kef-tocgen-noactivepage::before {
    content: "🫥";
  }
  /* toc gen end */
  ```
-