# help_diff guide.
help_diff() {
    case $1 in
    *)
echo -e $"
    - ${Green} Diff to compare both file and generate patch.:${Color_Off}
        ${Yellow}diff -Naur \"oldfile\" \"newfile\" > XXX.patch${Color_Off}

    - ${Green} Apply patch file:${Color_Off}
        ${Yellow}patch < XXX.patch test.c${Color_Off}

    - ${Green} Undo diff from .patch file:${Color_Off}
        ${Yellow}patch -R < XXX.patch test.c${Color_Off}
"
    ;;
    esac
}