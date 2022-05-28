# help_ps guide.
help_ps() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} ps [optios] ...
${Yellow}Global options:${Color_Off}
    ${Green}top${Color_Off}
        cpu or mem.
    ${Green}pid${Color_Off}
        name
            query pid by application name.
    ${Green}kill${Color_Off}
        r
            1 : SIGHUP - Restart application.
        c
            2 : SIGINT - terminated like CTRL-C.
        f
            9 : SIGKILL - Force terminated.
        n
            15 : SIGTERM - Normal terminated.
    ${Green}aux${Color_Off}
        ps -aux in less mode.
${Yellow}Example:${Color_Off}
    ${Yellow}ps top cpu${Color_Off}
    ${Yellow}ps top mem sublime_text${Color_Off}
    ${Yellow}ps pid sublime_text${Color_Off}
    ${Yellow}ps kill n sublime_text${Color_Off}
"
    History -q "${FUNCNAME[0]}"
    ;;
    esac
}