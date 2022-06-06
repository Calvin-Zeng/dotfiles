#!/bin/bash

# exit on error
set -e

script_path=$(readlink -f $0)
dir_path=$(dirname $script_path)

version=4126
file="sublime_text_build_${version}_x64.tar.xz"
url="https://download.sublimetext.com/$file"
install_prefix=$HOME/app_images

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
  if [[ $1 =~ tar.xz$ ]]; then
    curl -fL $1 | tar -xJf -
  else
    local temp=${TMPDIR:-/tmp}/temp.zip
    curl -fLo "$temp" $1 && unzip -o "$temp" && rm -f "$temp"
  fi
}

try_wget() {
  command -v wget > /dev/null &&
  if [[ $1 =~ tar.xz$ ]]; then
    wget -O - $1 | tar -xJf -
  else
    local temp=${TMPDIR:-/tmp}/temp.zip
    wget -O "$temp" $1 && unzip -o "$temp" && rm -f "$temp"
  fi
}

[ -d "$install_prefix" ] || mkdir -p $install_prefix

cd $install_prefix

[ -f "$dir_path/$file" ] && tar xf "$dir_path/$file" -C "$install_prefix" || 
if ! (try_curl $url || try_wget $url); then
  set +o pipefail
  die "Failed to download with curl and wget"
fi
set +o pipefail

echo -e "\n${install_prefix}/sublime_text is now available, Please run command on top dotfiles directory"
echo -e "    stow sublime-text"
