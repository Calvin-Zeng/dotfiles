" Restart Vim, and run the :PlugInstall statement to install your plugins.
call plug#begin()

Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'jayli/vim-easycomplete'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'vim-scripts/ShowMarks'

call plug#end()

"Color Scheme:
source $HOME/dotfiles/vim/.vim_theme_Molokai

let mapleader = '\'

" Plugins setting
source $HOME/dotfiles/vim/.vim_fzf
source $HOME/dotfiles/vim/.vim_nerdtree
source $HOME/dotfiles/vim/.vim_tabular
source $HOME/dotfiles/vim/.vim_easymotion
source $HOME/dotfiles/vim/.vim_easycomplete
source $HOME/dotfiles/vim/.vim_ultisnips
source $HOME/dotfiles/vim/.vim_visual-multi
source $HOME/dotfiles/vim/.vim_showmarks

" Previous state when open file.
source $HOME/dotfiles/vim/functions/.vim_previoustate
" Switch the simple / copy mode.
source $HOME/dotfiles/vim/functions/.vim_switchfullsimplemode
" WindowsSwap - https://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
" Move to the window to mark for the swap via ctrl-w movement
"   Type \mw
" Move to the window you want to swap
"   Type \pw
source $HOME/dotfiles/vim/functions/.vim_windowswap
" Auto save / restore the session by path
" Then use those cmd to exit vim.
"   :wa - save all tabs / unsaved buffers
"   :xa/:wqa - save all tabs / unsaved buffers and exit Vim
"   :qa - exit vim (will warn if unsaved buffers exist)
source $HOME/dotfiles/vim/functions/.vim_autosession
source $HOME/dotfiles/vim/functions/.vim_tabline

" others
source $HOME/dotfiles/vim/.vim_keymap
source $HOME/dotfiles/vim/.vim_misc
