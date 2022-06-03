# help_top guide.
help_top() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} top [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}cpu${Color_Off}
        sort by CPU uasge.
    ${Green}mem${Color_Off}
        sort by Memory uasge.
"
    ;;
    esac
}