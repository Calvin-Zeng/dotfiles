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

# Find content of file from directory.
# also can use:
# ack -i "option2hex"
# -n, --no-recurse
#   No descending into subdirectories.
# -r, -R, --recurse
#   Recurse into sub-directories. This is the default and just here for compatibility with
#   grep. You can also use it for turning --no-recurse off.
find_content() {
    # Check arguments illegal or not.
    if [[ $# -lt 2 ]]; then
            echo $"Use help_find_content() know how to use."
        return 0
    fi
    local grep_param=" -li -n --color=auto "
    local find_param
    local i=0
    while [ $# -gt 0 ]
    do
        case "$1" in
        -w|whole)
            grep_param="-w ${grep_param}"
            ;;
        -l|line)
            grep_param="-C ${2} ${grep_param}"
            shift
            ;;
        -e|exclude)
            shift
            local multi_param="-o -samefile"
            while [ $# -gt 2 ]
            do
                if [ $i == 0 ]; then
                    find_param="-samefile $1"
                    let i=i+1
                else
                    find_param="$find_param $multi_param $1"
                fi
                shift
            done
            ;;
        *)
            break
            ;;
        esac
        if [ $# == 2 ]; then
            break
        else
            shift
        fi
    done
    if [ $i == 0 ]; then
        if [ -n "$fzf_prompt" ]; then
            find $1 -type f -exec grep -Ii ${grep_param} "$2" {} + |\
            fzf -m --preview "bat --terminal-width $((COLUMNS/2-5)) --color \"always\" {} | grep --color=\"always\" -i -C 5 \"$2\""|\
            xargs --no-run-if-empty subl
        else
            find $1 -type f -exec grep ${grep_param} "$2" {} +
        fi
    else
        if [ -n "$fzf_prompt" ]; then
            find $1 \( $find_param \) -prune -o -type f -exec grep -Ii ${grep_param} "$2" {} + |\
            fzf -m --preview "bat --terminal-width $((COLUMNS/2-5)) --color \"always\" {} | grep --color=\"always\" -i -C 5 \"$2\""|\
            xargs --no-run-if-empty subl
        else
            echo "Exclude=${find_param}"
            echo "FindPath FindString=$@"
            echo "==========Result=========="
            find $1 \( $find_param \) -prune -o -type f -exec grep ${grep_param} "$2" {} +
        fi
    fi
    unset grep_param find_param i multi_param
}

# Find duplicate of file from directory.
find_duplicate_files() {
    if [ -n "$fzf_prompt" ]; then
        find -not -empty -type f -printf "%s\n" | \
        sort -rn | \
        uniq -d | \
        xargs -I{} -n1 find -type f -size {}c -print0 | \
        xargs -0 md5sum | \
        sort | \
        uniq -w32 --all-repeated=separate | \
        fzf -m --preview 'bat --terminal-width $((COLUMNS/2-5)) --color "always" {+2} ' | \
        awk '{print $2 }' | tr '\n' '\0' | \
        xargs -p -0 -L 1 --no-run-if-empty rm
    else
        find -not -empty -type f -printf "%s\n" | \
        sort -rn | \
        uniq -d | \
        xargs -I{} -n1 find -type f -size {}c -print0 | \
        xargs -0 md5sum | \
        sort | \
        uniq -w32 --all-repeated=separate
    fi
}

# Support fzf.
[ -f ~/.fzf.bash ] || return

previewack () {
    ack -li "$1" |\
    fzf -m --ansi --preview "bat --terminal-width $((COLUMNS/2-5)) --color \"always\" {} | grep --color=\"always\" -i -C 5 \"$1\""|\
    xargs --no-run-if-empty subl
}

previewacklist () {
    cat "$1" |\
    fzf --multi --color=dark --cycle --border --ansi --preview-window=up:80% --preview "ack -H \"$2\" {}"
}

previewgrep () {
    grep -Iinrl "$1" |\
    fzf -m --ansi --preview "bat --terminal-width $((COLUMNS/2-5)) --color \"always\" {} | grep --color=\"always\" -i -C 5 \"$1\""|\
    xargs --no-run-if-empty subl
}

previewgreplist () {
    cat "$1" |\
    fzf --multi --color=dark --cycle --border --ansi --preview-window=up:80% --preview "grep -Iinr --color=\"always\" -C 5 \"$2\" {}"
}
