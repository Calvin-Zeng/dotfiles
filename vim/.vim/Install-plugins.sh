#!/bin/bash

# plugin - vim-plug
# https://github.com/junegunn/vim-plug
curl -fLo autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# plugin - nerdtree
# https://github.com/preservim/nerdtree
[ ! -d "plugged" ] && mkdir -p plugged
git clone https://github.com/preservim/nerdtree.git plugged/nerdtree  # or :PlugInstall

# Theme - molokai
# https://github.com/tomasr/molokai
curl -fLo colors/molokai.vim --create-dirs \
  https://github.com/tomasr/molokai/raw/master/colors/molokai.vim
