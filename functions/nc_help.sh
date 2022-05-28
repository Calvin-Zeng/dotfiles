# help_nc guide.
help_nc() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} nc [options] ...
${Yellow}Global options:${Color_Off}
	${Green}send${Color_Off}
		Send file by nc.
	${Green}recv${Color_Off}
		Receive file by nc.

${Yellow}Example:${Color_Off}
	Transfer file:
		${Yellow}nc send [file] [IP]${Color_Off}
	Receive file:
		${Yellow}nc recv${Color_Off}

${Yellow}Original:${Color_Off}
	Port 49152 - 65535 is Dynamic.
	Example1:
		Receive:
			${Yellow}nc -l 5000 > my.jpg${Color_Off}
		Transfer:
			${Yellow}nc hostB.com 5000 < my.jpg${Color_Off}

	Example2:
		${Yellow}nc -l 5000 | dd of=sdb-backup.img.gz${Color_Off}
		${Yellow}dd if=/dev/sdb | gzip -c | nc hostB.com 5000${Color_Off}

	Example3:
		${Yellow}nc -l 5000 | gzip -d | sudo dd of=/dev/sdb${Color_Off}
		${Yellow}nc hostA.com 5000 < sdb-backup.img.gz${Color_Off}
"
    ;;
    esac
}