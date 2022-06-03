# help_split guide.
help_split() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} split [options] ...
${Yellow}Global options:${Color_Off}
	${Green}mb${Color_Off}
		Split file into multiple files of certain size.
	${Green}num${Color_Off}
		Split file into multiple files of split number.
	${Green}merage${Color_Off}
		Merge file from split file.

${Yellow}Example:${Color_Off}
	${Yellow}split mb 100 '/home/calvin/Shared_Folder/Finish/test.tar.gz'${Color_Off}
	${Yellow}split num 3 '/home/calvin/Shared_Folder/Finish/test.tar.gz'${Color_Off}
	${Yellow}split merage \"test.part\" \"test.tar.gz\"${Color_Off}
"
    ;;
    esac
}