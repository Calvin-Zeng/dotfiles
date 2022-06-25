#!/bin/bash

# exit on error
set -e

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)

version=13.0.0
url="https://github.com/BurntSushi/ripgrep/releases/download/$version/"

install_prefix=$HOME/.local/bin
work_dir="/tmp/ripgrep_tmp"

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
      file="ripgrep-$version-x86_64-apple-darwin.tar.gz"  
      ripgrep_dir="ripgrep-${version}-x86_64-apple-darwin"
      ;;
    Linux\ armv*)
      file="ripgrep-$version-arm-unknown-linux-gnueabihf.tar.gz" 
      ripgrep_dir="ripgrep-${version}-arm-unknown-linux-gnueabihf"
      ;;
    Linux\ *64)
      file="ripgrep-$version-x86_64-unknown-linux-musl.tar.gz" 
      ripgrep_dir="ripgrep-${version}-x86_64-unknown-linux-musl"
      ;;
    Windows*\ *64)
      file="ripgrep-$version-x86_64-pc-windows-gnu.zip"  
      ripgrep_dir="ripgrep-${version}-x86_64-pc-windows-gnu"
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
[ -d "$install_prefix/../share/man/man1" ] || mkdir -p $install_prefix/../share/man/man1

cd $work_dir

[ -f "$dir_path/$file" ] && tar xf "$dir_path/$file" -C "$work_dir" || 
if ! (try_curl "$url/$file" || try_wget "$url/$file"); then
  set +o pipefail
  die "Failed to download with curl and wget"
fi
set +o pipefail

cp "$ripgrep_dir/rg" "$install_prefix"
cp "$ripgrep_dir/doc/rg.1" "$install_prefix/../share/man/man1"

# Copy autocomplete file to bash_library directory, it will load-in during terminal bootstrap.  
[ -z "${ZSH_VERSION-}" ] || cp "$ripgrep_dir/complete/_rg" "$dir_path/../bash_library/"
[ -z "${BASH_VERSION-}" ] || cp "$ripgrep_dir/complete/rg.bash" "$dir_path/../bash_library/"

echo -e "\n${install_prefix}/ripgrep is now available."
