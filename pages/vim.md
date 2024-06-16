icon::

- [[spacevim]]
- TODO marks: 标记能力:  ma(就是m+a字幕，多个文件用大A)打个标签a到当前位置，`a就是跳转到a这个；:makrs  列出  :delmarks/? >[2023-07-09 - 2023-07-14](#agenda://?start=1688912849069&end=1689344849069) >[🍅 1min](#agenda-pomo://?t=p-1688912911490-1)
  id:: 6667150c-efe2-4d19-a3cb-53719c4e678c
- vimrc配置 
  ``` shell
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  set mouse=r
  set list
  set listchars=tab:\|\ ,trail:-,nbsp:_
  可以设置vim的空格和space区别；展示出，对于python有用：
  
  
  --------------------------------------------------------------------------------
  key_words:
  space  tab 打开最近的缓存页
  space f o
  space t n 切换行号
  --------------------------------------------------------------------------------
  vi /root/.SpaceVim.d/init.toml
  [[layers]]
   name = "git"
  
  --------------------------------------------------------------------------------
  修改配置：
  关闭相对行显示:
  ~/.SpaceVim# vi autoload/SpaceVim.vim
  
  
  --------------------------------------------------------------------------------
   vim /root/.SpaceVim/vimrc 
  " Note: Skip initialization for vim-tiny or vim-small.
  if 1
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'
  endif
  " vim:set et sw=2
  " 设置tab是4个空格 
  set sw=4
  set ts=4
  set expandtab
  set autoindent
  
  "忽略大小写匹配
  set ignorecase
  set mouse=r                                                                                                                                                                                 
  let g:ackprg = 'ag --vimgrep'
  --------------------------------------------------------------------------------
  set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
  set fileencodings=utf-8,gbk
  ```