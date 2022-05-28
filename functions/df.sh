# df extra commands.
df() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local param
    case $1 in
    space)
        shift
        param="-hT"
        ;;
    esac
    $exec_path ${param} "$@"
    unset exec_path param
}
