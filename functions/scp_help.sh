# help_scp guide.
help_scp() {
    case $1 in
    *)
echo -e $"
- ${Green} Copy local file to remote via ssh${Color_Off}
${Yellow}scp -r /path/folder1 myuser@192.168.0.1:/path/folder2${Color_Off}

- ${Green} Limit transmit speed 400 mbit/s${Color_Off}
${Yellow}scp -l 400 /path/file1 myuser@192.168.0.1:/path/file2${Color_Off}

- ${Green} Common command${Color_Off}
${Yellow}scp -rpC ...${Color_Off}
"
    ;;
    esac
}