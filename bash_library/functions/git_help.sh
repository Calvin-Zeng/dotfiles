# help_git guide.
help_git() {
    case $1 in
    ad|add)
echo -e $"
    - ${Green} Add file that all tracked files in the entire working tree are updated. ${Color_Off}
    ${Yellow} git add -u ${Color_Off}

    - ${Green} Update the index not only where the working tree has a file matching <pathspec>
      but also where the index already has an entry. This adds, modifies, and removes index. ${Color_Off}
    ${Yellow} git add -A . ${Color_Off}
"
    ;;
    br|branch)
echo -e $"
    - ${Green} Rename both a Git local and remote branch name. ${Color_Off}
    ${Yellow}@ Rename the local branch to the new name
    git branch -m <old_name> <new_name>
    @ Delete the old branch on remote - where <remote> is, for example, origin
    git push <remote> --delete <old_name>
    @ Or shorter way to delete remote branch [:]
    git push <remote> :<old_name>
    @ Push the new branch to remote
    git push <remote> <new_name>
    @ Reset the upstream branch for the new_name local branch
    git push <remote> -u <new_name>
    Ref: repository - How do I rename both a Git local and remote branch name? - Stack Overflow -
    https://stackoverflow.com/questions/30590083/how-do-i-rename-both-a-git-local-and-remote-branch-name ${Color_Off}

    - ${Green} List all branch.  ${Color_Off}
    ${Yellow} git branch -a ${Color_Off}

    - ${Green} Deleted branch.  ${Color_Off}
    ${Yellow} git branch -d [name] ${Color_Off}

    - ${Green} Show commit log which git branch.  ${Color_Off}
    ${Yellow} git branch -a --contains 21deff763785bd844cf57df387bd8d6f4d4d8cb5 ${Color_Off}
"
    ;;
    co|checkout)
echo -e $"
    - ${Green} Create new branch and switch to it.  ${Color_Off}
    ${Yellow} git checkout -b [new-branch name] [target branch] ${Color_Off}

    - ${Green} Checkout file to specific commit state.  ${Color_Off}
    ${Yellow} git checkout [SHA-id] -- [filename] ${Color_Off}

    - ${Green} Checkout all file to last commit state.  ${Color_Off}
    ${Yellow} git checkout -- [filename] ${Color_Off}

    - ${Green} Checkout to remote branch and create local branch. ${Color_Off}
    ${Yellow} git checkout [origin/new_branch] -b [new_branch] ${Color_Off}
"
    ;;
    re|reset)
echo -e $"
    - ${Green} Undo a last commit.  ${Color_Off}
    ${Yellow} git reset [--soft] HEAD^ ${Color_Off}

    - ${Green} Undo file stagging. ${Color_Off}
    ${Yellow} git reset HEAD [filename] ${Color_Off}
"
    ;;
    pu|push)
echo -e $"
    - ${Green} Push local branch to remote repository. ${Color_Off}
    ${Yellow} git push -u origin [BranchName] ${Color_Off}

    - ${Green} Delete remote branch with name.  ${Color_Off}
    ${Yellow} git push [origin] --delete ${Color_Off}
"
    ;;
    cfg|config)
echo -e $"
    - ${Green} Set the git global or repository config.  ${Color_Off}
    ${Yellow}git config --global user.name
    git config user.name
    git config --global user.email
    git config user.email ${Color_Off}

    - ${Green} Show remote repo url.  ${Color_Off}
    ${Yellow} git config --get remote.origin.url ${Color_Off}

    - ${Green} Set shorten command alias.  ${Color_Off}
    ${Yellow} git config --global alias.st status ${Color_Off}


"
    ;;
    cle|clean)
echo -e $"
    - ${Green} Remove untracked directories in addition to untracked files.
     If an untracked directory is managed by a different Git repository, it is not removed by default.  ${Color_Off}
    ${Yellow} git clean -d ${Color_Off}

    - ${Green} Remove untracked files. ${Color_Off}
    ${Yellow} git clean -f ${Color_Off}
"
    ;;
    df|dft|difftool)
echo -e $"
    - ${Green} Open file different with hash/branch/two-commit. ${Color_Off}
    ${Yellow} git difftool [COMMIT_HASH] [file_name]
     git difftool [BRANCH_NAME] [file_name]
     git difftool [COMMIT_HASH_1] [COMMIT_HASH_2] [file_name]
    ${Color_Off}

    - ${Green} Export specific commit of git diff. ${Color_Off}
    ${Yellow} git diff -- . ':(exclude).config' --no-color > diff.patch
     git diff ef79ab07 2c621b0a8 --no-color > diff.patch
    ${Color_Off}

"
    ;;
    rev|review)
