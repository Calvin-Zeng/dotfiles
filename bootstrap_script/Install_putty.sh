#!/bin/bash

set -eu -o pipefail # fail on error,debug all lines

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)
work_dir=/tmp/putty_tmp
instdir=$HOME/local

version="0.77"
putty_dir="putty-$version"
file="putty-$version.tar.gz"
url="https://the.earth.li/~sgtatham/putty/latest/$file"

die() {
  echo $1
  exit 1
}

check_internet() {
  if $(nc -zw1 "google.com" "443" 2> /dev/null); then
    return 0
  fi
  return 1
}

# Some system will show this message below.
# WARNING: cannot verify download.gnome.org's certificate, issued by ‘CN=R3,O=Let's Encrypt,C=US’:
get_file() {
  wget "$1" || \
  wget --no-check-certificate "$1" || \
  curl --remote-name "$1" || \
  wget --passive-ftp "$1" || \
  ftp "$1" </dev/null || \
  exit 1
}

help() {
  cat << EOF
usage: $0 [OPTIONS]

    -h               Show this message
    -o               Prepare the tarball for off-line pc use.
EOF
}

while getopts ho opt; do
  case "$opt" in
    h)
      help
      exit 0
      ;;
    o)
      cd "$dir_path"
      check_internet
      [[ $? -eq 1 ]] && die "Check your internet connectivity."
      set -o pipefail
      echo "$url"
      if ! (get_file $url); then
        set +o pipefail
        die "Failed to download with curl and wget"
      fi
      unset url;
      set +o pipefail
      echo "Download complete, Move all tarball to $work_dir on offline system."
      exit 0
      ;;
  esac
done
shift `expr ${OPTIND:-1} - 1`

# refer to https://raw.githubusercontent.com/junegunn/fzf/master/install
try_curl() {
  command -v curl > /dev/null &&
  if [[ $1 =~ tar.gz$ ]]; then
    curl -fL $1 | tar -xzf -
  else
    local temp=${TMPDIR:-/tmp}/temp.zip
    curl -fLo "$temp" $1 && unzip -o "$temp" && rm -f "$temp"
  fi
}

try_wget() {
  command -v wget > /dev/null &&
  if [[ $1 =~ tar.gz$ ]]; then
    wget -O - $1 | tar -xzf -
  else
    local temp=${TMPDIR:-/tmp}/temp.zip
    wget -O "$temp" $1 && unzip -o "$temp" && rm -f "$temp"
  fi
}

if test ! -d $work_dir; then
    mkdir -p $work_dir
fi

cd $work_dir

[ -f "$dir_path/$file" ] && tar xf "$dir_path/$file" -C "$work_dir" || 
if ! (try_curl "$url" || try_wget "$urle"); then
  set +o pipefail
  die "Failed to download with curl and wget"
fi
set +o pipefail

cd $putty_dir 

# Setup Putty 0.74 build config.
#./mkauto.sh

#cd unix/
#./configure
# Ubuntu 18.04.1 need super user execute this.
#echo ${SUDO_PASSWD} | sudo -S ./configure
cmake -DCMAKE_INSTALL_PREFIX=$instdir .

# make & make install.
#make LDFLAGS="-Wl,--no-as-needed,-ldl"
cmake --build . --target install

# Date: 2019/10/09 20:17:40
# Ubuntu 18.04.1 need copy object to unix folder.
# Ubuntu 20.04 putty-0.74 no need do this
# cp {uxmisc.o,uxnet.o,uxnogtk.o,uxnoise.o,uxpeer.o,uxplink.o,uxproxy.o,uxsel.o,uxser.o,uxshare.o,uxsignal.o,uxstore.o,uxsftp.o} unix/

# Or you can use '/home/daryl/Work/putty-0.70/unix' to sudo make install
#echo ${SUDO_PASSWD} | sudo -S make install

echo "Install Putty-$version finished successfully."
