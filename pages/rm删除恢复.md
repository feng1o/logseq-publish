- 006.恢复删除文件
  1. 参考：http://easwy.com/blog/archives/undelete-directories-files-on-ext3-
  filesystem-via-ext3grep/
  2. 安装ext3grep工具 ]安装ext3grep工具 ]
  ext3grep官方网站：http://code.google.com/p/ext3grep/
  网盘下载：http://pan.baidu.com/s/1i47ZPsT
  所需的系统相关包如下：
  [root@localhost ~]#rpm -qa | grep e2fsprogs
  e2fsprogs-libs-1.39-8.el5
  e2fsprogs-1.39-8.el5
  e2fsprogs-devel-1.39-8.el5
  3. http://www.linuxprobe.com/file-undelete-ext3grep.html
  4. 获取已经删除文件名字路径：
  ext3grep /dev/sda3 --dump-names | tee filename.txt
  5. df 查看磁盘，最好先取消挂载，
  删除的home下的，就是/dev/vda1了
  6. 然后恢复：
  ext3grep /dev/sda3 --restore-file easwy/vi/tips.xml
  7. 可以恢复某个时间后的：ext3grep /dev/vda2 --restore-all --after=1506744497；
  时间点，然后到RESTRE_FILE里面
-
- ```sh
  alias rmd='/bin/rm '
  
  #export PS1='\[\e[1;34m\]# \[\e[1;36m\]\u \[\e[1;0m\]@ \[\e[1;32m\]\h \[\e[1;0m\]in \[\e[1;33m\]\w \[\e[1;0m\][\[\e[1;0m\]\t\[\e[1;0m\]]\n\[\e[1;31m\]$\[\e[0m\] '
  export PS1='\[\e[31;1m\]\u\[\e[0m\]@\[\e[32;1m\]127.x.0.1\[\e[0m\]:\[\e[35;1m\]\w\[\e[0m\]# '
  
  #subdir=`date +%y%m%d`  #年月日 17_9_21日 每天一个删除子文件夹...方便分类
  subdir=`date +%y%m`  #年月日 17_9_21日 每天一个月删除子文件夹...方便分类
  #垃圾文件夹
  mkdir -p ~/.trash/$subdir
  #命令别名 rm改变为trash，现把rm改造成删除文件至回收站
  alias rm=trash
  # rl 命令显示回收站中的文件
  alias rl='ls ~/.trash'
  #找回回收站下的文件
  alias ur=unrmfile
  unrmfile()
  {
    echo -e '\[0;36m 只能移回当yue的;\[0'
    file=$@
    #mv -i ~/.trash/$file  ./
    mv -i ~/.trash/$subdir/$@  ./
  }
  #将指定的文件移动到指定的目录下，通过将rm命令别名值trash来实现把rm改造成删除文件至回收站
  trash()
  {
    mv $@ ~/.trash/$subdir/
  }
  #清空回收站目录下的所有文件
  alias crm=cleartrash
  cleartrash()
  {
      read -p "彻底删除垃圾箱所有文件sure?[Y/N]" confirm
      #if test ( [ $confirm == 'y' ] || [ $confirm == 'Y' ] ) ; error
      if test  $confirm == 'y' -o  $confirm == 'Y'  ;
      then
          /bin/rm -rf ~/.trash/*
      fi
      #[ $confirm == 'y' ] || [ $confirm == 'Y' ]  && /bin/rm -rf ~/.trash/*
  }
   
  ```
