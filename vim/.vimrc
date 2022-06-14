" Restart Vim, and run the :PlugInstall statement to install your plugins.
call plug#begin()

Plug '~/.fzf'
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'jayli/vim-easycomplete'

call plug#end()

"Color Scheme:
source $HOME/dotfiles/vim/.vim_theme_Molokai

" Plugins setting
source $HOME/dotfiles/vim/.vim_fzf
source $HOME/dotfiles/vim/.vim_nerdtree
source $HOME/dotfiles/vim/.vim_tabular
source $HOME/dotfiles/vim/.vim_easymotion
source $HOME/dotfiles/vim/.vim_easycomplete
source $HOME/dotfiles/vim/.vim_ultisnips

" Previous state when open file.
source $HOME/dotfiles/vim/functions/.vim_previoustate
" Switch the simple / copy mode.
source $HOME/dotfiles/vim/functions/.vim_switchfullsimplemode

" others
source $HOME/dotfiles/vim/.vim_keymap
source $HOME/dotfiles/vim/.vim_misc
