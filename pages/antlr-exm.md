- [b站 ustc](https://www.bilibili.com/video/BV1Df4y137zk/?spm_id_from=333.337.search-card.all.click)    [code](https://gitee.com/s4plus/antlr4-c1recognizer/tree/master)
- [b站 ideal-exam](https://www.bilibili.com/video/BV1hq4y1R7WZ/?spm_id_from=127.x.0.1&vd_source=249f61d30b660d344f2a5b626a2ac64f)
- inc:: calculator/sql/csv [github-calculator](https://github.com/xianfengyi/antlr-action/tree/master/antlr-calculator)
	- ```
	  /** 起始规则 语法分析器起点 */
	  	expr:	expr op=('*'|'/') expr  # MulDiv
	  	    |	expr op=('+'|'-') expr  # AddSub
	  	    |	number                  # num
	  	    |	'(' expr ')'            # parens     --> 1*(2+3)  括号内方法； visitParent return visit(ct.expr)
	  	    ;
	  ```
	- https://github.com/prestodb/presto/blob/master/presto-parser/src/main/antlr4/com/facebook/presto/sql/parser/SqlBase.g4   这里的sql的g4
- array:  json类型里的value https://blog.csdn.net/qq_37771475/article/details/106553162
-
