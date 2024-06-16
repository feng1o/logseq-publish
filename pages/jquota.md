- | **方法** | **特点** |
  | quota限制 | 低版本ext3/4仅只能支持对分区的user、group等限制 |
  |  | xfs支持目录限制，cdb机器不支持 |
  | | tlinux 0053新内核已移入proj quota限额，可对目录做限制； 但需设置目录id，使用非常麻烦；目前也未上线 |
  | loop镜像 | 使用一个固定大小的镜像文件，限制大小； 对灵活动态调整的不适应 |
- ----
- ```shell
  01.  fstab
  /dev/hioa1 /data1 ext4 noatime,acl,user_xattr,usrquota,grpquota  1 2
  /dev/hioa1 /data1 ext4 noatime,acl,user_xattr,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv1  1 2
  
  必须开启jquota，否则不支持4G以上锁
  
  02. remount
  mount -o remount,usrquota /
  quotacheck -avug 扫瞄磁盘的使用者使用状况，并产生重要的 aquota.group 与 aquota.user：
  03. set
  setquota -u mysql20157  89861  99860  0 0  /dev/hioa1
  
  04.get
  repquota -aug  / -au
  
  05.quotaon/off    -aug / -a / -au
  group quota on /data1 (/dev/hioa1) is on
  user quota on /data1 (/dev/hioa1) is off
  ```
- ![image.png](../assets/image_1670412710930_0.png){:height 146, :width 444}
- ```bash
  06. quota -p  mysql20157 |  quota -vu quser1 quser2
  
  07.quota 不支持4G上的： plain quota； journalied quota新版本支持大约4G；https://serverfault.com/questions/348015/setup-user-group-quotas-4tib-on-ubuntu
  
  07.1  如何开启journalied quota：https://www.howtoforge.com/how-to-set-up-journaled-quota-on-debian-lenny
  touch /aquota.user /aquota.group
  chmod 600 /aquota.*
  mount -o remount /
  quotacheck -avugm  ---如果没报错提示quotacheck: Your kernel probably supports journaled quota but you are not using it. Consider switching to journaled quota to avoid running quotacheck after an unclean shutdown. 
  quotaon -avug
  
  /dev/md1 / ext4 grpjquota=quota.group,usrjquota=quota.user,jqfmt=vfsv1 0 2
   /dev/hioa1 /data1 ext4 noatime,acl,user_xattr,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv1  1 2
  ```
-
- ----
- check quota on
- ```
  #check quota
  #paritions=$(df -h | grep -E data[0-9] | cut -d' ' -f 1)
  #for p in $paritions; do
  #    usrquota_on=$(mount  | grep -w $p | grep -w usrjquota)
  #    if [[ ${#usrquota_on} -lt 10 ]]; then
  #        echo "$p usrquota is not enabled"
  #        exit 10
  #    fi
  #done
  ```
