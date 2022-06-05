#!/bin/bash
# Delete the symbolic link by stow, run stow -D in the dotfiles directory.
# E.g.
#   stow -D bash

die() {
  echo $1
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

[ ! $(command -v stow) ] && die "Gnu stow not found, Aborting..."
[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"

packages_list=(\
  bash \
  mc \
  sublime-text \
  subversion \
  terminator \
  xfce \
)

for package in ${packages_list[@]}; do
  [ -d "$package" ] || continue;
  confirm "Setup the $package? ([Y]/N): "
  [ $? -eq 0 ] && stow --target "$HOME" "$package";
done;
unset package;
