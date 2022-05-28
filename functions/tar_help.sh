# help_Samba guide.
help_tar() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} Samba [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-, ${Color_Off}

${Yellow}Example:
    ${Yellow}tar zcvf new_name.tar.gz --transform s/old_name/new_name/ old_name/${Color_Off}

"
    ;;
    esac
}