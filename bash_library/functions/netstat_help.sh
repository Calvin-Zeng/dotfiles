# help_netstat guide.
help_netstat() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} netstat [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}port${Color_Off}
        listing open port of system.
    ${Green}tcp${Color_Off}
        listing tcp connection.
    ${Green}udp${Color_Off}
        listing udp connection.
    ${Green}software${Color_Off}
        Show right now state of software.
    ${Green}route${Color_Off}
        Show route table of system.
    ${Green}statistics${Color_Off}
        Show right now interface ststus of system.
    ${Green}state - Show right now state count of system.${Color_Off}
        NULL
            Show right now all state count by state.
        [ESTABLISHED/LISTEN/CLOSE/...]
            Show right now state IP of specific state.
        [ESTABLISHED/LISTEN/CLOSE/...]  [App name]
            Show right now state count of specific application.
    ${Green}state:${Color_Off}
        ESTABLISHED
               The socket has an established connection.

        SYN_SENT
               The socket is actively attempting to establish a connection.

        SYN_RECV
               A connection request has been received from the network.

        FIN_WAIT1
               The socket is closed, and the connection is shutting down.

        FIN_WAIT2
               Connection is closed, and the socket is waiting for a shutdown from the remote end.

        TIME_WAIT
               The socket is waiting after close to handle packets still in the network.

        CLOSE  The socket is not being used.

        CLOSE_WAIT
               The remote end has shut down, waiting for the socket to close.

        LAST_ACK
               The remote end has shut down, and the socket is closed. Waiting for acknowledgement.

        LISTEN
                The socket is listening for incoming connections.
                Such sockets are not included in the output unless you specify the --listening (-l) or --all (-a) option.

        CLOSING
               Both sockets are shut down but we still don't have all our data sent.

        UNKNOWN
               The state of the socket is unknown.
" | less -r
    ;;
    esac
}