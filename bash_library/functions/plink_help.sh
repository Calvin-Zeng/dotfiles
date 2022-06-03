# help_plink guide.
help_plink() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} plink [ssh|serial] ...
${Yellow}Global options:${Color_Off}
	${Green}ssh${Color_Off}
		Login ssh before execute command.
	${Green}serial${Color_Off}
		Connection serial console by plink.

${Yellow}Example:${Color_Off}
	${Yellow}plink ssh 192.168.1.1 Calvin 123456 sshcommand.sh${Color_Off}
	${Yellow}plink serial /dev/ttyUSBX 115200${Color_Off}
"
    ;;
    esac
}