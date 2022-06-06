# patchs extra commands.

# patch from folder, it can include many patch files.
patchs() {
    string=
    for args in $@; do
        [ $1 == "-R" ] && string+="$1 " && shift
        [ $1 == "-dry" ] && string+='--dry-run ' && shift
        [[ $1 == *-p* ]] && string+="$1 " && shift
    done
    [ -d $1 ] &&
    for file in $1/*.{diff,patch}; do
        [ -f "$file" ] || continue
        confirm "patch $string < $file? ([Y]/N): "
        [ $? -eq 0 ] && patch $string < $file
    done
    unset file string
}
