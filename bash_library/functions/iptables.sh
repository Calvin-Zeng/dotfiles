# iptables extra commands.
iptables() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local param
    case $1 in
    save)
        sudo netfilter-persistent save
        return 0
        ;;
    restore)
        shift
        sudo iptables-restore "$@"
        return 0
        ;;
    show)
        shift
        case $1 in
        -f|filter)
            shift
            param="${param} -nvL --line-numbers"
            ;;
        -n|nat)
            shift
            param="${param} -t nat -nvL --line-numbers"
            ;;
        -m|mangle)
            shift
            param="${param} -t mangle -nvL --line-numbers"
            ;;
        esac
        ;;
    clear)
        shift
        case $1 in
        -f|filter)
            shift
            param="${param} -F"
            ;;
        -n|nat)
            shift
            param="${param} -t nat -X"
            ;;
        -m|mangle)
            shift
            param="${param} -t mangle -X"
            ;;
        esac
        ;;
    esac
    echo "Parameter: ${param}" "$@"
    # TBD:functions - Need type the password?
    sudo $exec_path ${param} "$@"
    unset exec_path param
}
