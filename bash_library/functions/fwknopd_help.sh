# help_fwknopd guide.
help_fwknopd() {
    case $1 in
    *)
echo -e $"
    - ${Green} Listing rules in fwknopd iptables chains...${Color_Off}
        ${Yellow}sudo fwknopd --fw-list${Color_Off}

    - ${Green} Fwknop tutorial:${Color_Off}
        http://www.cipherdyne.org/fwknop/docs/fwknop-tutorial.html"
    ;;
    esac
}