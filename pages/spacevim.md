- 1.tab 4space
	- https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
	- ```shell
	  filetype plugin indent on
	  " show existing tab with 4 spaces width
	  set tabstop=4
	  " when indenting with '>', use 4 spaces width
	  set shiftwidth=4
	  " On pressing tab, insert 4 spaces
	  set expandtab
	  ```
- 2. https://github.com/tomasr/molokai
  把这个color.vim房放在/usr/share/vim/vim74/colors/下面 molokai.vim，然后去vimrc里面设置colorschem  molokai就可以了，好像没有原来的那个号
- 3.https://spacevim.org/ 一个版本  下载install.sh，执行安装ok
-
- 4. vim的ctags跳转失败： vi /root/.vimrc设置后ok；
  ```shell
  "oxj-name add                                                                                                                                                                                     
  set nu
  "ctags
  set tags=./tags;../tags
  "set tags=./tags
  ```
  
  --------------------------------------------------------------------------------
  5.安装vim8.1
  ```shell
  a.git clone  https://github.com/vim/vim.git
  b.支持Python和lua：./configure --with-features=huge --enable-python3interp --enable-pythoninterp  --enable-rubyinterp --enable-luainterp --enable-perlinterp  --enable-multibyte --enable-cscope --enable-luainterp
  错误`CFLAGS' was set to `' in the previous run   make distclean解决
  make  当然也可以./configure下，=/usr或 /xx，看INSTALL
  c.make install
  
  d.安装完成后，发现找不到vim，没变；此时看看安装完后的提示，找下实际在/USR/LOCAL/bin/vim下，此时直接打开
  e，然后重命名旧的vim，ln -s  xx 、usbin/bin/vim，然后看配置在哪里？
  f.vim ：version， 看到有系统，用户配置，https://blog.easwy.com/archives/where-is-vimrc/
  g.然后，更新配置，vim ：version   :echo $HOME 
  $HOME 在：/usr/local/share/vim
  h.spacevim更新：下载install.sh后直接执行会自动下载配置等，或者直接按照官方的安装
   install.sh  --install vim 就ok了，，
  ```
  
  -----------------------------------------------------------------------------
- 5. <a href=https://everettjf.gitbooks.io/spacevimtutorial/content/day/6.html> spacevim配置</a>
	- > 一小部分终端不支持真色，如果你的 SpaceVim 颜色看上去比较怪异
	  可以禁用终端真色，将enable_guicolors = true
	- ![clipboard.png](../assets/clipboard_1647752219471_0.png){:height 186, :width 123}
	-
	- vim /root/.SpaceVim/vimrc   安装后可改的配置