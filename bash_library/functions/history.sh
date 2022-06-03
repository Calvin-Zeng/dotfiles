# history extra commands.
History() {
    case $1 in
    ?)
echo -e $"
${Yellow}Usage:${Color_Off} ${FUNCNAME[0]} [options]
${Yellow}Global options:${Color_Off}
    ${Green}-l, less${Color_Off}
        history in less mode.
"
        ;;
    -l|less)
        history | less
        ;;
    -q|query)
        shift
        local param=${1}
        echo "Runtime history:"
        history | awk -v var=^${1} '$4 ~ var' | grep ${1}
        ;;
    *)
        history "$@"
        ;;
    esac
}
