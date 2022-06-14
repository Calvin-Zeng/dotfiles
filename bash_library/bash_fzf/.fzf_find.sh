akf () {
  [ ! $(command -v ack) ] && echo "Not found ack." && return 1
  for args in $@; do
    case "$args" in
      -*i*|-*w*) opt+="$args " && shift;;
      *) break;;
    esac
  done
  _tmp=$(ack -l $opt "$1" | $(which fzf) --preview "bat --terminal-width $((COLUMNS-5)) --color \"always\" {} | ack $opt --context=10 \"$1\"")
  [ -d "$_tmp" ] && cd "$_tmp"
  if [ -f "$_tmp" ]; then
    if [ ! -n "$SSH_CLIENT" ] && [ ! -n "$SSH_TTY" ] && [ $(command -v subl) ]; then
      subl "$_tmp"
    else
      vi "$_tmp"
    fi
  fi
  unset args opt _tmp
}

gpf () {
  [ ! $(which grep) ] && echo "Not found grep." && return 1
  for args in $@; do
    case "$args" in
      -*i*|-*w*) opt+="$args " && shift;;
      *) break;;
    esac
  done
  _tmp=$(grep -Inrl $opt "$1" | $(which fzf) --preview "bat --terminal-width $((COLUMNS-5)) --color \"always\" {} | grep $opt --color=\"always\" -C 10 \"$1\"")
  [ -d "$_tmp" ] && cd "$_tmp"
  if [ -f "$_tmp" ]; then
    if [ ! -n "$SSH_CLIENT" ] && [ ! -n "$SSH_TTY" ] && [ $(command -v subl) ]; then
      subl "$_tmp"
    else
      vi "$_tmp"
    fi
  fi
  unset args opt _tmp
}
