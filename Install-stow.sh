#!/bin/bash
# Delete the symbolic link by stow, run stow -D in the dotfiles directory.
# E.g.
#   stow -D bash

die() {
  echo $1
  exit 1
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
  read -r -p "Setup the $package? ([Y]/N): " answer
  case $answer in
      ""|[Yy]* ) stow --target "$HOME" "$package";;
      [Nn]* ) continue;;
      * ) echo "Please answer Y or N, Ignore!"; continue;;
  esac
done;
unset package;
