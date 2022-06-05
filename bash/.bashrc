# ~/.bashrc: executed by bash(1) for non-login shells.
# The original .bashrc file path is in: /etc/skel/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# export CMAKE_ROOT=$HOME/cmake-3.2.2

# Manual compiled applications will put in the $HOME/local/bin directory.
# And the other will put in the $HOME/.local/bin directory(like: python-inst).
PATH_LIST=(\
    $HOME/local/bin \
    $HOME/.local/bin \
)
for tmp_path in ${PATH_LIST[@]}; do
    [ -d "$tmp_path" ] && [ ! "$PATH" == *$tmp_path* ] && export PATH="${PATH:+${PATH}:}$tmp_path"
done;
unset tmp_path PATH_LIST

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
