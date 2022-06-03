# date extra commands.
date() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local param="now"
    case $1 in
    -t|tostamp) # Covert readable time to timestamp.
        shift
        test -z "$1" || param="$1"
        echo "${param} timestamp equal to"
        date -d "${param}" +%s
        ;;
    -f|frstamp) # Covert timestamp to readable time.
        shift
        while [ $# -gt 0 ]
        do
            echo "$1 equal to readable date:"
            date '+%Y.%m.%d-%T' --date=@"$1"
            shift
        done
        ;;
    *)
        $exec_path "$@"
        ;;
    esac
}
