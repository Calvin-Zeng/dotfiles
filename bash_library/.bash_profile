# Change terminal Mandarin Chinese to English.
# export LANG=zh_TW.UTF-8
# export LANG=en_US

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Enable the extglob option.
shopt -s extglob

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=4000
HISTTIMEFORMAT='%F %T '

# refer to https://gist.github.com/Angles/3273505
# Don't save trivial 1 to 4 character commands on the history list
ignore+="?:??:???:????:"
# Don't save any commands about ls, ln.
ignore+="l?(l|ll|a|sd|f|s|n) *:"
# Change permission.
ignore+="?(s)@(000|600|644|664|700|755|777) *:"
# Change directories path.
ignore+="up?(s)?( *):.....:"
# Develop commands
ignore+="@(git|vi?(s|S)|subl|ctags|meld)?( *):"
# Miscellaneous.
ignore+="@([hH]istory|man|i[fw]config|[c|b]at|c[d|p]|fd|mv|rm|which|help|uptime|df|ps|kill|tmux|tree|fzf|t|source?(bashrc)|showkey|ascii|md5sum|tar|mkdir|echo|dirname)?( *):"
HISTIGNORE=$ignore

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
    $dotfiles_dir/bash_library/bat.{bash,zsh} \
    $dotfiles_dir/bash_library/rg.{bash,fish} \
    $dotfiles_dir/bash_library/_rg{,.ps1} \
    $dotfiles_dir/bash_library/functions/* \
    $HOME/.extra \
)
for file in ${SOURCE_LIST[@]}; do
    if [ -f "$file" ] && [ -r "$file" ]; then
        # echo "Loading the $file"
        source "$file";
    fi
done;
unset file SOURCE_LIST;

[ -d "$dotfiles_dir/bash_library/script" ] && [ ! "$PATH" == *$dotfiles_dir/bash_library/script* ] && export PATH="${PATH:+${PATH}:}$dotfiles_dir/bash_library/script"
