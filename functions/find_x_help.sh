# help_find_something guide.
help_find_something() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} find_something [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-d, dir${Color_Off}
        Find folder.
    ${Green}-f, file${Color_Off}
        Find file.

${Yellow}Example:${Color_Off}
    ${Yellow}find_something -f ./ \"mesh\"${Color_Off}
    ${Yellow}find_something -d ./ \"mesh\"${Color_Off}
    ${Yellow}find_something \"*wpa_supplicant*\"${Color_Off}

${Yellow}Also can use:${Color_Off}
    ${Yellow}ack -l \"captive_portal.c\"${Color_Off}
    Use 'sudo updatedb -U [Path]' before 'locate'.

${Yellow}Find something and use other application to execute:${Color_Off}
${Yellow}find -iname \"test*\" -print0 | xargs -i cat {} >> test4${Color_Off}
cat ./test3 ?...y
cat ./test4 ?...
cat test4
123
123
"
    ;;
    esac
}

# help_find_content guide.
help_find_content() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} find_content [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-w, whole${Color_Off}
        Select  only those lines containing matches that form whole words.
    ${Green}-l, line${Color_Off}
        Print  NUM  lines  of output context.
    ${Green}-e, exclude${Color_Off}
        Skip  any  command-line  directory  with  a  name  suffix that matches the pattern GLOB.

${Yellow}Example:${Color_Off}
    ${Yellow}find_content ./Menu/ \"define\"${Color_Off}
    ${Yellow}find_content -w ./Menu/ \"define\"${Color_Off}
    ${Yellow}find_content -w -l 3 -e ./kkk002/444/ ./ \"TypeLang\"${Color_Off}

${Yellow}Also can use:${Color_Off}
    ${Yellow}ack -i \"option2hex\"${Color_Off}
    ${Yellow}ack '^target_.*\('${Color_Off}
    ${Yellow}ack -C 0 '^target_.*\('${Color_Off}
"
    ;;
    esac
}