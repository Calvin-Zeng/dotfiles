#!/bin/bash

# exit on error
set -e

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)

file="smartgit-linux-21_2_3.tar.gz"
url="https://www.syntevo.com/downloads/smartgit/$file"

install_prefix=$HOME/app_images/

die() {
  echo $1
  exit 1
}

# Some system will show this message below.
# WARNING: cannot verify download.gnome.org's certificate, issued by ‘CN=R3,O=Let's Encrypt,C=US’:
get_file() {
  wget "$1" || \
  wget --no-check-certificate "$1" || \
  curl --remote-name "$1" || \
  wget --passive-ftp "$1" || \
  ftp "$1" </dev/null || \
  die "Download $1 fail!"
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
      get_file "$url"
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

[ -d "$install_prefix" ] || mkdir -p $install_prefix

cd $install_prefix

[ -f "$dir_path/$file" ] && tar zxf $file -C $install_prefix ||
if ! (try_curl "$url" || try_wget "$url"); then
  set +o pipefail
  die "Failed to download with curl and wget"
fi
set +o pipefail

source $install_prefix/smartgit/bin/add-menuitem.sh

echo -e "\nSmartGit is now available."
