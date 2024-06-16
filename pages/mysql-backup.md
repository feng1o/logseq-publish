related:: [[MySQL]]

- TODO [[mysql]]的备份原理 >[2023-11-13 - 2023-11-17](#agenda://?start=1699847501652&end=1700193101652)
  id:: 66671509-df8d-4d7b-b14f-2fc670899d7a
	- [[FTWRL]]的逻辑冷备如何做到不影响业务的？ 会阻塞DDL DML吗?
- [[FTWRL]]  全局逻辑备份 flush table with read lock
	- FTWRL 前有读写的话 ,FTWRL 都会等待 读写执行完毕后才执行
	  FTWRL 执行的时候要刷脏页的数据到磁盘,因为要保持数据的一致性 ，理解的执行FTWRL时候是 所有事务 都提交完毕的时候
	- [[mysqldump]] + -single-transaction 也是保证事务的一致性,但他只针对 有支持事务 引擎,比如 innodb
	  所以 还是强烈建议大家在创建实例,表时候需要innodb 引擎 为好
	  全库只读  readonly = true 还有个情况在 slave 上 如果用户有超级权限的话  readonly 是失效的
	- 表级别 锁 ：一个直接就是表锁 lock table 建议不要使用, 影响太大，另个就是 MDL 元数据锁
	- [[MDL]] 是并发情况下维护数据的一致性,在表上有事务的时候,不可以对元数据经行写入操作,并且这个是在server层面实现的
	  当你做 dml 时候增加的 MDL 读锁, update table set id=Y where id=X; 并且由于隔离级别的原因 读锁之间不冲突
	- 当你[[DDL]] 时候 增加对表的写锁, 同时操作两个alter table 操作 这个要出现等待情况。
	- 但是 如果是  dml 与ddl 之间的交互 就更容易出现不可读写情况,这个情况容易session 爆满,session是占用内存的,也会导致内存升高
	  MDL 释放的情况就是 事务提交.
	- 主库上的一个小表做了一个 DDL, 同步给slave ,由于这个时候有了先前的 single-transaction,所以slave 就会出现 该表的 锁等待, 并且slave 出现延迟
- [[mysqldump]]
	- 当备库用–single-transaction 做逻辑备份的时候，如果从主库的 binlog 传来一个 DDL 语句会怎么样？
	  id:: 64089994-2772-424a-bfa1-c4f06d58ff59
		- ```
		  Q1:SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
		  Q2:START TRANSACTION  WITH CONSISTENT SNAPSHOT；
		  /* other tables */
		  Q3:SAVEPOINT sp;    /*设置一个保存点，这个很重要（Q3）；*/
		  /* 时刻 1 */
		  Q4:show create table `t1`;  /*show create 是为了拿到表结构 (Q4)，然后正式导数据 （Q5），回滚到 SAVEPOINT sp，在这里的作用是释放 t1 的 MDL 锁 （Q6）。当然这部分属于“超纲”，上文正文里面都没提到。*/
		  /* 时刻 2 */
		  Q5:SELECT * FROM `t1`;
		  /* 时刻 3 */
		  Q6:ROLLBACK TO SAVEPOINT sp;
		  /* 时刻 4 */
		  /* other tables */
		  ```
		- 解答
			- 如果在 Q4 语句执行之前到达，现象：没有影响，备份拿到的是 DDL 后的表结构。
			- 如果在`时刻 2`到达，[[$red]]==则表结构被改过==，Q5 执行的时候，报 Table definition has changed, please retry transaction，现象：mysqldump 终止；
			- 如果在“时刻 2”和“时刻 3”之间到达，mysqldump 占着 t1 的 MDL 读锁，binlog 被阻塞，现象：主从延迟，直到 Q6 执行完成。
			- 从“时刻 4”开始，mysqldump 释放了 MDL 读锁，现象：没有影响，备份拿到的是 DDL 前的表结构。
-