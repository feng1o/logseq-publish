- –single-transaction 方法做逻辑备份，主库上的一个小表做了一个 DDL，在slave上会怎么样？
	- ```apl
	  Q1:SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
	  Q2:START TRANSACTION  WITH CONSISTENT SNAPSHOT；
	  /* other tables */
	  Q3:SAVEPOINT sp;
	  /* 时刻 1 */
	  Q4:show create table `t1`;    // 这之前没关系，因为ddl会拿到新的表结构
	  /* 时刻 2 */                 // 这里会因为拿到的是旧的结构，Q5 执行的时候，报 Table definition has changed, please retry transaction，现象：mysqldump 终止；
	  Q5:SELECT * FROM `t1`;      // 时刻2-3不能执行，因为拿了MDL锁
	  /* 时刻 3 */
	  Q6:ROLLBACK TO SAVEPOINT sp;
	  /* 时刻 4 */                // 释放了mdl，可以执行
	  /* other tables */
	  ```
-