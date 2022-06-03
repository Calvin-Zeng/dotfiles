# ps extra commands.
ps() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    case $1 in
    top)    # Show friendly system information.
        shift
        local param="$1"
        echo "System Info:"
        uptime
        echo "Memory Info:"
        free -h
        echo "Process Info:"
        case "$param" in
        cpu)
            echo -en "$Red$On_White User      PID  PPID ▼ CPU% MEM% Use-MEM SoftwareName $Color_Off$On_White $Color_Off \r\n"
            ;;
        mem)
            echo -en "$Red$On_White User      PID  PPID CPU% ▼ MEM% Use-MEM SoftwareName $Color_Off$On_White $Color_Off \r\n"
            ;;
        *)
            echo -en "  ps top ${Red}cpu/mem${Color_Off} [name]\r\n"
            return 0
            ;;
        esac
        if [[ $# = 2 ]]; then
            while :; do ps -Aeo user,pid,ppid,%cpu,%mem,rss,comm --sort=-%"${param}" | grep "$2"; sleep 1; done
        else
            ps -Aeo user,pid,ppid,%cpu,%mem,rss,cmd --sort=-%"${param}" | head -n 20
        fi
        ;;
    pid)    # Show specific process pid and command.
        shift
        ps aux | grep "$1" | grep -v 'grep'| awk '{$1=$3=$4=$5=$6=$7=$8=$9=$10=""; print}' | grep "$1" --color=auto
        ;;
    kill)   # Show specific process pid and command before confirm terminated
            # Also can use "killall" command
        shift
        case $1 in
        r)  # 1 : SIGHUP - Restart application.
            ps aux | grep "$2" | grep -v 'grep'| awk '{print $2}'| tr '\n' '\0' | xargsc -L 1 kill -1
            ;;
        c)  # 2 : SIGINT - terminated like CTRL-C.
            ps aux | grep "$2" | grep -v 'grep'| awk '{print $2}'| tr '\n' '\0' | xargsc -L 1 kill -2
            ;;
        f)  # 9 : SIGKILL - Force terminated.
            ps aux | grep "$2" | grep -v 'grep'| awk '{print $2}'| tr '\n' '\0' | xargsc -L 1 kill -9
            ;;
        n)  # 15 : SIGTERM - Normal terminated.
            ps aux | grep "$2" | grep -v 'grep'| awk '{print $2}'| tr '\n' '\0' | xargsc -L 1 kill -15
            ;;
        *)
            echo "Usage: ps kill [r/c/f/n/q] [process name]"
            ;;
        esac
        ;;
    aux)
        ps -aux | less
        ;;
    *)
        $exec_path "$@"
        ;;
    esac
    unset exec_path param
}
