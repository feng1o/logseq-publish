- <mark class="vim-shortcuts-highlight"></mark>ANTLR生成该语言的语法分析器。生成的语法分析器可以自动构建语法分析树——表示文法如何匹配输入的数据结构。ANTLR还可以自动生成树遍历器，你可以用它来访问那些树的节点，以执行特定的代码
- ![ANTLR 4权威指南.pdf](../assets/ANTLR_4权威指南_1668407377609_0.pdf) [[hls__ANTLR_4权威指南_1668407377609_0]]
- [antlr-doc.link](https://wizardforcel.gitbooks.io/antlr4-short-course/content/introduction.html)  - [antlr-grammars-v4例子全](https://github.com/antlr/grammars-v4)
- tools 、env
	- ```
	  curl -O https://www.antlr.org/download/antlr-4.7.1-complete.jar
	  java -jar antlr-4.7.1-complete.jar  # 启动org.antlr.v4.Tool  
	  
	  java -cp antlr-4.7.1-complete.jar org.antlr.v4.Tool $*   # xx.g生成识别器 antlr.sh  到这done //sh antlr.sh -visitor SimpleExpr.g4
	  
	  javac -cp antlr-4.7.1-complete.jar $*  #xx*.java 可执行的识别器 compile.sh
	  java -cp .:$PWD/antlr-4.7.1-complete.jar org.antlr.v4.gui.TestRig $*  #测试生成的识别器 grun.sh
	  
	  sh antlr.sh test.g1  # 这里应该加 -visior or -listener 否则返回null
	  sh antlr_compile.sh test*.java
	  sh antlr_grun.sh test s -tokens
	  ```
	- idea:: install antlr4 plugin, write antlr4 BNF g4 and generator antlr4 recoginizer
	  通过tools configure antlr4 for xxx.g4 控制gen的文件位置
-
- 概念
	- 识别语言的程序被称为[[语法分析器]]，语法指代控制语言成员的规则，每条规则都表示一个短语的结构，文法就是一组规则。为了更容易地实现识别语言的程序，通常我们会把语法分析过程拆解成两个相似但不同的任务或阶段
	- 把字符组成单词或符号（记号）的过程被称为[[词法分析]]或简单标记化，能把相关的记号组成记号类型，如INT FLOAT ID标记
	- [[语法分析器]] 生成[[语法分析树]]，语法分析器给应用的其余部分提供了方便的数据结构，含有关于语法分析器如何把符号组成短语的完整信息
- [[BNF范式]]
- [[antlr-exm]]
- [生成array数组的](https://stackoverflow.com/questions/49586618/antlr4-array-implementation-getting-values-of-elements)
- [解析数组-加法器-翻译器例子](https://0x100.club/projects/antlr-example.html)
- [[antlr-tips]]