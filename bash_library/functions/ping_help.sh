# help_ping guide.
help_ping() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} ping [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-s, simple${Color_Off}
        Fully URL. like:https://www.evernote.com/client/web#?an=true&
${Yellow}Example:${Color_Off}
    ping -s \"https://www.evernote.com/client/web#?an=true&\"
"
    ;;
    esac
}