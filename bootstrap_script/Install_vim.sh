#!/bin/bash
# refer to https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source
#
# Version requirement
# NERD-tree    (6.10.16) >= 7.3
# Tagbar       (3.0.0)   >= 7.0
# UltiSnips    (3.2)     >= 8.0
# EasyComplete (2.2)     >= 8.2
# Visual-Multi (0.5.8)   >= 8.0
# EasyMotion   (3.0.1)   >= 7.0.3

# E: Not found package libgnome2-dev
# E: Not found package libgnomeui-dev
# E: Not found package libbonoboui2-dev
# Notice:
#   select python-dev-is-python2 not python-dev
#   select liblua5.1-0-dev not liblua5.1-dev

SCRIPT_PATH=$(readlink -f $0)
DIR_PATH=$(dirname $SCRIPT_PATH)
WORK_TOPDIR=/tmp/vim_tmp
INSTDIR=$HOME/local

NEEDVER="8.2"
PATCHES="1399"
VIMVER="$(vim --version | head -1 | awk '{print $5}')"
VIMPATCHES="$(vim --version | awk 'NR==2 {print $2}')"
VIMPATCHES=${VIMPATCHES#*-}

VIM_DIR="vim-$NEEDVER.$PATCHES"
FILE="v$NEEDVER.$PATCHES.tar.gz"
URL="https://github.com/vim/vim/archive/refs/tags/$FILE"

USE_ROOT=0

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
      cd "$DIR_PATH"
      check_internet
      [[ $? -eq 1 ]] && die "Check your internet connectivity."
      set -o pipefail
      echo "$URL"
      if ! (get_file $URL); then
        set +o pipefail
        die "Failed to download with curl and wget"
      fi
      unset URL;
      set +o pipefail
      echo "Download complete, Move all tarball to $WORK_TOPDIR on offline system."
      exit 0
      ;;
  esac
done
shift `expr ${OPTIND:-1} - 1`

# refer to https://stackoverflow.com/questions/16989598/bash-comparing-version-numbers
function version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

echo "Current the VIM version is $VIMVER.$VIMPATCHES"
echo "Installing the VIM $NEEDVER.$PATCHES"
echo "  with    root privilege will install in /usr/local"
echo "  without root privilege will install in $HOME/local"

if ! version_gt "$NEEDVER.$PATCHES" "$VIMVER.$VIMPATCHES" ; then
  die "Current VIM version: $VIMVER.$VIMPATCHES is newer than the $NEEDVER.$PATCHES"
fi

confirm() {
  read -r -p "$1" answer
  case $answer in
      ""|[Yy]* ) return 0;;
      [Nn]* ) return 1;;
      * ) echo "Please answer Y or N."; return 1;;
  esac
}

confirm "Use root privilege install vim? ([Y]/N): "
[ $? -eq 0 ] && read -r -p "Enter the root password:" SUDO_PASSWD && USE_ROOT=1 && INSTDIR="/usr/local";

if [ $USE_ROOT -eq 1 ]; then
  echo "Install depends library of vim."
  echo ${SUDO_PASSWD} | sudo -S apt-get -y install \
  libncurses5-dev libgtk2.0-dev libatk1.0-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
  python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

  echo "Remove vim if you have it already."
  echo ${SUDO_PASSWD} | sudo -S apt-get -y remove vim vim-runtime gvim
fi

if test ! -d $WORK_TOPDIR; then
    mkdir -p $WORK_TOPDIR
fi

# Compile vim
cd "$WORK_TOPDIR"
echo "$URL"
if tar -tf "$FILE" 1> /dev/null; then : ; else
  get_file "$URL" || exit 1
fi

rm -rf "$VIM_DIR"
tar xf "$FILE"
cd "$VIM_DIR"
if test -f src/main.c; then : ; else
  echo "vim source is incomplete" 2>&1
  exit 1
fi

echo "VIM $NEEDVER.$PATCHES will install in $INSTDIR"
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=$(python2-config --configdir) \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix="$INSTDIR"

make VIMRUNTIMEDIR="$INSTDIR/share/vim/vim$(echo "$VIMVER" | tr -d '.')" || exit 1
if [ $USE_ROOT -eq 1 ]; then
  echo ${SUDO_PASSWD} | sudo -S make install

  # Set vim as your default editor with update-alternatives.
  echo ${SUDO_PASSWD} | sudo -S update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
  echo ${SUDO_PASSWD} | sudo -S update-alternatives --set editor /usr/local/bin/vim
  echo ${SUDO_PASSWD} | sudo -S update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
  echo ${SUDO_PASSWD} | sudo -S update-alternatives --set vi /usr/local/bin/vim
else
  make install || exit 1
fi

echo "Install VIM $NEEDVER.$PATCHES - finished successfully."
