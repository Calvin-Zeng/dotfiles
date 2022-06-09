akf () {
  for args in $@; do
    case "$args" in
      -*i*|-*w*) opt+="$args " && shift;;
      *) break;;
    esac
  done
  _folder=$(ack -l $opt "$1" | fzf --preview "bat --terminal-width $((COLUMNS)) --color \"always\" {} | ack $opt --context=10 \"$1\"")
  [ -d "$_folder" ] && cd "$_folder"
  unset args opt _folder
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
