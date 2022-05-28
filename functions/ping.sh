# ping extra commands.
ping() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    case $1 in
    -s|simple)  # ping : Automatic replace redundant strings.
        shift
        ping $(echo "$1" | cut -d / -f 3)
        ;;
    *)
        $exec_path "$@"
        ;;
    esac
}