- op 操作
	- ```shell
	  #!/bin/bash
	  LOG_BASE="/data/xxxx_sh_log"
	  #LOG=${LOG_BASE}/${0//.sh/.log}
	  LOG=${LOG_BASE}/node_disk_quota.log
	  LOG_MAX_SIZE=16000000
	  
	  if [ $# -lt 6 ];then
	    echo "Usage $0 -p[port] -t[partition] -d[disk] -l[disk_limit] -f[op_type] -n[now_disk]"
	    exit 1
	  fi
	  
	  while getopts "p:t:d:l:f:n:" optname
	  do
	      case "$optname" in
	      "p")
	      port=$OPTARG
	      ;;
	      "t")
	      partition=$OPTARG
	      ;;
	      "d")
	      disk=$OPTARG
	      ;;
	      "l")
	      disk_limit=$OPTARG
	      ;;
	      "f")
	      op_type=$OPTARG
	      ;;
	      "n")
	      now_disk_used=$OPTARG
	      ;;
	  esac
	  done
	  
	  function log()
	  {
	      echo -e "[$(date +'%F %T')][$$]: [$port-$op_type] $*" >> $LOG
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
	  
	  test_exitcode()
	  {
	    local exitcode="$?"
	    if [ $exitcode -ne 0 ]
	    then
	        rm -f /tmp/DUMMY_$port
	        log_and_stdout "$1"
	      exit $exitcode
	    fi
	  }
	  
	  function inst_is_off()
	  {
	          mysql -utencentroot -h127.0.0.1 -P$port -Ne "show global  variables like 'datadir'"
	          if [ $? -eq 0 ]; then
	                  return 1
	          else
	                  return 0
	          fi
	  }
	  
	  function is_quota_off()
	  {
	      if [[ $partition =~ data1$ ]]; then
	          partition=$(readlink  -f /${partition}/mysql_root/data/${port} | awk -F'/' '{ print $2 }')
	      fi
	     p=$(df -h | grep -E ${partition} | cut -d' ' -f 1)
	     usrquota_on=$(mount  | grep -w ${p} | grep -w usrjquota)
	     mount_quota=$(quotaon -p  ${p} | grep user | grep "is on")
	     if [[ ${#usrquota_on} -lt 10 ]] || [[ ${#mount_quota} -lt 10 ]]; then
	         log_and_stdout "$p usrquota is not enabled, $usrquota_on , $mount_quota"
	         return 0
	     fi
	     return 1
	     # paritions=$(df -h | grep -E data[1-9] | cut -d' ' -f 1)
	     # for p in $paritions; do
	     #     usrquota_on=$(mount  | grep -w $p | grep -w usrjquota)
	     #     mount_quota=$(quotaon -p  $p | grep user | grep "is on")
	     #     if [[ ${#usrquota_on} -lt 10 ]] || [[ ${#mount_quota} -lt 10 ]]; then
	     #         log_and_stdout "$p usrquota is not enabled : $p"
	     #         return 0
	     #     fi
	     # done
	     # return 1
	  }
	  
	  ## lock start
	  FILE_LOCK="/data1/tmp_for_iso/${port}/${port}.lock"
	  FILE_PID="/data1/tmp_for_iso/${port}/${port}.pid"
	  LOCK_DIR=$(dirname $FILE_LOCK)
	  LOCK_STAT=$LOG_BASE/.lock_${port}.stat
	  if [ ! -e $LOCK_DIR ]; then
	      #mkdir -p $LOCK_DIR
	          log_and_stdout "$LOCK_DIR is not exists, exit"
	          exit 1
	  fi
	  
	  function try_lock_check()
	  {
	          last_s_unlock=$(cat  ${LOCK_STAT}  | grep -v "#" | tail -1 | grep -w 's_unlock')
	          if [[ "${op_type}" == "s_lock" ]]; then
	                  if [ ${#last_s_unlock} -lt 5 ]; then
	                          log_and_stdout "${LOCK_STAT} get last_s_unlock not exist, skip s_lock"
	                          exit 3
	                  fi
	                  param=($(cat  ${LOCK_STAT} | grep -v "#" | grep -w 'lock'  | tail -1 | cut -d'|' -f 2))
	                  if [ ${#param[*]} -ne 5  ]; then
	                          log_and_stdout "$LOCK_STAT  param err, ${param[*]}"
	                          exit 2
	                  fi
	                  disk=${param[2]}
	                  disk_limit=${param[3]}
	                  now_disk_used=${param[4]}
	                  log_and_stdout "  init  --------"
	                  log_and_stdout "  init  disk = $disk"
	                  log_and_stdout "  init  disk_limit = $disk_limit"
	                  log_and_stdout "  init  now_disk_used = $now_disk_used"
	                  log_and_stdout "  init  --------"
	                  tparam=($(cat  ${LOCK_STAT} | grep -v "#" | grep -w 's_unlock'  | tail -1 | cut -d'|' -f 3))
	                  if [[ ${#tparam[*]} -eq 1 ]] && [[ ${tparam[0]} -gt $disk_limit ]]; then
	                          disk_limit=${tparam[0]}
	                  fi
	                  log_and_stdout "  init  disk_limit = $disk_limit , ${tparam[0]}"
	          elif [[ "${op_type}" == "lock" ]]; then
	                  if [ ${#last_s_unlock} -gt 5 ]; then
	                          log_and_stdout "${LOCK_STAT} get last_s_unlock exist, update stat and skip lock"
	                          echo "#$(date +'%F/%T') ${op_type} | found s_unlock doing, try update stat"
	                          echo "$(date +'%F/%T') ${op_type} | ${port} ${partition} ${disk} ${disk_limit} ${now_disk_used} " >> $LOCK_STAT
	                          echo "$last_s_unlock" >> $LOCK_STAT
	                          exit 0
	                  fi
	          fi
	  }
	  
	  exec 300> ${FILE_LOCK}
	  function is_unlock() {
	      if ! /usr/bin/flock -xn 300 ;then
	          local pid=$(cat ${FILE_PID})
	          log_and_stdout "${0} (PID: ${pid}) already running ..."
	          return 1
	      else
	          echo ${$} > ${FILE_PID}
	          return 0
	      fi
	  }
	  
	  function clean_lock() {
	      /usr/bin/flock -u 300
	      rm -f ${FILE_LOCK}
	      exec 300>&-
	      rm -f ${FILE_PID}
	  }
	  ## lock end
	  
	  function get_quota_blocks()
	  {
	      user=$1
	      if [[ ! $user =~ mysql[0-9]+ ]]; then
	          log "quota blokcs user err $user"
	          echo 0
	      fi
	      quota_blocks=$(quota -u ${user} | grep "dev" | awk '{ print $2 }')
	      quota_blocks=${quota_blocks%%\*}
	      log "quota blokcs = $quota_blocks k"
	      quota_blocks=$((quota_blocks / 1024))
	      log "quota blokcs = $quota_blocks M"
	      echo $quota_blocks
	  }
	  
	  
	  function op_quota()
	  {
	      if [[ $partition =~ data1$ ]]; then
	          partition=$(readlink  -f /${partition}/mysql_root/data/${port} | awk -F'/' '{ print $2 }')
	      fi
	      log_and_stdout "1.get real partition =$partition"
	      if [[ "$op_type" == "lock" ]] || [[ "$op_type" == "s_lock" ]]; then
	                  #if inst_is_off ; then
	                  #       log_and_stdout " inst is off, can not set "
	                  #       exit 66
	                  #fi
	                  try_lock_check
	                  if [[ $disk -gt $disk_limit ]]; then
	                          log_and_stdout " disk = $disk lt disk_limit = $disk_limit"
	                          exit 66
	                  fi
	          disk_free=$(df -m  --output=avail /$partition  | grep -v 'Ava')
	          quota_blocks=$(get_quota_blocks mysql${port})
	          log_and_stdout "2.$op_type disk=$disk, disk_limit=$disk_limit  disk_free=$disk_free quota_blocks=$quota_blocks "
	          if [[ $quota_blocks == 0 ]]; then
	              log_and_stdout "$quota_blocks eq 0, do not lock set quota"
	              #exit 0
	              quota_blocks=${now_disk_used}
	          fi
	          # last hard quota limit
	          quota_limit=$disk_limit
	          if [[ $quota_limit -lt $quota_blocks ]]; then
	              log_and_stdout " check quota_limit and quota_blocks :$quota_limit -lt $quota_blocks"
	              quota_limit=$quota_blocks
	          fi
	          # caculate disk_limit by disk free  and inst disk size
	          tenth_disk_free=$(echo "$disk_free*0.05"|bc)
	          tenth_disk_free=${tenth_disk_free%.*}
	          tenth_disk=$(echo "$disk*0.1"|bc)
	          tenth_disk=${tenth_disk%.*}
	          if [[ $tenth_disk  -lt $tenth_disk_free ]]; then
	              t_limit=$tenth_disk
	          else
	              t_limit=$tenth_disk_free
	          fi
	          if [[ $t_limit -gt 20000 ]]; then
	              t_limit=20000
	          fi
	          log_and_stdout "3.tenth_disk_free = $tenth_disk_free,  tenth_disk = $tenth_disk  t_limit = $t_limit"
	                  if inst_is_off && [ $t_limit -lt $tenth_disk ]; then
	                          log_and_stdout "inst is off, delta disk must more than tenth_disk=$tenth_disk"
	              t_limit=$tenth_disk
	                  fi
	                  if [[ $quota_limit -lt 1000 ]]; then
	                          log_and_stdout " last quota_limit lt 1000M, err"
	                          exit 66
	                  fi
	          quota_limit=$((quota_limit + t_limit))
	                  quota_limit=$((quota_limit * 1024))
	          log_and_stdout "4.last quota = $quota_limit"
	          log_and_stdout "5.quota cmd: setquota -u mysql${port}  ${quota_limit}  ${quota_limit}  0 0  /${partition}"
	          set_res=$(setquota -u mysql${port}  ${quota_limit}  ${quota_limit}  0 0  /${partition} 2>&1)
	          echo "#$(date +'%F/%T') ${op_type} | setquota -u mysql${port}  ${quota_limit}  ${quota_limit}  0 0  /${partition}" >> $LOCK_STAT
	                  echo "$(date +'%F/%T') ${op_type} | ${port} ${partition} ${disk} ${disk_limit} ${now_disk_used} " >> $LOCK_STAT
	          if [[ $? -ne 0 ]]; then
	              log_and_stdout  "set quota err,  $res"
	              exit 8
	          fi
	                  last_quota_conf=$(quota -u mysql${port} | grep dev)
	          log_and_stdout "6. $last_quota_conf"
	      elif [[ "$op_type" == "unlock" ]] || [[ "$op_type" == "s_unlock" ]]; then
	          user_quota_on=$(quota -u mysql${port})
	          if [[ $? -eq 0 ]]; then
	              user_quota_on=$(echo $user_quota_on | grep "none")
	              if [[ ${#user_quota_on} -gt 5 ]]; then
	                              log_and_stdout "1.user quota is off, kip lock"
	                      fi
	                          quota_blocks=$(get_quota_blocks mysql${port})
	                          log_and_stdout "2.s_unlock try get now quota_blocks : $quota_blocks"
	                  fi
	          for((i=0;i<3;i=i+1)); do
	              log_and_stdout "3.quota cmd: setquota -u mysql${port}  0 0  0 0  /${partition}"
	              setquota -u mysql${port}  0 0  0 0  /${partition}
	              if [ $? -eq 0 ]; then
	                                  last_quota_conf=$(quota -u mysql${port} | grep -E "none|dev")
	                                  log_and_stdout "4.unlock, get last quota conf: $last_quota_conf"
	                                  if [[ ${#user_quota_on} -lt 5 ]] && [[ "${op_type}" == "s_unlock" ]]; then
	                                          echo "$(date +'%F/%T') ${op_type} | quota cmd: setquota -u mysql${port}  0 0  0 0  /${partition} | $quota_blocks " >> $LOCK_STAT
	                                  fi
	                  return
	              fi
	          done
	                          quotaoff -a
	              log_and_stdout  "set quota unlock err"
	              exit 888
	          else
	          log_and_stdout  "input op_type = $op_type err"
	      fi
	  }
	  
	  ##################[START FROM HERE]################################################
	  if [[ ! -e $LOG_BASE ]]
	  then
	      mkdir -p $LOG_BASE
	  fi
	  log "#######################start@[$(date)]#################################"
	  ctrl_file_size ${LOG}
	  
	  log_and_stdout "input :"
	  log_and_stdout "   port = $port"
	  log_and_stdout "   disk = $disk"
	  log_and_stdout "   disk_limit = $disk_limit"
	  log_and_stdout "   partition = $partition"
	  log_and_stdout "   op_type = $op_type"
	  log_and_stdout "   now_disk_used = $now_disk_used"
	  log_and_stdout "   stat_log = $LOCK_STAT"
	  
	  
	  log_and_stdout "########################### start ############################"
	  for((i=0;i<5;i=i+1)); do
	  if is_unlock ; then
	      log_and_stdout "===> get lock success, task start"
	      if is_quota_off ; then
	          log_and_stdout "dev quota is off"
	          exit 0
	      fi
	      op_quota
	      # last clean
	      clean_lock
	          break
	  else
	      log_and_stdout " get lock failed, sleep 5"
	          sleep 5
	  fi
	  done
	  
	  log_and_stdout "########################### end ############################"
	  log_and_stdout ""
	  ```