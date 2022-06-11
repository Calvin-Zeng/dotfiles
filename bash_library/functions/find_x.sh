# find_X extra commands.
find_something() {
    # Check arguments illegal or not.
    if [[ ! $# -ge 1 ]]; then
            echo $"Use help_find_something() know how to use."
        return 0
    fi
    # Processing..
    case $1 in
    -d|dir)
        if [ -n "$fzf_prompt" ]; then
            find "$2" -iname "*$3*" -type d | grep -i "$3" | previewdir
        else
            find "$2" -iname "*$3*" -type d | grep -i "$3"
        fi
        ;;
    -f|file)
        if [ -n "$fzf_prompt" ]; then
            find "$2" -iname "*$3*" -type f | grep -i "$3" | previewfile
        else
            find "$2" -iname "*$3*" -type f | grep -i "$3"
        fi

        ;;
    *)
        locate -i "*$1*" | grep '^'$(pwd) | grep -i "$1"
        ;;
    esac
}

# Find duplicate of file from directory.
find_duplicate_files() {
  find -not -empty -type f -printf "%s\n" | \
  sort -rn | \
  uniq -d | \
  xargs -I{} -n1 find -type f -size {}c -print0 | \
  xargs -0 md5sum | \
  sort | \
  uniq -w32 --all-repeated=separate
}
