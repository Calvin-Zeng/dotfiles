# ~/.bashrc: executed by bash(1) for non-login shells.
# The original .bashrc file path is in: /etc/skel/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# export PATH="$PATH:/home/${USER}/example/bin/"
# export CMAKE_ROOT=$HOME/cmake-3.2.2

[ -d "$HOME/local/bin" ] && export PATH="${PATH:+${PATH}:}$HOME/local/bin"

# Setup fzf
# ---------
if [ ! $(command -v fzf) ] && [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.bash" 2> /dev/null

# dotfiles hook.
dotfiles_dir="$HOME/dotfiles"
[ -f "$dotfiles_dir/bash_library/.bash_profile" ] && source "$dotfiles_dir/bash_library/.bash_profile";

unset dotfiles_dir color_prompt force_color_prompt
