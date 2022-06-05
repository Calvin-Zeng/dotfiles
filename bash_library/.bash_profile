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

# Load the shell dotfiles.
SOURCE_LIST=(\
    $dotfiles_dir/bash_library/.bash_color \
    $dotfiles_dir/bash_library/.{git-prompt.sh,loading-prompt.sh,split-pwd.sh,system_logo.sh} \
    $dotfiles_dir/bash_library/.bash_{prompt,aliases,completion,variables,keymap,fzf,others} \
    $dotfiles_dir/bash_library/functions/* \
    $HOME/.extra \
)
for file in ${SOURCE_LIST[@]}; do
    if [ -f "$file" ] && [ -r "$file" ]; then
        # echo "Loading the $file"
        source "$file";
    fi
done;
unset file;

[ -d "$dotfiles_dir/bash_library/script" ] && [ ! "$PATH" == *$dotfiles_dir/bash_library/script* ] && export PATH="${PATH:+${PATH}:}$dotfiles_dir/bash_library/script"
