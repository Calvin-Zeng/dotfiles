# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
dotfiles_dir="/home/calvin/Work/dotfiles"
[ -f "$dotfiles_dir/.bash_profile" ] && source "$dotfiles_dir/.bash_profile";
# [ -f "$HOME/.shellprofile/.bashrc" ] && source "$HOME/.shellprofile/.bashrc";

unset dotfiles_dir color_prompt force_color_prompt
