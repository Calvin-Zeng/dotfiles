# gitignore from http://gitignore.io/
# Github .gitignore: https://github.com/github/gitignore
function gi() { curl -sL https://www.gitignore.io/api/$@ ;}

# Git push local exist repo to remote.
gitpoexist() {
    # Check arguments illegal or not.
    if [[ $# != 2 ]]; then
        echo -e "${ARG2} $FUNCNAME DIRECTORY REMOTEGITREPO ${EXAMPLES} $FUNCNAME project git@test.com:user/dev.git"
        return 0
    fi
    test -d "$1" || return 0
    # Processing..
    cd "$1"
    git init
    git remote add origin "$2" # git@test.com:user/dev.git
    git add .
    git commit -e
    git push -u origin master
}

# git archive --format=tar --remote=git@test.com:user1/dev.git branch fileordirectory | tar -x
gitarch() {
    git archive --format=tar --remote="$1" "$2" "$3" | tar -x
}

# Custom git completion
# source ~/.shellprofile/git_completions
