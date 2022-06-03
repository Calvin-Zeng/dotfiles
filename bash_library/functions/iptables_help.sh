# help_iptables guide.
help_iptables() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} iptables [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}save${Color_Off}
        Calls all plugins with the save argument, causing them to save the currently-loaded rules to persistent storage.
    ${Green}restore${Color_Off}
        iptables-restore and ip6tables-restore are used to restore IP and IPv6 Tables from data specified on STDIN or in file.
    ${Green}show${Color_Off}
        -f, filter
            Show iptables filter rules.
        -n, nat
            Show iptables nat rules.
        -m, mangle
            Show iptables mangle rules.
    ${Green}clear${Color_Off}
        -f, filter
            Clear iptables filter rules.
        -n, nat
            Clear iptables nat rules.
        -m, mangle
            Clear iptables mangle rules.

${Yellow}Redhat & CentOS iptables command${Color_Off}
    ${Yellow}chkconfig --list | grep iptables${Color_Off}
    ${Yellow}chkconfig iptables on${Color_Off}
    ${Yellow}service iptables save${Color_Off}

${Yellow}Redhat & CentOS iptables file path:${Color_Off}
    ipv4: /etc/sysconfig/iptables
    ipv6: /etc/sysconfig/ip6tables
${Yellow}Ubuntu 16.04 & 18.04 file path:${Color_Off}
    ipv4: /etc/iptables/rules.v4
    ipv6: /etc/iptables/rules.v6

${Yellow}History:${Color_Off}
    ${Yellow}iptables -A INPUT -j DROP${Color_Off}
    ${Yellow}iptables -I INPUT 1 -i enp0s3 -p tcp --dport 22 -j DROP${Color_Off}
    ${Yellow}iptables -I INPUT 1 -i enp0s3 -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT${Color_Off}
    ${Yellow}iptables -I INPUT 2 -s 192.168.50.30/32 -i enp0s3 -p tcp --dport 22 -j ACCEPT${Color_Off}
    ${Yellow}iptables -D INPUT 2
    ${Yellow}iptables --flush [CHAIN NAME]
    ${Yellow}iptables -X [CHAIN NAME]${Color_Off}
" | less -r
    ;;
    esac
}