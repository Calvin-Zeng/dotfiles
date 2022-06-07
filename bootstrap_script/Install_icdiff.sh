#!/bin/bash

# exit on error
set -e

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)

version=2.0.5
file="release-${version}.tar.gz"
url="https://github.com/jeffkaufman/icdiff/archive/refs/tags/${file}"

install_prefix=$HOME/.local/bin
icdiff_dir="icdiff-release-${version}"
work_dir="/tmp/icdiff_tmp"

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
  exit 1
}

help() {
  cat << EOF
usage: $0 [OPTIONS]

    -h               Show this message
    -o               Prepare the tarball for off-line pc use.
EOF
}

# for opt in "$@"; do
while getopts ho opt; do
  case "$opt" in
    h)
      help
      exit 0
      ;;
    o)
      get_file $url
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

[ -d "$work_dir" ] || mkdir -p $work_dir
[ -d "$install_prefix" ] || mkdir -p $install_prefix

cd $work_dir

[ -f "$dir_path/$file" ] && tar xf "$dir_path/$file" -C "$work_dir" || 
if ! (try_curl $url || try_wget $url); then
  set +o pipefail
  die "Failed to download with curl and wget"
fi
set +o pipefail

cp "$icdiff_dir/icdiff" "$install_prefix"
cp "$icdiff_dir/git-icdiff" "$install_prefix"

echo -e "\n${install_prefix}/icdiff is now available."
