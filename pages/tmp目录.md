- ((665d3e24-29fe-425e-9d46-880c643f8158))
- [tmp目录文件说明相关](https://www.cnblogs.com/paul8339/p/11983747.html)
- [哪些情况如何产品tmp文件 stackoverflow](https://dba.stackexchange.com/questions/30505/why-does-mysql-produce-so-many-temporary-myd-files)
- ```
  使用临时文件
  一、使用tmpdir
  1、执行计划file sort    文件名字MY开头
  lsof|grep delete
  如:/tmp/MYdRH1GW (deleted)
  
  2、大事物binary log缓存 文件名字ML开头
  lsof|grep delete
  如:/tmp/MLq9INFu (deleted)
  
  3、压缩的tempory table  
  CREATE TEMPORARY TABLE tmp_table1(id int) ROW_FORMAT=COMPRESSED ;
  ls /tmp/
  如:
  #sql6b82_6_7.frm
  #sql6b82_6_7.ibd
  
  4、online DDL 涉及排序比如add key
  alter table testsort add key(id);
  lsof|grep delete
  如:
  /tmp/ibCxlYQg (deleted)
  /tmp/ib51nvZ1 (deleted)
  设置 innodb_tmpdir可以将这类文件放到指定的目录
  
  二、使用innodb_temp_data_file_path
  1、执行计划use temporay table 5.7以后为innodb 内部表
  2、非压缩tempory table  
  CREATE TEMPORARY TABLE tmp_table1(id int);
  可以使用 select * from INNODB_TEMP_TABLE_INFO  ;查询
  这些也看不到 表现为innodb表
  
  
  三、使用innodb data 
  就是online ddl 
  1、ALGORITHM copy 名字为 #sql-
    alter table testsort ALGORITHM=copy ,add  im int  ;
  #sql-6b82_6.frm
  #sql-6b82_6.ibd
  
  2、ALGORITHM inplace 名字为 #sql-ib 
    alter table test add key id int
  比如
  #sql-6b82_6.frm
  #sql-ib59-867962583.ibd
  但是涉及到排序比如add key 则使用tmpdir或者innodb_tmpdir见上
  ```
-