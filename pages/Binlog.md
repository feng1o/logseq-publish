- **[binlog_gtid_simple_recovery](http://dev.mysql.com/doc/refman/5.7/en/replication-options-gtids.html#sysvar_binlog_gtid_simple_recovery)** ：MySQL5.7.7之后默认on，这个参数控制了当mysql启动或重启时，mysql在搜寻GTIDs时是如何迭代使用binlog文件。该参数为真时，mysql-server只需打开最老的和最新的这2个binlog文件，gtid_purged参数的值和gtid_executed参数的值可以根据这些文件中的Previous_gtids_log_event或者Gtid_log_event计算得出。这确保了当mysql-server重启或清理binlog时，只需打开2个binlog文件。当这个参数设置为off，在mysql恢复期间，为了初始化gtid_executed，所有以最新文件开始的binlog都要被检查。并且为了初始化gtid_purged，所有的binlog都要被检查。这可能需要非常长的时间，**建议开启**。注意：MySQL5.6中，默认为off，调整这个选项设置也同样会提升性能，但是在一些特殊场景下，计算gtids值可能会出错。而保持这个选项值为off，能确保计算总是正确。
-