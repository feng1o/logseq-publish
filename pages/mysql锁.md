alias:: mysql锁

- 锁除了由 SQL 语句决定，也和当前会话的[[隔离级别]]息息相关。上文提到，[[可重复读]] （RR） [[隔离级别]]下 select* from t where id between 1 and 10 for update 会上临键锁，但是读已提交 （RC） [[隔离级别]]下，该 SQL 只会上[[记录锁]]
-
-
-
- 加index锁情况？ [加索引怎么避免锁表](https://blog.csdn.net/y666666y/article/details/115047352)<span class=" bg-green white  subw hblack hover"> [[2022-06-13 Mon]] </span>
	- [ 增加索引会锁表吗_Mysql“灵魂”连环13问，你get到了吗？](https://blog.csdn.net/weixin_39522698/article/details/110797185)
-
- [我总结的MySQL加锁规则](https://time.geekbang.org/column/article/75659)里面，包含了两个“原则”、两个“优化”和一个“bug”。 [[MySQL]] #interview
  id:: 640aff87-97ea-42c2-a0dc-a86c7f9dc056
	- 原则 1：加锁的基本单位是 [[next-key lock]]，next-key lock 是[[$red]]==前开后闭区间==
	- 原则 2：查找过程中访问到的对象才会加锁。
	- 优化 1：索引上的等值查询，给[[$red]]==唯一索引加锁的时候，next-key lock 退化为行锁==。  where id=1 for update，1如果存在就是行锁
	  id:: 640affaf-a60c-4006-bae3-8938133a7c18
	- 优化 2：索引上的等值查询，向右遍历时且最后一个值不满足等值条件的时候，next-key lock 退化为[[间隙锁]]。 where id=10 如不存在，比如有id=(2,8,11,23)，那就是(8-11)的间隙锁
	- 一个 bug：唯一索引上的范围查询会访问到不满足条件的第一个值为止。
		- [[非唯一索]]引查询，比如where not_uniq=10 for update； 10对应primary key=11，那会找到不满足的主键(x, 11],(11, x2）
- 锁的种类：
	- 粒度::  [[全局锁]]、[[表级锁]]([[表锁]]、 [[MDL]] )、[[行锁]]
	- 属性:: [[共享锁]]/[[读锁]]、[[排他锁]]
	- 范围:: [[间隙锁]] [[Gap Lock]] 、[[记录锁]]、[[临界锁]] [[next-key lock]] 、[[意向锁]]
-
- {{embed ((634c1664-27cd-474d-b201-a1157b940e34))}}
- [[间隙锁]]   &  [[next-key lock]] [[临界锁]] #interview
	- {{embed ((640afcea-e2ad-429c-ac95-70bcb4f94750))}}
-