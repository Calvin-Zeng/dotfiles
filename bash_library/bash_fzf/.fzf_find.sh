akf () {
  [ ! $(command -v ack) ] && echo "Not found ack." && return 1
  for args in $@; do
    case "$args" in
      -*i*|-*w*) opt+="$args " && shift;;
      *) break;;
    esac
  done
  _folder=$(ack -l $opt "$1" | fzf --preview "bat --terminal-width $COLUMNS --color \"always\" {} | ack $opt --context=10 \"$1\"")
  [ -d "$_folder" ] && cd "$_folder"
  unset args opt _folder
}

gpf () {
  [ ! $(which grep) ] && echo "Not found grep." && return 1
  for args in $@; do
    case "$args" in
      -*i*|-*w*) opt+="$args " && shift;;
      *) break;;
    esac
  done
  _folder=$(grep -Inrl $opt "$1" | fzf --preview "bat --terminal-width $COLUMNS --color \"always\" {} | grep $opt --color=\"always\" -C 10 \"$1\"")
  [ -d "$_folder" ] && cd "$_folder"
  unset args opt _folder
}
