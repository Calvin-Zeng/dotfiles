#!/bin/bash
# Use this script to install plugin, or run :PlugInstall in VIM.

# plugin - vim-plug
# https://github.com/junegunn/vim-plug
if [ ! -f "autoload/plug.vim" ]; then
  url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  curl -fLo autoload/plug.vim --create-dirs $url || \
    wget -N $url -P autoload/
fi

[ ! -d "plugged" ] && mkdir plugged
# plugin - nerdtree
# https://github.com/preservim/nerdtree
[ ! -d "plugged/nerdtree" ] && git clone https://github.com/preservim/nerdtree.git plugged/nerdtree

# plugin - Tagbar
# https://github.com/preservim/tagbar
[ ! -d "plugged/tagbar" ] && git clone https://github.com/preservim/tagbar.git plugged/tagbar

# plugin - Auto Pairs
# https://github.com/jiangmiao/auto-pairs
[ ! -d "plugged/auto-pairs" ] && git clone https://github.com/jiangmiao/auto-pairs.git plugged/auto-pairs

# plugin - Tabular
# https://github.com/godlygeek/tabular
[ ! -d "plugged/tabular" ] && git clone https://github.com/godlygeek/tabular.git plugged/tabular

# plugin - vim-easymotion
# https://github.com/easymotion/vim-easymotion
[ ! -d "plugged/vim-easymotion" ] && git clone https://github.com/easymotion/vim-easymotion.git plugged/vim-easymotion

# plugin - UltiSnips
# https://github.com/sirver/ultisnips
[ ! -d "plugged/ultisnips" ] && git clone https://github.com/SirVer/ultisnips.git plugged/ultisnips

# plugin - vim-easycomplete
# https://github.com/jayli/vim-easycomplete
[ ! -d "plugged/vim-easycomplete" ] && git clone https://github.com/jayli/vim-easycomplete.git plugged/vim-easycomplete

# plugin - vim-snippets
# https://github.com/honza/vim-snippets
# [ ! -d "plugged/vim-snippets" ] && git clone https://github.com/honza/vim-snippets.git plugged/vim-snippets

# plugin - vim-visual-multi
https://github.com/mg979/vim-visual-multi
[ ! -d "plugged/vim-visual-multi" ] && git clone https://github.com/mg979/vim-visual-multi.git plugged/vim-visual-multi

# Theme - molokai
# https://github.com/tomasr/molokai
if [ ! -f "colors/molokai.vim" ]; then
  url="https://github.com/tomasr/molokai/raw/master/colors/molokai.vim"
  curl -fLo colors/molokai.vim --create-dirs || \
    wget -N $url -P colors/
fi
