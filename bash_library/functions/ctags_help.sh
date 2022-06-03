# help_ctags guide.
help_ctags() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} ctags [options] ...
${Yellow}Global options:${Color_Off}
	${Green}exclude${Color_Off}
		Add pattern to a list of excluded files and directories.
	${Green}excludef [.ctagsignore]${Color_Off}
		Excluded files and directories from file list.
	${Green}dir${Color_Off}
		ctags current directory.
	${Green}append${Color_Off}
		Indicates whether tags generated from the specified files should be appended to those already present in the tag file
"
    ;;
    esac
}