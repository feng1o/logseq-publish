- 抽样对比
	- count(*) 直接扫非memory，系统表； conunt 主从对比
	- countRow: 必须有pimary key:  抽一部分行，然后对比每个key 里的value，比如float，int，string等
	-
- [pt原理](https://www.modb.pro/db/56033)
	- ```
	  在主库执行校验语句（binlog格式为STATEMENT），通过复制传递到从库，如果数据不一致，则主、
	  从会产生不同的校验值，以此来判断主从数据是否一致
	  
	  1.master设置session变量：binlog格式为statement，隔离级别为repeatable read
	  2.master按chunk（多行一般0.5s的，动态调整-主从延迟)计算this_crc / this_cnt（lock in share mode），通过statement复制到slave
	  4.slave按chunk计算自己的this_crc / this_cnt
	  5.master更新master_crc / master_cnt，通过传递值到slave
	  6.slave对比master_crc / this_crc，master_cnt / this_cnt
	  
	  看哪些不一致？
	  SELECT db, tbl, SUM(this_cnt) AS total_rows, COUNT(*) AS chunks
	  FROM percona.checksums
	  WHERE (
	   master_cnt <> this_cnt
	   OR master_crc <> this_crc
	   OR ISNULL(master_crc) <> ISNULL(this_crc))
	  GROUP BY db, tbl;
	  ```
- select crc32(convert(f_name using latin1)) from mobileqq_mp_sys.t_pub_account where f_id = '25865647';