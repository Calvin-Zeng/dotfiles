# plink extra commands.
plink() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    case $1 in
    ssh)    # login ssh before execute command.
        shift
        sudo plink -ssh "$2"@"$1" -pw "$3" -m "$4"
        ;;
    serial) # Connection serial port by plink.
        shift
        sudo plink -serial "$1" -sercfg "$2",8,1,N,N
        ;;
    *)
        $exec_path "$@"
        ;;
    esac
    unset exec_path
}