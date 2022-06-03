# nc extra commands.
nc() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    case $1 in
    send)   # login ssh before execute command.
        shift
        tar cvf - "$1" | nc "$2" 49152
        ;;
    recv)
        nc -l 49152 | tar xvf -
        ;;
    *)
        $exec_path "$@"
        ;;
    esac
    unset exec_path
}
