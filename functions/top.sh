# top extra commands.
top() {
	local exec_path="$(which "${FUNCNAME[0]}")"
    case $1 in
        cpu)
            top -b -o +%CPU | head -n 17
            ;;
        mem)
            top -b -o +%MEM | head -n 17
            ;;
        *)
            $exec_path "$@"
            ;;
    esac
}
