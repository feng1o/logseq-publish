#!/bin/bash
PATH=/Library/Java/JavaVirtualMachines/jdk1.8.0_292_fiber.jdk/Contents/Home/bin:/Library/Java/JavaVirtualMachines/jdk-16.jdk/Contents/Home/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin::/bin:/Users/oxj-nameliu/.fzf/bin:/c/Users/oxj-nameliu/bin:/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/mingw64/bin:/usr/bin:/c/Users/oxj-nameliu/bin:/c/windows/system32:/c/windows:/c/windows/System32/Wbem:/c/windows/System32/WindowsPowerShell/v1.0:/c/windows/System32/OpenSSH:/d/Microsoft VS Code/bin:/cmd:/c/Users/oxj-nameliu/AppData/Local/Microsoft/WindowsApps:/d/install app/WebStorm 2021.2/bin:/d/install app/GoLand 2021.2.1/bin:/d/install app/PyCharm 2021.2/bin:/d/install app/CLion 2021.2/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:.

source ./color.sh

merge=${1:-'no'}
branch=${2:-"main"}
#exec 1>>log.log
work_path=$(pwd)
cd ${work_path}

LOG=${work_path}/${0//.sh/.log}
LOG=${work_path}/log.log
LOG_MAX_SIZE=2000  # KBytes

./hide-msg.sh
./hide-msg.sh

function log()
{
    echo  -e  "[$(date +'%F %T')][$$]: $*" >> $LOG
}

function log_and_stdout()
{
    log "$*"
    info "$*"
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
    echo "auto: $(date) pushed by cron"  
    git  status | grep -A 4 'git restore'  | grep -v 'git restore' | grep -v '未跟踪'
    #cm=$( git  status | grep -A 4 'git restore'  | grep -v 'git restore' )
}

function git_push() {
    return 1
    # glf
    git lfs prune
    git lfs track  assets/*.pdf  assets/*.edn assets/*.tgz assets/*

    #git pull --rebase

    cm=$(get_cm)
    log_and_stdout "$cm"

    git add .
    git commit -m  "$cm"
    git push 
}



log_and_stdout "#######################start@[$(date)]#################################"
ctrl_file_size ${LOG}

# back skip-sync.md
echo "============> 备份skiped-sync到../back-logseq/目录，并执行git add, git commit"
#cp pages/*-skip-sync.md  ../back-logseq
#cd ../back-logseq
#git status 
#git add .
#git commit -m "$(date +%Y%m%d-%H%M%S)"
#cd ${work_path}


git checkout $branch
#log_and_stdout "git pull --rebase start"
#git add .
#git stash

#git pull --rebase  # 该分支属于mac,不需要pull
#git stash pop
#log_and_stdout "git pull --rebase done"

# whether need save changes
info_with_color ${On_Purple}  "1.try push $branch to remote"
lines=$(git status | wc -l)
if [[ $lines -lt 8 ]]; then
    echo_with_color ${Yellow} " 没有修改，无需push"
    log_and_stdout "not found changes, skip $(date)"
else
    echo_with_color ${Yellow} " 有修改，start push"
    log_and_stdout "found changes, start push $(date)"
    git_push
fi

log_and_stdout " merge $branch to main start"
info_with_color ${On_Purple}  "2.merge $branch --> main start"
read -p "merge $branch to main ? 不为空即确认: "  merge
if [  ${#merge} -gt 0 ]; then
    echo " merge $branch to main "
    git checkout main
    git pull --rebase
    git merge $branch
    git status 
    read -p "merge无冲突？ " x
    git push
    
    git checkout $branch
fi

info_with_color ${On_Purple}  "3.merge main --> $branch  start"
read -p "merge main to current branch $branch : y " mlocal
if [ "$mlocal" == "y" -o "$mlocal" == "Y" ];then
    git checkout main
    git pull --rebase
    git checkout $branch
    git merge main
    git push
fi
log_and_stdout "#######################end@[$(date)]#################################\n\n\n"


#  git lfs ls-files | grep ddia
# GIT_TRACE=1 git lfs push origin --object-id 29a1e1d278
#git lfs push --object-id origin 29a1e1d27858ac57c1deb2eb22cc3026ba42f5a022afded11e8e78365ed94c85
