# help_svn guide.
help_svn() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} svn [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}cl${Color_Off}
        Add custom file to changelist.
    ${Green}clm${Color_Off}
        Add \"modified\" file to changelist.
    ${Green}ci${Color_Off}
        Equivalent svn commit
    ${Green}lg${Color_Off}
        Show log of repository.
    ${Green}pl${Color_Off}
        Update repository to latest commit.
    ${Green}re${Color_Off}
        Revet file to specific version.
    ${Green}reall${Color_Off}
        Revert all file to latest version.
        Also command: svn revert -R .
    ${Green}adall${Color_Off}
        Add all untracked files.

${Yellow}Example:${Color_Off}
    - ${Green} Revert to specific version:${Color_Off}
        ${Yellow}svn up -r 10 ./Test${Color_Off}
    - ${Green} Show repository information:${Color_Off}
        ${Yellow}svn info${Color_Off}
    - ${Green} Also grep repository url:${Color_Off}
        ${Yellow}svn info | grep \"URL\" | cut -d\" \" -f2${Color_Off}
    - ${Green} Show different with version to version of file:${Color_Off}
        ${Yellow}svn diff -r 2:3 rules.txt${Color_Off}
    - ${Green} Add custom file to changelist:${Color_Off}
        ${Yellow}svn cl list a.txt b.txt c.txt${Color_Off}
    - ${Green} Commit changelist's file:${Color_Off}
        ${Yellow}svn commit --cl list${Color_Off}
    - ${Green} Copy svn main repo to branch repo:${Color_Off}
        ${Yellow}svn cp http://url/trunk/ http://url/branches/v15.9 -r 1000 -m 'For release'${Color_Off}
"
    ;;
    esac
}