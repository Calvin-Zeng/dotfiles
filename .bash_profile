# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=4000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load the shell dotfiles.
for file in $dotfiles_dir/.{git-prompt.sh,loading-prompt.sh,split-pwd.sh,system_logo.sh,bash_{color,prompt,aliases,completion}}; do
    # echo "Loading the $file"
    [ -f "$file" ] && [ -r "$file" ] && source "$file";
done;
unset file;
