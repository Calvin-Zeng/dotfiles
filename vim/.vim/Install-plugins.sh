#!/bin/bash
# Use this script to install plugin, or run :PlugInstall in VIM.

download_git_repo() {
  [ ! -d "$2" ] && git clone $1 $2
}

download_plugin_file() {
  if [ ! -f "$2/$3" ]; then
    url="$1"
    curl -fLo $2/$3 --create-dirs $url || \
      wget -N $url -P $2/
  fi
}

# plugin - vim-plug
# https://github.com/junegunn/vim-plug
download_plugin_file "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" autoload plug.vim

# Theme - molokai
# https://github.com/tomasr/molokai
download_plugin_file "https://github.com/tomasr/molokai/raw/master/colors/molokai.vim" colors molokai.vim

[ ! -d "plugged" ] && mkdir plugged
download_git_repo "https://github.com/preservim/nerdtree.git" plugged/nerdtree
download_git_repo "https://github.com/preservim/tagbar.git" plugged/tagbar
download_git_repo "https://github.com/jiangmiao/auto-pairs.git" plugged/auto-pairs
download_git_repo "https://github.com/godlygeek/tabular.git" plugged/tabular
download_git_repo "https://github.com/easymotion/vim-easymotion.git" plugged/vim-easymotion
download_git_repo "https://github.com/SirVer/ultisnips.git" plugged/ultisnips
download_git_repo "https://github.com/jayli/vim-easycomplete.git" plugged/vim-easycomplete
# download_git_repo "https://github.com/honza/vim-snippets.git" plugged/vim-snippets
download_git_repo "https://github.com/mg979/vim-visual-multi.git" plugged/vim-visual-multi
