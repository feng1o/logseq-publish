icon:: 
color:: green

- > PROMPT='%{$fg[green]%}@%{$fg[magenta]%}%(?..%?%1v)%n:%{$reset_color%}%{$fg[cyan]%}%~#'
- mac上gdb问题：brew install gdb
	- gcc --version看可能是clang，故brew install gcc，直接gcc指向安装的gcc
	- ```bash
	  Soft-link (ln -s) gcc-11 and g++-11 from /usr/local/Cellar/ to /usr/local/bin/
	  unhash (at least in zsh) gcc and g++, or else gcc will continue to expand to /usr/bin/clang
	  
	  # 实际修改  brew install gcc   brew install xcode
	  ln -s /usr/local/Cellar/gcc/14.1.0/bin/gcc-14  /usr/local/bin/gcc-gcc
	  实际上安装后 /usr/local/bin/gcc-x都有了 包括g++   # gcc已经被clang占有
	  gcc-14@         gcc-ar-14@      gcc-gcc@        gcc-nm-14@      gcc-ranlib-14@
	  
	  # gcc-gcc -g gdb1.cpp
	  
	  安装gcc后必须安装最新的xcode command tool
	  安装gdb后需要开启钥匙证书https://www.cnblogs.com/booturbo/p/17384509.html，不过启动thread还是卡主，ctrl+c后能调试....
	  ```
	- xcode问题
		- 一般安装xcode command tool即可,
		- 安装后这些命令： /Library/Developer/CommandLineTools/usr/bin
		-
	- [valgrind安装](https://zz1.ink/2021/05/20/mac-os-valgrind/)
		- ```
		  brew tap LouisBrunner/valgrind
		  brew install --HEAD LouisBrunner/valgrind/valgrind
		  
		  brew upgrade --fetch-HEAD LouisBrunner/valgrind/valgrind
		  ```