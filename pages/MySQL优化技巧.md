- 如果你的 MySQL 现在出现了性能瓶颈，而且瓶颈在 IO 上，可以通过哪些方法来提升性能呢？
	- 设置 binlog_group_commit_sync_delay 和 binlog_group_commit_sync_no_delay_count
	   参数，减少 binlog 的写盘次数。这个方法是基于“额外的故意等待”来实现的，因此可能会增加语句的响应时间，但没有丢失数据的风险。将
	- sync_binlog 设置为大于 1 的值（比较常见是 100~1000）。这样做的风险是，主机掉电时会丢 binlog
	- innodb_flush_log_at_trx_commit 设置为 2。这样做的风险是，主机掉电的时候会丢数据。
- 客户端程序的连接器，连接完成后会做一些诸如 show columns 的操作，在短连接模式下这个影响就非常大了。
	- 在 review 项目的时候，不止要 review 我们自己业务的代码，也要 review 连接器的行为。一般做法就是在测试环境，把 general_log 打开，用业务行为触发连接，然后通过 general log 分析连接器的行为
- {{embed ((640ca734-ef4d-469a-bbb6-f1f078d0fd62))}}
- ### [获取mysqld加载的配置文件](https://note.youdao.com/s/WQ0Vy5E1)
	- mysql -u -p -S /tmp/mysql.sock --default-character-set=utf8
	- 在mysql配置文件中加上如下内容，并在客户端mysql命令行参数加上–defaults-file=/home/mysql/conf/my1.cnf
		- `strace -o /tmp/bbb_my.strace mysql -u -p -S /tmp/mysql.sock`
		- ![image.png](../assets/image_1691143176539_0.png){:height 293, :width 413}
- ```
  SET optimizer_trace='enabled=on';
  SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G
  ```
- 统计碎片率
	- ```bash
	  select      ENGINE,     TABLE_NAME,    Round( DATA_LENGTH/1024/1024) as data_length ,     round(INDEX_LENGTH/1024/1024) as index_length,     round(DATA_FREE/ 1024/1024) as data_free  from information_schema.tables   where  DATA_FREE > 0 and table_name='table';
	  
	  # db碎片率
	  select      ENGINE,     TABLE_NAME,    Round( DATA_LENGTH/1024/1024) as data_length ,     round(INDEX_LENGTH/1024/1024) as index_length,     round(DATA_FREE/ 1024/1024) as data_free, data_free/(data_length+index_length) as frag_ratio from information_schema.tables   where table_schema='db-name'and  DATA_FREE > 0;
	  
	  # 查询binlog insert
	  grep "DELETE FROM \`xxdb\`.\`dxxxxbtable\`" binlog1233.log |wc -l
	  ```