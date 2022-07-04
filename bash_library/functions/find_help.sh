# help_find guide.
help_find() {
    case $1 in
    *)
echo -e $"
    # refer to https://askubuntu.com/questions/972121/how-to-find-all-hardlinks-in-a-folder
    ${Green}Find all hardlinks in a folder?${Color_Off}
        find -type f -links +1

    # refer to https://stackoverflow.com/questions/16282618/finding-files-that-are-not-hard-links-via-a-shell-script
    ${Green}Finding files that are *not* hard links via a shell script${Color_Off}
        find . -type f -links 1 -print
"
    ;;
    esac
}
