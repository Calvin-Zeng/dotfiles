# help_owrt guide.
help_owrt() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} owrt [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-v, debug${Color_Off}
        Equivalent V=s
    ${Green}-l, linux${Color_Off}
        [Compile|clean|install] linux kernel.
        Equivalent target/linux/<action>
    ${Green}-m, make${Color_Off}
        Compile package.
        Equivalent package/<name>/compile
        Equivalent package/<name>/install
    ${Green}-c, clean${Color_Off}
        Clean package.
        Equivalent package/<name>/clean
    ${Green}-r, rebuild${Color_Off}
        Equivalent -c + -m
    ${Green}-i, install${Color_Off}
        Install package.
        Equivalent package/<name>/install
    ${Green}-u, update${Color_Off}
        OpenWRT feeds update.

${Yellow}Also debug messgae when compile error:${Color_Off}
    ${Yellow}make V=s 2>&1 | tee build.log | grep -i -E \"^make.*(error|[12345]...Entering dir)\"${Color_Off}
${Yellow}Skipping failed packages:${Color_Off}
    {Yellow}IGNORE_ERRORS=1 make <make options>${Color_Off}
"
    ;;
    esac
}