" Restart Vim, and run the :PlugInstall statement to install your plugins.
call plug#begin()

Plug '~/.fzf'
Plug 'preservim/nerdtree'

call plug#end()

"Color Scheme:
source $HOME/dotfiles/vim/.vim_theme_Molokai

" Plugins setting
source $HOME/dotfiles/vim/.vim_fzf
source $HOME/dotfiles/vim/.vim_nerdtree

" others
source $HOME/dotfiles/vim/.vim_keymap
source $HOME/dotfiles/vim/.vim_misc