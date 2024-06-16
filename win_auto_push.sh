#!/bin/bash
PATH="/Library/Java/JavaVirtualMachines/jdk1.8.0_292_fiber.jdk/Contents/Home/bin:/Library/Java/JavaVirtualMachines/jdk-16.jdk/Contents/Home/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin::/bin:/Users/oxj-nameliu/.fzf/bin:/c/Users/oxj-nameliu/bin:/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/mingw64/bin:/usr/bin:/c/Users/oxj-nameliu/bin:/c/windows/system32:/c/windows:/c/windows/System32/Wbem:/c/windows/System32/WindowsPowerShell/v1.0:/c/windows/System32/OpenSSH:/d/Microsoft VS Code/bin:/cmd:/c/Users/oxj-nameliu/AppData/Local/Microsoft/WindowsApps:/d/install app/WebStorm 2021.2/bin:/d/install app/GoLand 2021.2.1/bin:/d/install app/PyCharm 2021.2/bin:/d/install app/CLion 2021.2/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:."


#exec 1>>log.log
work_path=$(pwd)
cd ${work_path}

LOG=${work_path}/${0//.sh/.log}
LOG=${work_path}/log.log
LOG_MAX_SIZE=2000  # KBytes

function log()
{
    echo  -e  "[$(date +'%F %T')][$$]: $*" >> $LOG
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
    local file_size=`du -k $file | awk '{print $1}'`
    if [ $? -ne 0 ];then
        return 2
    fi
    max_size=$LOG_MAX_SIZE  #32M
    if [[ $file_size -lt $max_size ]]; then
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

function get_cm() {
    echo "auto: $(date) pushed by cron win / wsl"  
    git  status | grep -A 4 'git restore'  | grep -v 'git restore' | grep -v '未跟踪'
    #cm=$( git  status | grep -A 4 'git restore'  | grep -v 'git restore' )
}

function git_push() {
    # glf
    git lfs prune
    git lfs track  assets/*.pdf  assets/*.edn assets/*.tgz assets/*

    git pull --rebase

    cm=$(get_cm)
    log_and_stdout "$cm"

    git add .
    git commit -m  "$cm"
    git push 
}



log_and_stdout "#######################start@[$(date)]#################################"
ctrl_file_size ${LOG}

log_and_stdout "$(date)  git pull --rebase done"
# 尽量在没改前pull下
git pull --rebase
# whether need save changes
lines=$(git status | wc -l)
if [[ $lines -lt 8 ]]; then
    log_and_stdout "not found changes, skip $(date)"
else
    git_push
fi
log_and_stdout "#######################end@[$(date)]#################################\n\n\n"