echo -e $"
    - ${Green} Modify gerrit changes.  ${Color_Off}
    ${Yellow}@ Show all remote repository url.
    git remote -v
    @ Fetch from gerrit and checkout to this stage.
    git fetch ssh://Carl_Zeng@10.10.67.6:29418/mtk-openwrt-cc-v3.6 refs/changes/55/3355/1 && git checkout FETCH_HEAD
    [Do_something]
    @ Edit commit
    git commit --amend [--no-edit]
    @ Commit new gerrit review.
    git review

    @ Switch to workspace branch.
    git checkout [branch]
    @ Reset old gerrit review commit.
    git reset --hard HEAD^ ${Color_Off}
"
    ;;
    lg|log)
echo -e $"
    - ${Green} Show log detail. ${Color_Off}
    ${Yellow} git log -p ${Color_Off}

    - ${Green} Show log file changed list. ${Color_Off}
    ${Yellow} git log --stat ${Color_Off}

    - ${Green} Show log pretty format(checksum only). ${Color_Off}
    ${Yellow} git log --pretty=oneline ${Color_Off}
"
    ;;
    rem|remote)
echo -e $"
    - ${Green} Update all local repository from remote. ${Color_Off}
    ${Yellow} git remote update ${Color_Off}
"
    ;;
    bd|bundle)
echo -e $"
    - ${Green} Create a repository to bundle file. ${Color_Off}
    ${Yellow} git bundle create ../x.bundle master HEAD ${Color_Off}

    - ${Green} Create a repository to bundle file which only contain newly added commits. ${Color_Off}
    ${Yellow} git bundle create ../x_a_b.bundle v2 a02da0e3..a2492538 HEAD ${Color_Off}

    - ${Green} Create a repository to bundle file by tag. ${Color_Off}
    ${Yellow} git bundle create ../x.bundle last-bundled..master HEAD ${Color_Off}
    ${Yellow} git tag -f last-bundled master ${Color_Off}

    - ${Green} Clone a repository from bundle file. ${Color_Off}
    ${Yellow} git cl x.bundle master ${Color_Off}

    - ${Green} Fetch a branch of repository to an exist repository folder. ${Color_Off}
    ${Yellow} git fe ../x.bundle branch1:branch ${Color_Off}

    - ${Green} Update the repository folder by bundle file. ${Color_Off}
    ${Yellow} git pl ../x.bundle ${Color_Off}
"
    ;;
    submodule)
echo -e $"
    ${Green}Remove the submodule${Color_Off}
        git rm <path-to-submodule>
        rm -rf .git/modules/<path-to-submodule>
        git config --remove-section submodule.<path-to-submodule>
    # refer to https://stackoverflow.com/questions/1260748/how-do-i-remove-a-submodule
"
    ;;
    *)
echo -e $"
${Yellow}Get started with Git:${Color_Off}
    ${Green}Create a new repository${Color_Off}
        git clone git@gitlab.com:CiLunZeng/playground.git
        cd playground
        git switch -c main
        touch README.md
        git add README.md
        git commit -m \"add README\"
        git push -u origin main
    ${Green}Push an existing folder${Color_Off}
        cd existing_folder
        git init --initial-branch=main
        git remote add origin git@gitlab.com:CiLunZeng/playground.git
        git add .
        git commit -m \"Initial commit\"
        git push -u origin main
    ${Green}Push an existing Git repository${Color_Off}
        cd existing_repo
        git remote rename origin old-origin
        git remote add origin git@gitlab.com:CiLunZeng/playground.git
        git push -u origin --all
        git push -u origin --tags

${Yellow}Basic Git status:${Color_Off}
    ${Red}A-${Color_Off} = Untracked files
    A  = Tracked / Unmodified
    ${Blue}A+${Color_Off} = Changes not staged for commit
    ${Green}B${Color_Off}  = Changes to be committed
    ${Yellow}C${Color_Off}  = Committed - without Push

###
${Red}A-${Color_Off} -> ${Green}B${Color_Off}  : git add <FILE>
A  -> ${Red}A-${Color_Off} : git rm --cached <FILE>
A  -> ${Blue}A+${Color_Off} : modified file
${Blue}A+${Color_Off} -> A  : git checkout -- <FILE>
${Blue}A+${Color_Off} -> ${Green}B${Color_Off}  : git add <FILE>
${Green}B${Color_Off}  -> ${Red}A-${Color_Off} : git rm --cached <FILE>
${Green}B${Color_Off}  -> Delete not retaining files : git rm -f <FILE>
${Green}B${Color_Off}  -> ${Blue}A+${Color_Off} : git reset HEAD <FILE>
${Green}B${Color_Off}  -> ${Yellow}C${Color_Off}  : git commit
${Yellow}C${Color_Off}  -> ${Green}B${Color_Off}  : git reset --soft HEAD^
Modify the last commit : git commit --amend

#####   
                  --mixed     --soft      --hard
Commit -> ${Green}B${Color_Off}       constant    constant    Abandom
Commit -> ${Blue}A+${Color_Off}/A    Abandom     constant    Abandom
#####
"
    ;;
    esac
}
