#!/bin/bash

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)
work_dir=/tmp/snavigator_tmp
instdir=$HOME/local_snavigator

snavigatorver="4.5"
snavigator_dir="sourcenavigator-NG$snavigatorver"
file="sourcenavigator-NG$snavigatorver.tar.bz2"
url="https://jaist.dl.sourceforge.net/project/sourcenav/NG$snavigatorver/$file"

use_root=0

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

confirm() {
  read -r -p "$1" answer
  case $answer in
      ""|[Yy]* ) return 0;;
      [Nn]* ) return 1;;
      * ) echo "Please answer Y or N."; return 1;;
  esac
}

confirm "Use root privilege install snavigator? ([Y]/N): "
[ $? -eq 0 ] && read -r -p "Enter the root password:" sudo_passwd && use_root=1 && instdir="/usr/local";

[ $use_root -eq 1 ] && echo ${SUDO_PASSWD} | sudo -S apt-get -y install libx11-dev

if test ! -d $work_dir; then
    mkdir -p $work_dir
fi

# Compile snavigator
cd "$work_dir"
echo "$url"
if tar -tf "$file" 1> /dev/null; then : ; else
  get_file "$url" || exit 1
fi

rm -rf "$snavigator_dir"
tar xf "$file"
cd "$snavigator_dir"
if test -f snavigator/parsers/chill/main.c; then : ; else
  echo "sourcenavigator source is incomplete" 2>&1
  exit 1
fi

# Setup Source Navigator NG build config.
./configure --prefix="$instdir"

# make & make install.
make
if [ $use_root -eq 1 ]; then
  echo ${sudo_passwd} | sudo -S make install
else
  make install
fi

echo "Install SourceNavigator$snavigatorver - finished successfully."
echo "Setting view preferences:"
echo "   -Misc-Courier-medium-r-Normal--*-160-*-*-*-*-iso8859-1"
echo "   font size: 16"
echo "External editor:"
echo "   subl %f:%l"
echo "   vi %f +%l"
