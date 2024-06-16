- 大纲
	- 审计系统背景
		- 审计意义，用户，saas服务需求，完善数据库产品能力
	- 规则审计需求分析
		- 现状是直接上报，全审计(计费，存储，用户量和成本)
		- 规则审计:: 直接plugin完成，性能扩展差
	- 规则审计方案 [iwiki文档](https://LWlrLXdhLWNtLQo=/pages/viewpage.action?pageId=152442154)
	- 挑战点
	-
- [[规则审计]]
- [[ANTLR-语法分析器生成器]] [[compiler]]
	- 理解:: 看几种parser比较， [see](https://www.cnblogs.com/jiahu-Blog/p/12908448.html)
	  listener是自动调用，但是没返回值的，visitor需要显示调用
	- ```
	  ANTLR工具依据类似于之前的assign语法规则，产生一个递归下降语法分析器(recursive-descent parser)。递归下降的语法分析器实际上是若干递归方法的集合，每个方法对应一条规则。下降的过程就是从语法分析树的根节点开始，朝着叶节点(词法符号)进行解析的过程。首先调用的规则，即语义符号的起始点，就会称为语法分析树的根节点。这种解析的别名是自上而下的解析，递归下降的语法分析器仅仅是自上而下的语法分析器的一种实现。  < antlr 权威指南 第一张的>
	  ```
	- ![image.png](../assets/image_1676130943122_0.png)
		- ### 监听器（Listener）与访问者（Visitor）
		  
		  	在ANTLR
		  4以前，有两种开发方式：一是将目标语言的代码直接硬编码到语法定义文件中，在生成分析器时会插入这些代码到生成文件中，这也是大多数语法分析器生成工具的做法。在上边的语法判定与通道的例子中，就有将Java代码硬编码到语法定义的情况。将目标代码和语法定义耦合在了一起，当需要生成不同目标语言的分析器时，就需要维护多份语法定义文件，增加了维护成本，同时在编写复杂逻辑时，由于IDE没有对目标语言的支持，开发和测试都很幸苦。另一种方式是让ANTLR生成语法分析树，然后写程序遍历语法树，对语法树的遍历是一个很复杂的工作。
		  
		  	ANTLR 
		  4开始会生成监听器（Listener）与访问者（Visitor），将语法定义与目标代码完全的解耦。监听器可以被动的接受语法分析树遍历的事件，对于每一个语法节点，都会生成进入enterSomeNodeName与退出exitSomeNodeName两个方法。访问者机制生成对语法节点的访问方法visitSomeNodeName，在访问方法中需要手动调用visit方法来对子节点进行遍历，使用访问者模式可以控制语法树的遍历，略过某些的分枝。ANTLR默认只生成监听器，生成访问者类需要在生成时添加-visitor选项。
	- ```
	  ANTLR（ANother Tool for Language Recognition）是一个强大的解析器生成器，用于读取、处理、执行或翻译结构化文本或二进制文件。 它被广泛用于构建语言、工具和框架。ANTLR 根据语法定义生成解析器，解析器可以构建和遍历解析树。
	  所有编程语言的语法，都可以用ANTLR来定义。ANTLR提供了大量的官方 grammar 示例，包含了各种常见语言，比如Java、SQL、Javascript、PHP等等。
	  主要用户
	  
	  Twitter搜索使用ANTLR进行语法分析，每天处理超过20亿次查询；
	  Hadoop生态系统中的Hive、Pig、数据仓库和分析系统所使用的语言都用到了ANTLR；
	  Lex Machina将ANTLR用于分析法律文本；Oracle公司在SQL开发者IDE和迁移工具中使用了ANTLR；
	  NetBeans公司的IDE使用ANTLR来解析C++；
	  Hibernate对象-关系映射框架（ORM）使用ANTLR来处理HQL语言
	  其他还有Oracle、Presto、Elasticsearch、Spark
	  
	  ```
	- 因为平时的开发工作中需要做语法分析的情况很少，所以知道ANTLR的人并不多。但我们今天用到的很多流行的应用和开源项目里边都有它的影子。Twitter使用ANTLR来解析其搜索服务的查询语句，每天处理超过20亿次查询。Java领域最流行的ORM框架Hibernate使用它将HQL翻译成SQL。Hadoop、Hive以及Pig都使用ANTLR来做语法分析
	- https://blog.beanbang.cn/2020/10/21/antlr-v4-note/  antlr的描述性概念  ANTLR 的监听器和访问器能够将语法和程序逻辑代码解耦，可以不需要在语法中内嵌动作。
		- ```
		  使用访问器和监听器机制，我们可以完成一切与语法相关的事情。一旦进入Java的领域，就没有什么ANTLR的相关内容值得学习了。我们需要谨记在心的是，语法及其对应的语法分析树，以及访问器或者监听器事件方法之间的关系。除此之外，剩下的仅仅是普通的代码。在对输入文本进行识别时，我们可以产生输出、收集信息（正如本例中我们所做的）、用某种方式验证输入文本，或者执行计算。
		  ```
		- ```
		  经典的从左到右自顶向下的语法分析器无法处理左递归。算符优先级带来的问题。ANTLR解决的方式是，写在前面的语法拥有较高的优先级。如果遇到了从右向左结合的，需要使用 assoc 手工指定结合性：
		  expr : <assoc=right> expr '^' expr
		  ```
		- <span> <a class=ask>  传统的**LL**语法分析器一般是无法处理左递归的</a>  <span class=" bg-green white  subw hblack hover"> [[2022-09-08 Thu]] </span></span>
	- 语法解析相关的LL(自顶向下)  LR的区别、流派之间的关系:: 需要理解，知道大致概念
		- 解释:
			- **LR**是自低向上（bottom-up）的语法分析方法，其中的**L**表示分析器从左（**L**eft）至右单向读取每行文本，**R**表示最右派生（**R**ightmost derivation），可以生成**LR**语法分析器的工具有YACC、Bison等，它们生成的是增强版的**LR**，叫做**LALR**。
			- **LL**是自顶向下（top-down）的语法分析方法，其中的第一个**L**表示分析器从左（**L**eft）至右单向读取每行文本，第二个**L**表示最左派生（**L**eftmost derivation），ANTLR生成的就是**LL**分析器。
			- 两类分析器各有其优势，适用不同的场景，很难说谁要更好一些。普遍的说法是**LR**可以解析的语法形式更多，**LL**的语法定义更简单易懂。
		- 递归下降的语法分析器仅仅是自上而下的语法分析器的一种实现
		- https://toutiao.io/posts/sh94p8/preview ---- ***** 比较重要的概述性内容较多
	-
- [waf门神的语义检测识别攻击antlr使用](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=b46ba4c2eb2e4ebbab7a5e1e078ee470)
	- 1:: 分析难点，为什么引入antlr解决了什么
	- 2::
- [性能优化写法 mileshe](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=0ade655b0a9f4ef284ca5274d06cb833)
- [ppt 5g核心网-挑战点分解oritlenlu](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=599b7d232f3c42b2927e51400db8f010)  -- load
-
- Tip:: 看t10，
	- [边缘计算网络安全加速 t10 weipengsun](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=44955c0df1d74f73ad1c4074cb3d044d) -- load 2023-ppt dir
	- [qq相册自研上云 witpeng ---  ppt格式good](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=4ad6c6364ada43d1a272fe400035c250)  -- load
	- [linux的系统io介绍ppt  lennychen](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=0413528a70ea4b558a43a2529ad40760)  - load
	- [广告推荐系统平台优化-ppt写法不错=内容无  mileshe](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=050586bf5fa045a294ee3963f85a2ffe)   - load
	-
	-
	-
- tip:: 看t11
	- [ppt格式-风格-雾计算---  eckoqzhang](https://profession.LW9hLWNtLQo=/blank-main/reply_reply-backend/reply-detail-page?id=ff3f217b594f4fc8a16a010a8b539528)  - load
-
- 微软雅黑:
	- 12号:
-
- last:
	- https://bbs.huaweicloud.com/blogs/308539  antlr4的详细过程
	- 词法 文法 语法 ---- 差异？  https://www.zhihu.com/column/c_142258822    https://zhuanlan.zhihu.com/p/31224910
		- ###### 文法的概念
		  
		  
		  每一种自然语言或者是编程语言都需要文法来描述，文法相当于语言学的[语义分析](https://so.csdn.net/so/search?q=%E8%AF%AD%E4%B9%89%E5%88%86%E6%9E%90&spm=1001.2101.3001.7020)，即分析每一句话所表示的含义，编译器需要利用文法来完成其语法分析和语义分析 https://blog.csdn.net/abc123lzf/article/details/103773591
-
-