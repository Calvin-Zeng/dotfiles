# split extra commands.
split() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local param
    case $1 in
    mb)
        shift
        split -d -b "$1"MB "$2" "$2.part"
        ;;
    num)
        shift
        split -d -n "$1" "$2" "$2.part"
        ;;
    merage)
        shift
        cat "$1"* > "$2"
        ;;
    *)
        echo "Parameter: ${param}" "$@"
        $exec_path ${param} "$@"
        ;;
    esac
    unset exec_path param
}
