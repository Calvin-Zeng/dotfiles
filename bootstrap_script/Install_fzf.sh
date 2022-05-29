#!/bin/bash

script_path=$(readlink -f $0)
repo_path=$(dirname $script_path)

version=0.30.0
offline_file="offline_fzf.tar.gz"

die() {
  echo $1
  exit 1
}

extract() {
  [ ! -f $1 ] && die "File $1 not found, exit."
  if [[ $1 =~ tar.gz$ ]]; then
    tar -xzf "$1" -C "$2"
  else
    unzip -o "$1" -d "$2"
  fi
  return $?
}

install_fzf_with_internet() {
  if [ ! -d ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --bin
  else
    cd ~/.fzf
    git pull
  fi
  echo -e "\n~/.fzf/bin/fzf is now available. You can optionally add ~/.fzf/bin/ to your \$PATH."}
}

install_fzf_without_internet() {
    cat << EOF
No internet, Please follow the instruction to action.
Run the script on online system:
    $0 --offline

and copy $offline_file on off-line system path to $repo_path

After that, On Off-line system:
    $0 --install

EOF
  extract $offline_file ./
  [ $? -eq 0 ] || die "Extract $offline_file failed! exit."
  extract .fzf.tar.gz ~/
  [ $? -eq 0 ] || die "Extract .fzf.tar.gz failed! exit."
  extract fzf-$version-* ~/.fzf/bin/
  [ $? -eq 0 ] || die "Extract fzf binary file failed! exit."
  rm .fzf.tar.gz fzf-$version-*
  echo -e "\n~/.fzf/bin/fzf is now available. You can optionally add ~/.fzf/bin/ to your \$PATH."
}

download_fzf_for_offline() {
  # Try to download repository
  git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
  tar czf ".fzf.tar.gz" ".fzf"
  rm -rf .fzf
  # Try to download binary executable
  archi=$(uname -sm)
  local url
  url=https://github.com/junegunn/fzf/releases/download/$version
  case "$archi" in
    Darwin\ arm64)   wget "$url/fzf-$version-darwin_arm64.zip"     ;;
    Darwin\ x86_64)  wget "$url/fzf-$version-darwin_amd64.zip"     ;;
    Linux\ armv5*)   wget "$url/fzf-$version-linux_armv5.tar.gz"   ;;
    Linux\ armv6*)   wget "$url/fzf-$version-linux_armv6.tar.gz"   ;;
    Linux\ armv7*)   wget "$url/fzf-$version-linux_armv7.tar.gz"   ;;
    Linux\ armv8*)   wget "$url/fzf-$version-linux_arm64.tar.gz"   ;;
    Linux\ aarch64*) wget "$url/fzf-$version-linux_arm64.tar.gz"   ;;
    Linux\ *64)      wget "$url/fzf-$version-linux_amd64.tar.gz"   ;;
    FreeBSD\ *64)    wget "$url/fzf-$version-freebsd_amd64.tar.gz" ;;
    OpenBSD\ *64)    wget "$url/fzf-$version-openbsd_amd64.tar.gz" ;;
    CYGWIN*\ *64)    wget "$url/fzf-$version-windows_amd64.zip"    ;;
    MINGW*\ *64)     wget "$url/fzf-$version-windows_amd64.zip"    ;;
    MSYS*\ *64)      wget "$url/fzf-$version-windows_amd64.zip"    ;;
    Windows*\ *64)   wget "$url/fzf-$version-windows_amd64.zip"    ;;
    *)               echo "Nothing to do";;
  esac
  # Achrive the two files to tar.gz
  tar czf "$offline_file" ".fzf.tar.gz" fzf-$version*
  rm ".fzf.tar.gz" fzf-$version*
}

check_internet() {
  if $(nc -zw1 "google.com" "443" 2> /dev/null); then
    return 0
  fi
  return 1
}

help() {
  cat << EOF
usage: $0 [OPTIONS]
    --help               Show this message
    --install            Check internet and install fzf with --bin
    --offline            Prepare the tarball for off-line pc use.
EOF
}

if [[ $# -eq 0 ]]; then
  help
  exit 0
fi

for opt in "$@"; do
  case $opt in
    --help)
      help
      exit 0
      ;;
    --install)
      check_internet
      [[  $? -eq 1 ]] && install_fzf_without_internet || install_fzf_with_internet
      ;;
    --offline)
      check_internet
      [[  $? -eq 1 ]] && die "Check your internet connectivity."
      download_fzf_for_offline
      ;;
    *)
      echo "unknown option: $opt"
      help
      exit 1
      ;;
  esac
done
