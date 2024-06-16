- ```shell
  tool_dir=`dirname  $0`
  #workdir=$(pwd)
  #cd $workdir
  source ${tool_dir}/color.sh
  #source /data/xxxj-x-l/tools/color.sh
  
  #cd $(dirname $0)
  #work_path=$(pwd)
  #LOG=${work_path}/${0//.sh/.log}
  LOG_BASE="/data/cdb_sh_log"
  #LOG=${LOG_BASE}/install_mysql_inst.log
  LOG=${LOG_BASE}/${0//.sh/.log}
  LOG_MAX_SIZE=16000000
  
  function log()
  {
      echo -e "[$(date +'%F %T')][$$]: $*" >> $LOG
  }
  
  function log_and_stdout()
  {
      log "$*"
      echo "$*"
  }
  
  function ctrl_file_size()
  {
      ## brief: if file_size > max_size, then cut half lines
      local file=$1
      if [ ! -f $file ];then
          return 1
      fi
      local file_size=`du -b $file | awk '{print $1}'`
      if [ $? -ne 0 ];then
          return 2
      fi
      max_size=$LOG_MAX_SIZE  #32M
      if [ $file_size -lt $max_size ];then
          return 3
      fi
      truncate_row=$(wc -l $file | awk '{print $1}')
      ((truncate_row=truncate_row/2))
      if [ $truncate_row -ge 1 ];then
          sed -i "1,${truncate_row}d" $file
          log "[WARN]Truncate ${truncate_row} rows..."
          return 0
      fi
      return 4
  }
  
  log "#######################start@[$(date)]#################################"
  ctrl_file_size ${LOG}
  ```
- ``` bash
  #!/usr/bin/env bash
  
  #=============================================================================
  # install.sh --- bootstrap script for SpaceVim
  # Copyright (c) 2016-2017 Shidong Wang & Contributors
  # Author: Shidong Wang < wsdjeg at 163.com >
  # URL: https://spacevim.org
  # License: GPLv3
  #=============================================================================
  
  # Init option {{{
  Color_off='\033[0m'       # Text Reset
  
  # terminal color template {{{
  # Regular Colors
  Black='\033[0;30m'        # Black
  Red='\033[0;31m'          # Red
  Green='\033[0;32m'        # Green
  Yellow='\033[0;33m'       # Yellow
  Blue='\033[0;34m'         # Blue
  Purple='\033[0;35m'       # Purple
  Cyan='\033[0;36m'         # Cyan
  White='\033[0;37m'        # White
  
  # Bold
  BBlack='\033[1;30m'       # Black
  BRed='\033[1;31m'         # Red
  BGreen='\033[1;32m'       # Green
  BYellow='\033[1;33m'      # Yellow
  BBlue='\033[1;34m'        # Blue
  BPurple='\033[1;35m'      # Purple
  BCyan='\033[1;36m'        # Cyan
  BWhite='\033[1;37m'       # White
  
  # Underline
  UBlack='\033[4;30m'       # Black
  URed='\033[4;31m'         # Red
  UGreen='\033[4;32m'       # Green
  UYellow='\033[4;33m'      # Yellow
  UBlue='\033[4;34m'        # Blue
  UPurple='\033[4;35m'      # Purple
  UCyan='\033[4;36m'        # Cyan
  UWhite='\033[4;37m'       # White
  
  # Background
  On_Black='\033[40m'       # Black
  On_Red='\033[41m'         # Red
  On_Green='\033[42m'       # Green
  On_Yellow='\033[43m'      # Yellow
  On_Blue='\033[44m'        # Blue
  On_Purple='\033[45m'      # Purple
  On_Cyan='\033[46m'        # Cyan
  On_White='\033[47m'       # White
  
  # High Intensity
  IBlack='\033[0;90m'       # Black
  IRed='\033[0;91m'         # Red
  IGreen='\033[0;92m'       # Green
  IYellow='\033[0;93m'      # Yellow
  IBlue='\033[0;94m'        # Blue
  IPurple='\033[0;95m'      # Purple
  ICyan='\033[0;96m'        # Cyan
  IWhite='\033[0;97m'       # White
  
  # Bold High Intensity
  BIBlack='\033[1;90m'      # Black
  BIRed='\033[1;91m'        # Red
  BIGreen='\033[1;92m'      # Green
  BIYellow='\033[1;93m'     # Yellow
  BIBlue='\033[1;94m'       # Blue
  BIPurple='\033[1;95m'     # Purple
  BICyan='\033[1;96m'       # Cyan
  BIWhite='\033[1;97m'      # White
  
  # High Intensity backgrounds
  On_IBlack='\033[0;100m'   # Black
  On_IRed='\033[0;101m'     # Red
  On_IGreen='\033[0;102m'   # Green
  On_IYellow='\033[0;103m'  # Yellow
  On_IBlue='\033[0;104m'    # Blue
  On_IPurple='\033[0;105m'  # Purple
  On_ICyan='\033[0;106m'    # Cyan
  On_IWhite='\033[0;107m'   # White
  # }}}
  
  # version
  Version='0.9.0-dev'
  #System name
  System="$(uname -s)"
  
  # }}}
  
  # need_cmd {{{
  need_cmd () {
    if ! hash "$1" &>/dev/null; then
      error "Need '$1' (command not found)"
      exit 1
    fi
  }
  # }}}
  
  # success/info/error/warn {{{
  msg() {
    printf '%b\n' "$1" >&2
  }
  
  success() {
    msg "${Green}[✔]${Color_off} ${1}${2}"
  }
  
  info() {
    msg "${Blue}[➭]${Color_off} ${1}${2}"
  }
  
  error() {
    msg "${Red}[✘]${Color_off} ${1}${2}"
    #exit 1
  }
  
  warn () {
    msg "${Red}[✘]${Color_off} ${1}${2}"
  }
  # }}}
  
  # echo_with_color {{{
  echo_with_color () {
    printf '%b\n' "$1$2$Color_off" >&2
  }
  # }}}
  #echo_with_color ${Yellow} ""
  ```