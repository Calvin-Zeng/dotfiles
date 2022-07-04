OLD_TERM=$TERM

export PAGER=vi
# Fix the midnight commander keyboard fn-key doesn't work on ssh session and tmux.
if [[ ( -n "$SSH_CLIENT" || -n "$SSH_TTY" ) && ( -n "$TMUX" ) ]]; then
  export TERM=xterm-color
fi
[ -f $HOME/local/bin/vim ] && export PAGER="$HOME/local/bin/vim"

MC_USER=`whoami`
MC_PWD_FILE="${TMPDIR-/tmp}/mc-$MC_USER/mc.pwd.$$"
$(which mc) -P "$MC_PWD_FILE" "$@"

if test -r "$MC_PWD_FILE"; then
	MC_PWD="`cat "$MC_PWD_FILE"`"
	if test -n "$MC_PWD" && test -d "$MC_PWD"; then
		cd "$MC_PWD"
	fi
	unset MC_PWD
fi

rm -f "$MC_PWD_FILE"
unset MC_PWD_FILE
unset MC_USER
export TERM=$OLD_TERM
export PAGER=less
