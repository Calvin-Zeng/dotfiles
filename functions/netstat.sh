# netstat extra commands.
netstat() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local param
    case $1 in
    port)   # listing open port.
        param="-ntlp"
        ;;
    tcp)    # listing tcp connection.
        param="-at"
        ;;
    udp)    # listing udp connection.
        param="-au"
        ;;
    software)   # Show right now state of software.
        param="-pt"
        ;;
    route)  # Show route table of system.
        param="-r"
        ;;
    statistics) # Show right now interface ststus of system.
        param="-i"
        ;;
    state)
        shift
        param="$1"
        if [ $# == 0 ]; then
            # Show right now state count of system.
            netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
        elif [ $# == 2 ]; then
            # Show right now state count of specific application.
            netstat -anpt | grep "$2" | grep "${param}" | awk -F "[ :]*" '{print $4}' | uniq -c
        else
            # Show right now specific state count of system.
            echo "state: ${param}"
            netstat -an | grep "${param}" | awk '/^tcp/ {print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -nr
        fi
        return 0
        ;;
    esac
    sudo $exec_path "${param}" "$@"
    unset exec_path param
}
