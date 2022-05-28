# help_tftp guide.
help_tftp() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} tftp [options] ...
${Yellow}Global options:${Color_Off}
	${Green}getf${Color_Off}
		Get file via tftp.
	${Green}putf${Color_Off}
		Put file via tftp.

${Yellow}Example:${Color_Off}
	${Yellow}tftp getf LocalFilePath RemoteFilePath RemoteServerIP${Color_Off}
	${Yellow}tftp putf LocalFilePath RemoteFilePath RemoteServerIP${Color_Off}
"
    ;;
    esac
}