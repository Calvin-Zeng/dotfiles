# tftp extra commands.
tftp() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    case $1 in
    getf)   # Get file via tftp
        shift
        tftp -l "$1" -r "$2" -g "$3"
        ;;
    putf)   # Put file via tftp
        shift
        tftp -l "$1" -r "$2" -p "$3"
        ;;
    *)
        $exec_path "$@"
        ;;
    esac
    unset exec_path
}
