# help_date guide.
help_date() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} date [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-t, tostamp${Color_Off}
        Covert readable time to timestamp.

        FORMAT
        \"Sun, 29 Feb 2004 16:21:42 -0800\"
        \"2020-04-13 17:13:00\"
        (last|next) (second|minute|hour|day|month|year)
        X (seconds|minutes|hours|days|months|years) ago, where X=...,-1,0,1,2,3,...
        X (second|minute|hour|day|month|year) , where X=...,-1,0,1,2,3,...
        yesterday, tomorrow
        @XXXXXXXXX, where XXXXXXXX seconds since epoch
    ${Green}-f, frstamp${Color_Off}
        Covert timestamp to readable time.

${Yellow}Example:${Color_Off}
    ${Yellow}date tostamp now${Color_Off}
    ${Yellow}date tostamp \"2020-04-13 17:13:00\"${Color_Off}
    ${Yellow}date tostamp \"10 minute\"${Color_Off}
    ${Yellow}date frstamp 1271149980 1586707200 1586769149${Color_Off}
"
    ;;
    esac
}