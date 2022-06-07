#!/bin/bash

# exit on error
set -e

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)

version=v0.21.0
url="https://github.com/sharkdp/bat/releases/download/$version/"

install_prefix=$HOME/.local/bin
work_dir="/tmp/bat_tmp"

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

check_platform() {
  # Try to download binary executable
  archi=$(uname -sm)
  case "$archi" in
    Darwin\ x86_64)
      file="bat-$version-x86_64-apple-darwin.tar.gz"
      bat_dir="bat-${version}-x86_64-apple-darwin"
      ;;
    Linux\ armv*)
      file="bat-$version-arm-unknown-linux-gnueabihf.tar.gz"
      bat_dir="bat-${version}-arm-unknown-linux-gnueabihf"
      ;;
    Linux\ aarch64*)
      file="bat-$version-aarch64-unknown-linux-gnu.tar.gz"
      bat_dir="bat-${version}-aarch64-unknown-linux-gnu"
      ;;
    Linux\ *64)
      file="bat-$version-x86_64-unknown-linux-gnu.tar.gz"
      bat_dir="bat-${version}-x86_64-unknown-linux-gnu"
      ;;
    Windows*\ *64)
      file="bat-$version-x86_64-pc-windows-gnu.zip"
      bat_dir="bat-${version}-x86_64-pc-windows-gnu"
      ;;
    *)  echo "Nothing to do";;
  esac
}

help() {
  cat << EOF
usage: $0 [OPTIONS]

    -h               Show this message
    -o               Prepare the tarball for off-line pc use.
EOF
}

check_platform

# for opt in "$@"; do
while getopts ho opt; do
  case "$opt" in
    h)
      help
      exit 0
      ;;
    o)
      get_file "$url/$file"
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
if ! (try_curl "$url/$file" || try_wget "$url/$file"); then
  set +o pipefail
  die "Failed to download with curl and wget"
fi
set +o pipefail

cp "$bat_dir/bat" "$install_prefix"

# Copy autocomplete file to bash_library directory, it will load-in during terminal bootstrap.  
[ -z "${ZSH_VERSION-}" ] || cp "$bat_dir/autocomplete/bat.zsh" "$dir_path/../bash_library/"
[ -z "${BASH_VERSION-}" ] || cp "$bat_dir/autocomplete/bat.bash" "$dir_path/../bash_library/"

echo -e "\n${install_prefix}/bat is now available."
