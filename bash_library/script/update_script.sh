#!/bin/bash

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)

cd $dir_path

# Some system will show this message below.
# WARNING: cannot verify download.gnome.org's certificate, issued by ‘CN=R3,O=Let's Encrypt,C=US’:
get_file() {
  wget "$1" -O $2 || \
  wget --no-check-certificate "$1" -O $2 || \
  curl --remote-name "$1" -o $2 || \
  wget --passive-ftp "$1" -O $2 || \
  ftp "$1" </dev/null || \
  exit 1
}

confirm() {
  read -r -p "$1" answer
  case $answer in
      ""|[Yy]* ) return 0;;
      [Nn]* ) return 1;;
      * ) echo "Please answer Y or N."; return 1;;
  esac
}

check_sum() {
    remote_md5=$(command -v curl > /dev/null && curl -sfL $1 | md5sum | cut -d ' ' -f 1)
    [ ! $? -eq 0 ] && remote_md5=$(command -v wget > /dev/null && wget --no-check-certificate -O - $1 | md5sum | cut -d ' ' -f 1)
    local_md5="$(md5sum "$2" | cut -d ' ' -f 1)"

    if [ "$remote_md5" = "$local_md5" ]; then
        echo "hurray, remote $2 are equal to the local!"
    else
        [ $(command -v colordiff) ] && diff_cmd="colordiff" || diff_cmd="diff";
        confirm "$2 have different version, download? ([Y]/N): "
        [ $? -eq 0 ] && get_file $1 tmp.sh && $diff_cmd tmp.sh $2 || return 0;
        confirm "Over-write the $2? ([Y]/N): "
        [ $? -eq 0 ] && mv tmp.sh $2;
        rm tmp.sh
    fi
}

check_sum "https://gist.githubusercontent.com/ketan/2866a236596636311d64/raw/ansi-color-test.sh" ansi-color-test.sh
check_sum "http://www.shelldorado.com/scripts/cmds/avg.txt" avg.sh 
check_sum "http://www.shelldorado.com/scripts/cmds/base.sh.txt" base.sh 
check_sum "https://cht.sh/:cht.sh" cht.sh 
check_sum "http://www.shelldorado.com/scripts/cmds/cpdir.txt" cpdir.sh 
check_sum "http://www.shelldorado.com/scripts/cmds/cpiodir.txt" cpiodir.sh 
check_sum "https://raw.githubusercontent.com/janosgyerik/shellscripts/master/bash/dos2unix.sh" dos2unix.sh 
check_sum "http://www.shelldorado.com/scripts/cmds/excpio.txt" excpio.sh 
check_sum "http://www.shelldorado.com/scripts/cmds/global.txt" global.sh 
check_sum "http://www.shelldorado.com/scripts/cmds/safecp.txt" safecp.sh 
check_sum "https://tecmint.com/wp-content/scripts/tecmint_monitor.sh" tecmint_monitor.sh 
check_sum "http://www.shelldorado.com/scripts/cmds/timestamp.txt" timestamp.sh 
check_sum "https://raw.githubusercontent.com/laurent22/rsync-time-backup/master/rsync_tmbackup.sh" rsync_tmbackup.sh 
