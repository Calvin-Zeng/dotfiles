# help_fp guide.
help_fp() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} fp [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-s, swap${Color_Off}
        Quickly swap two file.
    ${Green}-b, backup${Color_Off}
        Backup file to file.XX-XX-XX_XX-XX-XX format.
    ${Green}-rb, revert${Color_Off}
        Revert file.XX-XX-XX_XX-XX-XX name to file.
    ${Green}-r, rename${Color_Off}
        -l, low
            convert filename up-case to low-case.
        -u, up
            convert filename low-case to up-case.
        [OPTION]
            regular expression
    ${Green}-n, number${Color_Off}
        Simple to remane file by number.

${Yellow}Example:${Color_Off}
    ${Yellow}fp swap a.txt b.txt${Color_Off}
    ${Yellow}fp backup test1.txt${Color_Off}
    ${Yellow}fp revert test1.20.04.13-10\:59\:57${Color_Off}
    ${Yellow}fp rename -l TEST.sh${Color_Off}
    ${Yellow}fp rename -u test.sh${Color_Off}
    ${Yellow}fp rename 's/test1/kkk/' test1.txt test.sh${Color_Off}
    ${Yellow}fp -n \"@(kkk*|yyy*)\" \"test\" 3 \".sh\"${Color_Off}
    ${Yellow}fp -n \"file*\" \"test\" 3 \".sh\"${Color_Off}
        output:
        Rename file to test001.sh File.
        Rename file1 to test002.sh File.

"
    ;;
    esac
}