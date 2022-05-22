# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# dotfiles hook.
dotfiles_dir="$HOME/dotfiles"
[ -f "$dotfiles_dir/.bash_profile" ] && source "$dotfiles_dir/.bash_profile";

unset dotfiles_dir color_prompt force_color_prompt
