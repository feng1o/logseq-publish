### 基础篇 [[interview]]
	- ((64007981-7f12-4076-aaad-42f129be58cb))
	-
	- 1.[mysql基础架构](https://time.geekbang.org/column/article/68319)
		- 体系结构:
			- client
			- 连机器:[[$sub8-blue]]==tpc链接后，链接器会到表里查询user拥有的权限，此后都依赖读取到的。这就意味着，一个用户成功建立连接后，即使你用管理员账号对这个用户的权限做了修改，也不会影响已经存在连接的权限。修改完成后，只有再新建的连接才会使用新的权限设置。==
			- 查询缓存:: 查询的时候如果这里有就直接返回，但一般不建议使用，除非读多写少
			- 分析器
				- [[词法分析]]，识别关键字，表替换成对应tocken。
				- [[$sub8]]==比如一个column不存在的查询，报错是分析器做的。==
				- [[语法分析]]，判定是否符合mysql的语法
			- 优化器:: 就是看走哪个索引，确定执行方案
			- 执行器
				- 执行sql语句，会判定权限；会调用引擎接口打开表
			- 存储引擎
	- 2.[日志系统](https://time.geekbang.org/column/article/68633)，[[binlog]]、[[redo log]]
		- [[redo log]]，InnoDB 的 [[redo log]] 是固定大小的，比如可以配置为一组 4 个文件，每个文件的大小是 1GB，从头开始写，写到末尾就又回到开头循环写
		- [[两阶段提交]] 为什么需要 <a class="ask"></a>
			- 先写[[binlog]]，后写redo；如果写完binlog crash了，slave会回放binlog，但是恢复的无，数据不同
			- 先写[[redo log]]，后写binlog；redo完成后挂了，起来后会继续redo跟新成功，那基于binlog回放就少了数据。[[#red]]==crash恢复的redo不会产生binlog==
			- innodb_flush_log_at_trx_commit 、sync_binlog
			- [[PITR]]一般用最新的备份，回放binlog实现
	- 3.[事务隔离](https://time.geekbang.org/column/article/68963)  [[隔离级别]] [[ACID]]
		- {{embed ((63133c38-5bca-4c3f-b886-738d620f34b2))}}
		- 实际上每条记录在更新的时候都会同时记录一条回滚操作。记录上的最新值，通过回滚操作，都可以得到前一个状态的值。
		- 不同时刻启动的事务会有不同的 read-view。如图中看到的，在视图 A、B、C 里面，这一个记录的值分别是 1、2、4，同一条记录在系统中可以存在多个版本，就是数据库的多版本并发控制（MVCC）。
		- [[undo log]]回滚日志总不能一直保留吧，什么时候删除呢 <a class="ask"></a>
			- [[$sub8]]==答案是，在不需要的时候才删除。也就是说，系统会判断，当没有事务再需要用到这些回滚日志时，回滚日志会被删除。==
			- [[$sub8-blue]]==根据业务本身的预估，通过 SET MAX_EXECUTION_TIME 命令，来控制每个语句执行的最长时间==
	- 4.[索引](https://time.geekbang.org/column/article/69636)
		- 为什么不用hash、B树 <a class="ask"></a>
		- 理解innodb的索引类型，每个index就是一棵B+树
		- [[覆盖索引]]  非[[聚簇索引]]在查询的时候记录的是primary index的位置，那数据必须回到主键索引的叶子上找。
			- 由于覆盖索引可以减少树的搜索次数，显著提升查询性能，所以使用覆盖索引是一个常用的性能优化手段。
		- 回到主键索引树搜索的过程，我们称为[[回表]]
		- [[#red]]==索引有什么代价呢== <a class="ask"></a>
			- 占用空间
			  background-color:: navy
			- 更新数据需要更新索引、甚至重建、merge等
			  background-color:: seagreen
		- 索引可能因为删除，或者页分裂等原因，导致数据页有空洞，重建索引的过程会创建一个新的索引，把数据按顺序插入，这样页面的利用率最高，也就是索引更紧凑、更省空间。alter table T engine=InnoDB
		- ```
		  一张表两个字段id, uname,id主键，uname普通索引
		  SELECT * FROM test_like WHERE uname LIKE 'j'/ 'j%' / '%j'/ '%j%'
		  模糊查询like后面四种写法都可以用到uname的普通索引
		  
		  添加一个age字段
		  like后面的'%j'/ '%j%' 这两种情况用不到索引
		  把select * 改为 select id / select uname / select id,uname
		  like后面'j'/ 'j%' / '%j'/ '%j%'  这四种情况又都可以用到uname普通索引
		  
		  建立uname,age的联合索引
		  模糊查询还是 LIKE 'j'/ 'j%' / '%j'/ '%j%'四种情况
		  其中select id / select uname / select id,uname 
		  会用到uname的普通索引
		  select *  会用到uname,age的组合索引
		  
		  看到好些文章会说模糊查询时以%开头不会用到索引，实践后发现结论跟文章描述的有出入。
		  看了索引的这两节内容对上面的各种情况有的可以解释通了，有的仍然有些模糊，想问下老师上面这些情况使用索引时为什么是这样的？
		  
		  
		  1、因为查询的是 * ，会查询所有字段（id,uname）,而二级索引恰恰包含这些数据，又二级索引树比主键索引树小很多，所以直接挨个查询二级索引要比挨个查询主键索引要快的多，故用的是二级索引；
		  2、因为添加了age字段，但是二级索引里面没有age字段，就必须要回主键树查询所有字段（回表过程），所以挨个
		  3、因为建立了联合索引，所以二级索引树里面就包含了所有的字段（id,uname,age），所以就不用搜索主键索引树了；
		  综上：二级索引树小，且又包含了我们所需要的字段，所以就直接用二级索引啦，但是仍然是挨个遍历的。所以这里是和老师说的"用索引"是一个意思。顺便解释下老师说的用索引定位：就是不用搜索整个索引库直接用二分法能快速找到的数据叫用索引定位。
		  ```
	- 5. [索引 页关系](https://blog.csdn.net/qq_37102984/article/details/124296196?csdn_share_tail=%7B%22type%22%3A%22blog%22%2C%22rType%22%3A%22article%22%2C%22rId%22%3A%22124296196%22%2C%22source%22%3A%22unlogin%22%7D)
		- 改B+树的 N:
			- 1.通过改变key值来调整， N叉树中非叶子节点存放的是索引信息，索引包含Kev和Point指针。Point指针固定为6个字节，假如Key为10个字节，那么单个索引就是16个字节。如果B+树中页大小为16K，那么一个页就可以存储1024个索引，此时N就等于1024。我们通过改变Key的大小，就可以改变N的值
			- 改变页的大小， 页越大，一页存放的索引就越多，N就越大。
		- 可以简单理解为: B+树，高度为3，那根节点，一点在一个页面上，所以一个页能放多少是与index主键大小、sp指针大小(6字节)关系的；第二层呢，就会分裂出多个页，比如N=1000， 可以简单想想下面 又分散出1000个页，1000个页里继续分散出1000个叶子(存放数据)
	- 6.[全局锁和表锁](https://time.geekbang.org/column/article/69862) ：给表加个字段怎么有这么多阻碍？ [[MySQL锁]]
		- 枷锁范围::  全局锁，表锁、行锁
		- MySQL全局锁:
			- MySQL 提供了一个加全局读锁的方法，命令是 Flush tables with read lock ([[FTWRL]])
			- 全局锁的典型使用场景是，做全库逻辑备份。也就是把整库每个表都 select 出来存成文本。
			- [[mysql-backup]] 官方自带的逻辑备份工具是 [[mysqldump]]。当 [[mysqldump]] 使用参数–single-transaction 的时候(主库做了ddl怎么办），导数据之前就会启动一个事务，来确保拿到一致性[[视图]](必须是支持事务的引擎)。而由于 [[MVCC]] 的支持，这个过程中数据是可以正常更新的。
				- 那为什么还要[[FTWRL]]？ 一致性读是好，但前提是引擎要支持这个隔离级别。比如，对于 MyISAM 这种不支持事务的引擎，如果备份过程中有更新，总是只能取到最新的数据，那么就破坏了备份的一致性。
		- [[MySQL表级锁]]
			- [[MySQL]] 里面表级别的锁有两种：一种是[[表锁]]，一种是元数据锁（meta data lock， [[MDL锁]] )。
			- 表锁的语法是 lock tables … read/write。与 FTWRL 类似，
			- 另一类表级的锁是 [[MDL]]（metadata lock)。MDL 不需要显式使用，在访问一个表的时候会被自动加上。[[$red]]==MDL 的作用==是，保证读写的正确性
				- 比如: 对一个小表做加字段[[ddl]]操作，但是万一业务有大并发dml（加MDL的读锁，失败)会不停重试，此时可能直接打爆
				- 如何安全地给小表加字段？ kill连接？ 不一定有用新的来了；  设置超时时间，如果没拿到mdl锁就应该放弃其他时间搞
			- [[Online DDL]]:
				- 1. 拿MDL写锁
				  2. 降级成MDL读锁
				  3. 真正做DDL
				  4. 升级成MDL写锁
				  5. 释放MDL锁
				- 1、2、4、5如果没有锁冲突，执行时间非常短。第3步占用了DDL绝大部分时间，这期间这个表可以正常读写数据，是因此称为“online ”
		- [[MySQL行锁]] [[MySQL锁]]
			- 在 InnoDB 事务中，行锁是在需要的时候才加上的，但并不是不需要了就立刻释放，而是要等到事务结束时才释放。这个就是两阶段锁协议。
			- 并发引起的死锁问题怎么解决?
				- 开死锁检查：  一种头痛医头的方法，就是如果你能确保这个业务一定不会出现死锁，可以临时把死锁检测关掉
				- 控制并发
				- 打散数据，尽量不都去更新一条，比如把自研分多份，减任一一个即可；  以影院账户为例，可以考虑放在多条记录上，比如 10 个记录，影院的账户总额等于这 10 个记录的值的总和。这样每次要给影院账户加金额的时候，随机选其中一条记录来加
			- ((64089994-2772-424a-bfa1-c4f06d58ff59))
			- {{embed ((64089994-2772-424a-bfa1-c4f06d58ff59))}}
	- 8.事务到底是隔离的还是非隔离的？ [[undo log]]  [[MVCC]]
		- 在 MySQL 里，有两个“[[视图]]”的概念：
			- 一个是[[view]]。它是一个用查询语句定义的虚拟表，在调用的时候执行查询语句并生成结果。创建视图的语法是 create view … 而它的查询方法与表一样。
			- 另一个是 InnoDB 在实现 MVCC 时用到的一致性读视图，即 consistent read view，用于支[[RC]]（Read Committed，[[读提交]]）和 [[RR]]（Repeatable Read，[[可重复读]]）[[隔离级别]]的实现
		- > [[快照]]在 [[MVCC]] 里是怎么工作的？
			- 而每行数据也都是有多个版本的。每次事务更新数据的时候，都会生成一个新的数据版本，并且把 transaction id 赋值给这个数据版本的事务 ID，记为 row trx_id。同时，旧的数据版本要保留，并且在新的数据版本中，能够有信息可以直接拿到它。
			- 也就是说，数据表中的一行记录，其实可能有多个版本 (row)，每个版本有自己的 row trx_id。
			- ![image.png](../assets/image_1678285841928_0.png){:height 250, :width 588}
			- 三个虚线箭头，就是 undo log；而 V1、V2、V3 并[[#green]]==不是物理上真实存在==的，而是每次需要的时候根据当前版本和 undo log 计算出来的。比如，需要 V2 的时候，就是通过 V4 依次执行 U3、U2 算出来
			- 在实现上， InnoDB 为每个事务构造了一个数组，用来保存这个事务启动瞬间，当前正在“活跃”的所有事务 ID。“活跃”指的就是，启动了但还没提交。数组里面事务 ID 的最小值记为低水位，当前系统里面已经创建过的事务 ID 的最大值加 1 记为高水位。这个视图数组和高水位，就组成了当前事务的一致性视图（read-view）。而数据版本的可见性规则，就是基于数据的 row trx_id 和这个一致性视图的对比结果得到的。
			- InnoDB 利用了“[[$blue]]==所有数据都有多个版本==”的这个特性，实现了“秒级创建快照”的能力。
			- 基于[[mvcc]]的机制，每个数据有个trx_id，当前事务只能读到比自己trx_id小的veiw（实际上还要记录一个事务启动时正在执行的事务ID list, 因为这些[[$sub8-red]]==可能产生的trx_di比他小，但是也不应该可见==)， 当时这个是[[快照读]]，如果是[[当前读]]，是不受这个约束的。 一条规则：更新数据都是先读后写的，而这个读，只能读当前的值，称为“[[当前读]]”（current read）。
			- 而[[读提交]]的逻辑和[[可重复读]]的逻辑类似，它们最主要的区别是：
				- 在可重复读隔离级别下，只需要在[[#green]]==事务开始的时候==创建一致性视图，之后事务里的其他查询都共用这个一致性视图；
				- 在读提交隔离级别下，每一个[[#blue]]==语句执行前==都会重新算出一个新的视图。
			- [[幻读]]
- #### 实践篇 [[interview]]
	- collapsed:: true
	  9. 普通索引和唯一索引怎么选？ [#](https://time.geekbang.org/column/article/70848)
		- [[change buffer]]:
			- 当需要更新一个数据页时，如果数据页在内存中就直接更新，而如果这个[[$blue]]==数据页还没有在内存中的话，在不影响数据一致性的前提下，InnoDB 会将这些更新操作缓存在== [[change buffer]] 中，这样就不需要从磁盘中读入这个数据页了。在下次查询需要访问这个数据页的时候，将数据页读入内存，然后执行 change buffer 中与这个页有关的操作。通过这种方式就能保证这个数据逻辑的正确性。
			- [[change buffer]]，实际上它是可以持久化的数据。也就是说，[[change buffer]] 在内存中有拷贝，也会被写入到磁盘上。
			- > 什么条件下可以使用 change buffer 呢？
				- 比如有[[唯一索引]] ([[$blue]]==本篇文章的意义在于，如果碰上了大量插入数据慢、内存命中率低的时候，可以给你多提供一个排查思路)==，那要更新必须扫所有的，那既然扫了，肯定都已经读入bp了，没必要施一公change buffer了。 唯一索引的更新就不能使用 change buffer，实际上也只有普通索引可以使用。
				- change buffer 用的是 buffer pool 里的内存，因此不能无限增大
				- 有个 DBA 的同学跟我反馈说，他负责的某个业务的库内存命中率突然从 99% 降低到了 75%，整个系统处于阻塞状态，更新语句全部堵住。而探究其原因后，我发现这个业务有大量插入数据的操作，而他在前一天把其中的某个普通索引改成了唯一索引。
				- 写多读[少的可以，否则会立马触发merge](https://time.geekbang.org/column/article/70848)
			- >  redo log 和 change buffer。WAL 提升性能的核心机制，也的确是尽量减少随机读写，这两个概念确实容易混淆
				- ==redo log 主要节省的是随机写磁盘的 IO 消耗（转成顺序写），而 change buffer 主要节省的则是随机读磁盘的 IO 消耗。==
				- `mysql> insert into t(id,k) values(id1,k1),(id2,k2);`
				- 分析这条更新语句，你会发现它涉及了四个部分：
					- 内存、redo log（ib_log_fileX）、 数据表空间（t.ibd）、系统表空间（ibdata1）。
				- 这条更新语句做了如下的操作（按照图中的数字顺序）：Page 1 在内存中，直接更新内存；Page 2 没有在内存中，就在内存的 change buffer 区域，记录下“我要往 Page 2 插入一行”这个信息将上述两个动作记入 redo log 中（图中 3 和 4）。做完上面这些，事务就可以完成了。所以，你会看到，执行这条更新语句的成本很低，就是写了两处内存，然后写了一处磁盘（两次操作合在一起写了一次磁盘），而且还是顺序写的。
			- > WAL 之后如果读数据，是不是一定要读盘，是不是一定要从 redo log 里面把数据更新以后才可以返回？
				- 其实是不用的。你可以看一下图 3 的这个状态，虽然磁盘上还是之前的数据，但是这里直接从内存返回结果，结果是正确的。
		- >如果某次写入使用了 change buffer 机制，之后主机异常重启，是否会丢失 change buffer 和数据。
			- 虽然是只更新内存，但是在事务提交的时候，我们把 change buffer 的操作也记录到 redo log 里了，所以崩溃恢复的时候，change buffer 也能找回来
		- > change buffer的merge过程
			- 从磁盘读入数据页到内存（老版本的数据页）；
			- 从 change buffer 里找出这个数据页的 change buffer 记录 (可能有多个），依次应用，得到新版数据页；
			- 写 redo log。这个 redo log 包含了数据的变更和 change buffer 的变更。到这里 merge 过程就结束了。这时候，数据页和内存中 change buffer 对应的磁盘位置都还没有修改，属于脏页，之后各自刷回自己的物理数据，就是另外一个过程了。
		- > 补充 [[double write]]
			- double write实际上是记录的一个页的完整数据，redo log记录的不是完整页，他只能更新已有的页；所以如果页损坏，那就无法redo修复，double write可以恢复出页，那有redo就可以保障数据完整性
	- collapsed:: true
	  11. [怎么给字符串字段加index](https://time.geekbang.org/column/article/71492) [#](https://time.geekbang.org/column/article/71492)
		- 也就是说使用前缀索引，定义好长度，就可以做到既节省空间，又不用额外增加太多的查询成本。
		- > 当要给字符串创建前缀索引时，有什么方法能够确定我应该使用多长的前缀呢？
			- 我们在建立索引时关注的是区分度，区分度越高越好。因为区分度越高，意味着重复的键值越少
			- 前缀索引对覆盖索引的影响:: 比如部分index，那覆盖索引就失效了
			- 评论: 首先排除全部索引，占空间，其次排除前缀索引，区分度不高，再排除倒序索引，区分度还没前缀索引高。
			  最后hash索引（插入的试试计算crc32) 适合，而且只是登录检验，不需要范围查询。
	- collapsed:: true
	  12. 什么时候mysql会抖一下？ [#](https://time.geekbang.org/column/article/71806)
		- > 什么会触发flush?
			- InnoDB 的 redo log 写满了。这时候系统会停止所有更新操作，把 checkpoint 往前推进，redo log 留出空间可以继续写
			- 对应的就是系统内存不足。当需要新的内存页，而内存不够用的时候，就要淘汰一些数据页，空出内存给别的数据页使用。如果淘汰的是“脏页”，就要先将脏页写到磁盘。
				- 就保证了每个数据页有两种状态：
					- 一种是内存里存在，内存里就肯定是正确的结果，直接返回；
					- 另一种是内存里没有数据，就可以肯定数据文件上是正确的结果，读入内存后返回。这样的效率最高。
			- 空闲了认为应该flush一次，
			- 关闭了flush一次
		- 所以，刷脏页虽然是常态，但是出现以下这两种情况，都是会明显影响性能的：
			- 一个查询要淘汰的脏页个数太多，会导致查询的响应时间明显变长；
			- 日志写满，更新全部堵住，写性能跌为0，这种情况对敏感业务来说，是不能接受的。所以，InnoDB 需要有控制脏页比例的机制，来尽量避免上面的这两种情况。
		- > 如果你来设计策略控制刷脏页的速度，会参考哪些因素呢？
			- InnoDB 的刷盘速度就是要参考这两个因素：一个是脏页比例，一个是 redo log 写盘速度。innodb_io_capacity、innodb_max_dirty_pages_pct
		- flush刷脏的时候 ， 刷脏页过程不用动redo log文件的。 所以，不存在在淘汰脏页时，某些页的redo log是随机的不一定连续，那是否要对redo log进行合并呢？ 不用
			- 这个有个额外的保证，是r[[$red]]==edo log在“重放”的时候，如果一个数据页已经是刷过的，会识别出来并跳过==。
		- ![image.png](../assets/image_1678368227876_0.png){:height 403, :width 812}
	- collapsed:: true
	  13. 删除数据文件不减少？ [#](https://time.geekbang.org/column/article/72388)
		- 而在 MySQL 5.6 版本开始引入的 [[Online DDL]]，对这个操作流程做了优化。我给你简单描述一下引入了 Online DDL 之后，重建表的流程：
			- 建立一个[[$red]]==临时文件，扫描==表 A 主键的所有数据页；
			- 用数据页中表 A 的记录生成 B+ 树，存储到临时文件中；
			- 生成临时文件的过程中，将所有对 A[[$red]]==的操作记录在一个日志文件（row log）中==，对应的是图中 state2 的状态；
			- 临时文件生成后，将日志文件中的操作应用到临时文件，得到一个逻辑数据上与表 A 相同的数据文件，对应的就是图中 state3 的状态；
			- 用临时文件替换表 A 的数据文件。
			- online::  可以看到，与图 3 过程的不同之处在于，由于日志文件记录和重放操作这个功能的存在，这个方案在重建表的过程中，允许对表 A 做增删改操作
		- [[Online DDL]] 和 [[inplace DDL]]    [[#red]]==inplace实际上是堆server而言的==，比如5.5的时候重建表是搞个tmp-table导出入数据，而online ddl是innodb自己去创建了一个tmp file(文件)，然后在回放raw log，最后重命名；这个过程对server是不可见的，所以是inplace
			- DDL 过程如果是 Online 的，就一定是 inplace 的；
			- 反过来未必，也就是说 inplace 的 DDL，有可能不是 Online 的。截止到 MySQL 8.0，添加全文索引（FULLTEXT index）和空间索引 (SPATIAL index) 就属于这种情况。
		- > 如果你有一个 1TB 的表，现在磁盘间是 1.2TB，能不能做一个 inplace 的 DDL 呢？
			- 答案是不能。因为，tmp_file 也是要占用临时空间的
	- 14. count(*)问题 [#](https://time.geekbang.org/column/article/72775)
		- InnoDB 是索引组织表，主键索引树的叶子节点是数据，而普通索引树的叶子节点是主键值。所以，[[$red]]==普通索引树比主键索引树小很多==。对于 count(*) 这样的操作，遍历哪个索引树得到的结果逻辑上都是一样的。因此，MySQL 优化器会找到最小的那棵树来遍历
		- show table status的row不准
		- count(字段)<count(主键 id)<count(1)≈count(*)，所以我建议你，尽量使用 count(*)。  count字段要读取判定是不是null，*是特意优化了，1是不需要读取值
	- 15. [[mysql两阶段提交]]
	- collapsed:: true
	  16. order by语句  ==  To see
		- order by可能导致扫全表
			- 无条件查询如果只有order by create_time,即便create_time上有索引,也不会使用到。
			  因为优化器认为走二级索引再去回表成本比全表扫描排序更高。
			- 在sort的时候，有可能把数据都拿出来到sort buffer加tmp file排序直接返回，也有可能根据主键sort后回表，关键看优化器认为哪个方式更佳
		- ```
		  SET optimizer_trace='enabled=on';
		  SELECT * FROM `information_schema`.`OPTIMIZER_TRACE`\G
		  ```
		- 17
	- collapsed:: true
	  18. sql中可能对走索引有影响的case
		- 对索引字段做函数操作，可能会破坏索引值的有序性，因此优化器就决定放弃走树搜索功能。
		- 第二个例子是隐式类型转换，第三个例子是隐式字符编码转换，它们都跟第一个例子一样，因为要求在索引字段上做函数操作而导致了全索引扫描。
	- collapsed:: true
	  19. 简单语句很慢， why
		- 看processlist， 有可能等[[MDL锁]]
		- flush 线程的状态是 Waiting for table flush
		- 等行锁:: 问题并不难分析，但问题是怎么查出是谁占着这个写锁。如果你用的是 MySQL 5.7 版本，可以通过 sys.innodb_lock_waits 表查到。mysql> select * from t sys.innodb_lock_waits where locked_table='`test`.`t`'\G
		- 第二类：查询慢
			- 扫全表
	- background-color:: purple
	  collapsed:: true
	  20. [[幻读]]  [#](https://time.geekbang.org/column/article/75173)  [[间隙锁]] [[gap锁]] [[gap lock]] [[mysql锁]]
		- 幻读一般是由于[[当前读]]引起，比如for update了，有其他事务更新了，插入了都会被看到，for update的时候不会加没扫到锁，所以可以插入或更新
		- [[$red]]==幻读可见到是正常的，但有无问题呢？==
			- 首先是语义上的。session A 在 T1 时刻就声明了，“我要把所有 d=5 的行锁住，不准别的事务进行读写操作”。而实际上，这个语义被破坏了。
			- 数据不一致： 比如多个事务，在更新update的时候，因为执行和提交的数据不一致，binlog就可能和master执行顺不一致，最终有些多更新了数据或少更新
		- 也就是说，即使把所有的记录都加上锁，还是阻止不了新插入的记录，这也是为什么“[[幻读]]”会被单独拿出来解决的原因。
		- 因此，为了解决幻读问题，InnoDB 只好引入新的锁，也就是[[间隙锁]] ([[Gap Lock]])。
		- [[间隙锁]]
		  id:: 640afcea-e2ad-429c-ac95-70bcb4f94750
			- 间隙锁是在[[可重复读]]隔离级别下才会生效的。所以，你如果把隔离级别设置为[[读提交]]的话，就没有间隙锁了
			- 但是[[间隙锁]]不一样，跟[[间隙锁]]存在冲突关系的，是“往这个间隙中插入一个记录”这个操作。[[$red]]==[[间隙锁]]之间都不存在冲突关系==。
			- [[间隙锁]]和[[行锁]]合称 [[next-key lock]][[临界锁]]，每个 [[next-key lock]] 是前开后闭区间。也就是说，我们的表 t初始化以后，如果用 select * from table for update 要把整个表所有记录锁起来，就形成了 7 个 next-key lock，分别是 (-∞,0]、(0,5]、(5,10]、(10,15]、(15,20]、(20, 25]、(25, +supremum]。
				- 备注：这篇文章中，如果没有特别说明，我们把间隙锁记为开区间，把 next-key lock 记为前开后闭区间。
			- [[间隙锁]]和 [[next-key lock]] 的引入，帮我们解决了[[幻读]]的问题，但同时也带来了一些“困扰”。[[间隙锁]]会导致锁范围变大，并发度降低测试
		- {{embed ((640aff87-97ea-42c2-a0dc-a86c7f9dc056))}}
	- 23.MySQL是怎么保证数据不丢的？  [#](https://time.geekbang.org/column/article/76161)
	  collapsed:: true
		- [[binlog]] 的[[$red]]==写入机制==
			- binlog 的写入逻辑比较简单：事务执行过程中，先把日志写到 binlog cache，事务提交的时候，再把[[binlog cache]]  写到 binlog 文件中。
			- 一个事务的 [[$red]]==binlog 是不能被拆开==的，因此不论这个事务多大，也要确保一次性写入。这就涉及到了 binlog cache 的保存问题。
			- 系统给 binlog cache 分配了一片内存，[[$green]]==每个线程一个==，参数 binlog_cache_size 用于控制单个线程内 binlog cache 所占内存的大小。如果超过了这个参数规定的大小，就要暂存到磁盘。
		- [[redo log]] 的[[$red]]==写入机制==
			- redo不是每次都要写入disk，因为如果事务执行期间 MySQL 发生异常重启，那这部分日志就丢了。由于事务并没有提交，所以这时日志丢了也不会有损失。
			- >那么，另外一个问题是，事务还没提交的时候，redo log buffer 中的部分日志有没有可能被持久化到磁盘呢？答案是，确实会有。
				- 这三种状态分别是：存在 redo log buffer 中，物理上是在 MySQL 进程内存中，就是图中的红色部分；
				- 写到磁盘 (write)，但是没有持久化（fsync)，物理上是在文件系统的 page cache 里面，也就是图中的黄色部分；
				- 持久化到磁盘，对应的是 hard disk，也就是图中的绿色部分。写入磁盘是相对很慢
					- InnoDB 提供了 innodb_flush_log_at_trx_commit 参数，它有三种可能取值 0 1 2
						- 还有如果redo buffer占用一般了也会flush，事务提交的时候强制刷redo，那都可能导致在这个过程有redo没提交的刷盘
				- 如果把[[$red]]==innodb_flush_log_at_trx_commit 设置成 1，那么 redo log 在 prepare 阶段就要持久化一次==，因为有一个崩溃恢复逻辑是要依赖于 prepare 的 redo log，再加上 binlog 来恢复的。
		- > 为什么 [[binlog]] cache 是每个线程自己维护的，而 [[redo log]] buffer 是全局共用的？
			- MySQL 这么设计的主要原因是，binlog 是不能“被打断的”。一个事务的 binlog 必须连续写，因此要整个事务完成后，再一起写到文件里。而 redo log 并没有这个要求，中间有生成的日志可以写到 redo log buffer 中。redo log buffer 中的内容还能“搭便车”，其他事务提交的时候可以被一起写到磁盘中。
		- > 如果 [[binlog]] 写完盘以后发生 crash，这时候还没给客户端答复就重启了。等客户端再重连进来，发现事务已经提交成功了，这是不是 bug？
			- 设想一下更极端的情况，整个事务都提交成功了，redo log commit 完成了，备库也收到 [[binlog]] 并执行了。但是主库和客户端网络断开了，导致事务成功的包返回不回去，这时候客户端也会收到“网络断开”的异常。这种也只能算是事务成功的，不能认为是 bug。
	- collapsed:: true
	  24. 主备一致性[[主从复制]] [#](https://time.geekbang.org/column/article/76161)
		- [[binlog]]
			- > 为什么会有 mixed 格式的 binlog？
				- 因为有些 statement 格式的 binlog 可能会导致主备不一致，所以要使用 row 格式。
				- 但 row 格式的缺点是，很占空间。比如你用一个 delete 语句删掉 10 万行数据，用 statement 的话就是一个 SQL 语句被记录到 binlog 中，占用几十个字节的空间。但如果用 row 格式的 binlog，就要把这 10 万条记录都写到 binlog 中。这样做，不仅会占用更大的空间，同时写 binlog 也要耗费 IO 资源，影响执行速度。
				-
	- collapsed:: true
	  25. mysql高可用 [#](https://time.geekbang.org/column/article/76161)
		- 在满足数据可靠性的前提下，MySQL 高可用系统的可用性，是依赖于主备延迟的。延迟的时间越小，在主库故障的时候，服务恢复需要的时间就越短，可用性就越高。
		- [[主从复制]]
	- collapsed:: true
	  26. 备库为什么会落后好几个小时？
		- 并行复制：
		- 所以，coordinator 在分发的时候，需要满足以下这两个基本要求：不能造成更新覆盖。这就要求更新同一行的两个事务，必须被分发到同一个 worker 中。同一个事务不能被拆开，必须放到同一个 worker 中。
		-
	- id:: 640b0816-44e8-4087-9815-74fcb25c815e
	  collapsed:: true
	  27. 主库异常从库怎么办 [[主备切换]] [[主从切换]] [#](https://time.geekbang.org/column/article/77427)
		- 基于位点的[[主备切换]]
		- 基于 GTID 的[[主备切换]]
		-
	- 28 读写分离有什么坑 [#](https://time.geekbang.org/column/article/77636)
	  collapsed:: true
		- 讨论怎么处理[[过期读]]问题
			- 强制走主库方案；sleep 方案；判断主备无延迟方案；配合 semi-sync 方案；等主库位点方案；等 GTID 方案。
			- 等主库位点方案:: select master_pos_wait(file, pos[, timeout]);
			- GTID方案::  select wait_for_executed_gtid_set(gtid_set, 1);
	- 29.如何判定db异常了？ [#](https://time.geekbang.org/column/article/78134)
		- `select 1`并发连接和并发查询。innodb_thread_concurrency 设置为 128 的话，那么出现同一行热点更新的问题时，是不是很快就把 128 消耗完了，这样整个系统是不是就挂了呢？
			- 实际上，在线程进入锁等待以后，并发线程的计数会减一，也就是说等行锁（也包括间隙锁）的线程是不算在 128 里面的。
			- 因此： 如果有热点卡主了，但是并发数会认为很低，select 1 ok
		- 查表判断:: 加个表，里面只放一行数据，然后定期执行：
		- 更新判断
			- 既然要更新，就要放个有意义的字段，常见做法是放一个 timestamp 字段，用来表示最后一次执行检测的时间。为了让主备之间的更新不产生冲突，我们可以在 mysql.health_check 表上存入多行数据，并用 A、B 的 server_id 做主键。   判定慢还是搞不定
		- 以上都是外部检测，比如查询更新一条正常不一定ok，外部有随机性，比如正好给你分配了io，其他的异常了
		- 内部统计
		- 业务系统一般也有高可用的需求，在你开发和维护过的服务中，你是怎么判断服务有没有出问题的呢？
			- 服务状态、服务质量(RT）
	- 31. 误删数据，怎么恢复？
		- 使用 delete 语句误删数据行；   ---   binlog可以尝试修复，drop和truncate不行，只会记录sql
		- 使用 drop table 或者 truncate table 语句误删数据表；
		- 使用 drop database 语句误删数据库；
		- 使用 rm 命令误删整个 MySQL 实例。
		-
		- 误删库 / 表
			- 这种情况下，要想恢复数据，就需要使用全量备份，加增量日志的方式了。这个方案要求线上有定期的全量备份，并且实时备份 binlog。
		- 关键还是要有安全意识、和安全机制，规避误操作
	- 32. kill不掉的语句？
		- 收到 kill 以后，线程做什么？
			- 把 session B 的运行状态改成 THD::KILL_QUERY(将变量 killed 赋值为 THD::KILL_QUERY)；
			- 给 session B 的执行线程发一个信号。  为什么发信号？因为session并不是可以直接断开的，比如mdl锁必须释放
				- 因为像图 1 的我们例子里面，session B
				   处于锁等待状态，如果只是把 session B 的线程状态设置 THD::KILL_QUERY，线程 B 
				  并不知道这个状态变化，还是会继续等待。发一个信号的目的，就是让 session B 退出等待，来处理这个 THD::KILL_QUERY 状态。
			- 为什么发了信号还不行:: 关键不是发了信号就能kill，语句过程卖点，可能根本没到那个位置卡主了，就无法推出
			- 另一类情况是，终止逻辑耗时较长。
		- [[#green]]==接在客户端通过 Ctrl+C 命令，是不是就可以直接终止线程呢？== 不是，只是断开了client。实际上，执行 Ctrl+C 的时候，是 MySQL 客户端另外启动一个连接，然后发送一个 kill query 命令。
	- 33. 查很多数据影响？ [#](https://time.geekbang.org/column/article/79407)
		- 也就是说，MySQL 是“边读边发的”，这个概念很重要
		- 获取一行，写到 net_buffer 中。这块内存的大小是由参数 net_buffer_length 定义的，默认是 16k。重复获取行，直到 net_buffer 写满，调用网络接口发出去。
		- 如果你看到 State 的值一直处于“Sending to client”，就表示服务器端的网络栈写满了。
		  id:: 640ca734-ef4d-469a-bbb6-f1f078d0fd62
			- 如果你在自己负责维护的 MySQL 里看到很多个线程都处于“Sending to client”这个状态，就意味着你要让业务开发同学优化查询结果，并评估这么多的返回结果是否合理。
		-
	- 34. join是否可用、怎么优化？ [#](https://time.geekbang.org/column/article/79700)
		- 小table驱动大表
	- id:: 665d3e24-29fe-425e-9d46-880c643f8158
	  36. 为什么[[临时表]]可重名？ [#](https://time.geekbang.org/column/article/80449)  [mysql临时表-临时文件](http://mysql.taobao.org/monthly/2019/04/01/)
		- [[临时表]]的特性
			- ```
			  Note: 在之前的版本中(例如5.7)，使用ibtmp1来存储临时表数据和undo信息等，在每次重启时重新创建并使用新的space id.
			  ```
			- 临时表只能被创建它的 session 访问，对其他线程不可见
			- 临时表可以与普通表同名
			- session A 内有同名的临时表和普通表的时候，show create 语句，以及增删改查语句访问的是临时表。
			- show tables 命令不显示临时表。
		- [[临时表]]只适用于session，session结束释放。临时表就特别适合我们文章开头的 join 优化这种场景。为什么呢？标明可重复；不用担心数据删除问题
		- > 为什么临时表可以重名？  创建临时表后，文件情况
			- 这个 frm 文件放在临时文件目录下，文件名的后缀是.frm，前缀是“#sql{进程 id}_{线程 id}_ 序列号”
			- MySQL 维护数据表，除了物理上要有文件外，内存里面也有一套机制区别不同的表，每个表都对应一个 table_def_key。一个普通表的 
			  table_def_key 的值是由“库名 + 表名”得到的，所以如果你要在同一个库下创建两个同名的普通表，创建第二个表的过程中就会发现 
			  table_def_key 已经存在了。而对于临时表，table_def_key 在“库名 + 
			  表名”基础上，又加入了“server_id+thread_id”。
		- [[临时表]]和[[主备复制]]
			- 如果当前的 binlog_format=row，那么跟临时表有关的语句，就不会记录到 [[binlog]] 里（[[临时表]]本来就看不到)。也就是说，只在 binlog_format=statment/mixed 的时候，binlog 中才会记录临时表的操作。
			- 现在你知道原因了，那就是：drop table 命令是可以一次删除多个表的。比如，在上面的例子中，设置 binlog_format=row，如果主库上执行 "drop table t_normal, temp_t"这个命令，那么 binlog 中就只能记录：t_normal
			- 比如主上有几个create tempory talbe x1的语句，都是x1，到slave怎么办？ 也就是说，备库线程在执行的时候，要把这两个 t1 表当做两个不同的临时表来处理。这，又是怎么实现的呢？
			  id:: 640cab12-39ea-4486-bc67-99bb3ed0c1a7
				- MySQL 在记录 binlog 的时候，会把主库执行这个语句的线程 id 写到 [[binlog]] 中。这样，在备库的应用线程就能够知道执行每个语句的主库线程 id，并利用这个线程 id 来构造 [[临时表]] 的 table_def_key：session A 的临时表 t1，在备库的 table_def_key 就是：库名 +t1+“M 的 serverid”+“session A 的 thread_id”;session B 的临时表 t1，在备库的 table_def_key 就是 ：库名 +t1+“M 的 serverid”+“session B 的 thread_id”。
		- [在5.6以及以前的版本](http://mysql.taobao.org/monthly/2019/04/01/)，磁盘临时表都是放在数据库配置的临时目录，磁盘临时表的undolog都是与普通表的undo放在一起(注意由于磁盘临时表在数据库重启后就被删除了，不需要redolog通过奔溃恢复来保证事务的完整性，所以不需要写redolog，但是undolog还是需要的，因为需要支持回滚)。
			- 在MySQL 5.7后，磁盘临时表的数据和undo都被独立出来，放在一个单独的表空间ibtmp1里面。之所以把临时表独立出来，主要是为了减少创建删除表时维护元数据的开销。
			- 在MySQL 
			  8.0后，磁盘临时表的数据单独放在Session临时表空间池(\#innodb_temp目录下的ibt文件)里面，临时表的undo放在global的表空间ibtmp1里面,回收Global临时表空间，依然需要重启。另外一个大的改进是，8.0的磁盘临时表数据占用的空间在连接断开后，就能释放给操作系统，而5.7的版本中需要重启才能释放。
	- 37. 什么时候使用[[内存表]]
	- 39. [[自增键]]为什么不连续？
		- 唯一键冲突是导致自增主键 id 不连续的第一种原因。
			- > 接下来，我就跟你分析一下这个设计思路，看看自增值为什么不能回退。
		- 自增值的修改时机
	- 40. insert语句的锁为什么那么多？ [#](https://time.geekbang.org/column/article/80801)
		- insert … select 是很常见的在两个表之间拷贝数据的方法。你需要注意，在可重复读隔离级别下，这个语句会给 select 的表里扫描到的记录和[[间隙锁]]读锁。
		- 而如果 insert 和 select 的对象是同一个表，则有可能会造成循环写入。这种情况下，我们需要引入用户临时表来做优化。
		- insert 语句如果出现唯一键冲突，会在冲突的唯一值上加共享的 [[next-key lock]](S 锁)[[临界锁]]。因此，碰到由于唯一键约束导致报错后，要尽快提交或回滚事务，避免加锁时间过长。
	- 41. 怎么快速复制一张表？ [#](https://time.geekbang.org/column/article/81925)
		- insert into ... select
		- mysqldump导出导入
		- 导出为csv文件，然后load文件
		- 物理拷贝方法:: 在 MySQL 5.6 版本引入了[[可传输表空间]](transportable tablespace) 的方法，可以通过导出 + 导入表空间的方式，实现物理拷贝表的功能。
		- > binlog_format=statement 
		  的时候，binlog 记录的 load data 命令是带 local 
		  的。既然这条命令是发送到备库去执行的，那么备库执行的时候也是本地执行，为什么需要这个 local 呢？如果写到 binlog 中的命令不带 
		  local，又会出现什么问题呢
			- 为了确保备库应用 binlog 正常。因为备库可能配置了 secure_file_priv=null，所以如果不用 local 的话，可能会导入失败，造成主备同步延迟。
	- 42. grant后是否要flush? #
		- 如果内存的权限数据和磁盘数据表相同的话，不需要执行 flush privileges。  比如user、表、column权限都在mysq.user, table_priv, column_pri里和内存都有
		- flush privileges 使用场景
			- flush privileges 语句本身会用数据表的数据重建一份内存权限数据，所以在权限数据可能存在不一致的情况下再使用。而这种不一致往往是由于直接用 DML 语句操作系统权限表导致的，所以我们尽量不要使用这类语句
	- 45. 自增id用完怎么办？ [#](https://time.geekbang.org/column/article/83183)
		- InnoDB 表中主动创建自增主键。因为，表自增 id 到达上限后，再插入数据时报主键冲突错误，是更能被接受的。