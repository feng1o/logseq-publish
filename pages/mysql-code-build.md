### with macOS
	- 通过clion编译调试，[官方doc](https://dev.mysql.com/doc/refman/8.0/en/source-installation.html)   [参考](https://shockerli.net/post/mysql-source-macos-clion-debug-5-7/)
		- 设置toolchains： bundled， bundled LLDB
		- [设置CMAKE](https://dev.mysql.com/doc/refman/8.0/en/source-configuration-options.html)
			- ```
			  cmake options:
			  -DDOWNLOAD_BOOST=1
			  -DWITH_B00ST=~/github/mysql-server/boost
			  -DWITH_DEBUG=1
			  -DCMAKE_BUILD_TYPE=Debug
			  -DCMAKE_INSTALL_PREFIX=~/github/mysql-server/build-out
			  -DMYSOL_DATADIR=~/github/mysql-server/build-out/data
			  -DSYSCONFDIR=~/github/mysql-server/build-out 
			  -DMYSOL_UNIX_ADDR=~/github/mysql-server/build-out/data/mysql.sock
			  -DMYSOL_MAINTAINER_MODE=false
			  -DMYSQL_TCP_PORT=3306
			  -DSYSCONFDIR=~/github/mysql-server/build-out/etc
			  
			  # 创建目录
			  mkdir -p build-out/data
			  mkdir -p build-out/etc
			  mkdir -p boost
			  ```
		- 启动cmake
			- ```
			  Tools > CMake > Reset Cache and Reload Project
			  View > Tool Windows > CMake 
			  
			  # 预期结果
			  -- Build files have been written to: ~/github/mysql-server/build-output
			  [Finished]
			  ```
		- 编译 mysql  mysqld至少需要
			- 选择mysqld build：
				- 会有很多all configurations  ....  ctags.... lz4... mysqldump.... mysqld   mysqladmin... mysql
			- 编译过程错误
				- 出现无m4
					- ```
					   brew install bison
					   brew info  m4   
					   echo 'export PATH="/usr/local/opt/m4/bin:$PATH"' >> ~/.zshrc
					  ```
				- `m4 命令需要使用命令行开发者工具。你要现在安装该工具吗?`  更新系统x-code， xcodebuild -runFirstLaunch无效
					- > 本质问题是找不到m4，发现`/Library/Developer/CommandLineTools/usr/bin`下没有m4，brew install的不行，直接做一个软链 ln -s  /usr/bin/m4  /Library/Developer/CommandLineTools/usr/bin/m4
			- clion编译失败：始终让安装xcode，暂时命令行解决，应该是clion无法关联xcode
				- ```
				  cmake --build /Users/${user}/github/mysql-server/build-out --target mysqld -j 16 #通过命令行build
				  ```
				-
	- #### 启动debug
		- ```
		  --initialize-insecure --lower_case_table_names=0
		  
		  # --basedir=/home/xx/build --datadir=/home/xx/build/data --lower_case_table_names=0 --initialize-insecure --user=mysql # 可指定一些目录
		  # -DSYSCONFDIR=~/github/mysql-server/build-out 在这个目录下 data
		  
		  # 第一次用这个初始化？ 然后去掉这些参数可启动debug？why？暂时用
		  --initialize-insecure --lower_case_table_names=1 --datadir=/Users/xxx/github/mysql-server/build-out/data
		  
		  # 登录mysql
		  ./build-out/bin#./mysql -uroot -h127.0.0.1 -P3306 -p  #无密码
		  ```
	- #### 配置my.cnf
		- ```
		  #也可以配置一些my.cnf   build-out/etc/my.cnf
		  [mysqld]
		  innodb_file_per_table = 1
		  innodb_flush_method = O_DIRECT
		  innodb_flush_log_at_trx_commit = 2
		  innodb_log_file_size = 512M
		  innodb_log_files_in_group = 3
		  #innodb_log_group_home_dir = ./log/
		  innodb_buffer_pool_size = 128G
		  lower_case_table_names=1
		  
		  ```
	-
