- [sqlite.org/src/doc/trunk/README.md](https://sqlite.org/src/doc/trunk/README.md)  sqlite使用fossil管理
- 安装命令fossil,
	- ```shell
	  mkdir -p ~/github/15445/sqlite 
	      cd sqlite
	      fossil clone https://www.sqlite.org/src  sqlite.fossil
	      fossil open  sqlite/sqlite.fossil
	      
	  # 编译
	      tar xzf sqlite.tar.gz    ;#  Unpack the source tree into "sqlite"
	      mkdir bld                ;#  Build will occur in a sibling directory
	      cd bld                   ;#  Change to the build directory
	      ../sqlite/configure      ;#  Run the configure script
	      make                     ;#  Builds the "sqlite3" command-line tool
	      make sqlite3.c           ;#  Build the "amalgamation" source file
	      make devtest             ;#  Run some tests (requires Tcl)
	  ```