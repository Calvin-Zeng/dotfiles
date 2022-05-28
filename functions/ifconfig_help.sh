# help_ifconfig guide.
help_ifconfig() {
    case $1 in
    *)
echo -e $"
${Yellow}If you setup a connection using Network Manager, it is stored in${Color_Off}
/etc/NetworkManager/system-connections/
Or default is in /etc/network/interfaces

${Yellow}Template:${Color_Off}
    ${Green}Static IP:${Color_Off}
        auto [interface name]
        iface [interface name] inet static # static ip
        address 10.159.xx.xx # IP address
        netmask 255.255.255.0 # Network mask
        gateway 10.159.xx.xx # Default gateway
        dns-nameservers 168.95.1.1 # DNS 1
        dns-nameservers 8.8.8.8 # DNS 2
    ${Green}DHCP IP:${Color_Off}
        auto [interface name]
        iface [interface name] inet dhcp
    ${Green}PPPOE IP:${Color_Off}
        Pending.

${Yellow}Restart network service${Color_Off}
${Yellow}sudo service network-manager restart${Color_Off}
${Yellow}sudo /etc/init.d/networking restart${Color_Off}
${Yellow}sudo systemctl restart networking${Color_Off}
"
    ;;
    esac
}