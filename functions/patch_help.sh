# help_patch guide.
help_patch() {
    case $1 in
    *)
echo -e $"
    - ${Green} Patch file from command-line. ${Color_Off}
    ${Yellow} patch -p1 << EOF ${Color_Off}
    ${Yellow} ... ${Color_Off}
    ${Yellow} EOF ${Color_Off}
"
    ;;
    esac
}