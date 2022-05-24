# Change terminal Mandarin Chinese to English.
# export LANG=zh_TW.UTF-8
# export LANG=en_US

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=4000
HISTTIMEFORMAT='%F %T '
HISTIGNORE="history*:History*:man*:ll*:ls*:source*:uptime*:pwd:ifconfig:cd*:help*:git_*:_FZF_*:t *"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# export PATH="$PATH:/home/${USER}/example/bin/"
# export CMAKE_ROOT=$HOME/cmake-3.2.2

# Load the shell dotfiles.
for file in $dotfiles_dir/.{git-prompt.sh,loading-prompt.sh,split-pwd.sh,system_logo.sh,bash_{color,prompt,aliases,completion,variables,keymap,fzf}}; do
    # echo "Loading the $file"
    [ -f "$file" ] && [ -r "$file" ] && source "$file";
done;
unset file;
