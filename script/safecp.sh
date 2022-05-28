#!/bin/bash

##########################################################################
# Title      :	safecp - don't let cp overwrite a file
# Author     :	Heiner Steven <heiner.steven@odn.de>
# Date       :	1996-01-23
# Requires   :	
# Category   :	File Utilities
# SCCS-Id.   :	@(#) safecp	1.5 05/05/12
##########################################################################
# Description
#	If "cp" is called with two files as arguments, it will
#	overwrite the second file. This script asks for
#	confirmation before doing so.
#	Reference
#	http://www.shelldorado.com/scripts/cmds/safecp.txt
##########################################################################

PN=`basename "$0"`			# Program name
VER='1.5'

echon () {
    if [ X"$ECHON" = X ]
    then
	# Determine how to "echo" without newline: "echo -n" or "echo ...\c"
	if [ X`echo -n` = X-n ]
	then ECHON=echo; NNL="\c"
	else ECHON="echo -n"; NNL=""
	fi
    fi
    $ECHON "$*$NNL"
}

Verbose=false
Force=false
Args=
while [ $# -gt 0 ]
do
    case "$1" in
	-v)	Verbose=true;;
	--)	shift; break;;
	-f)	Force=true
		Args="${Args:+$Args }$1"
		;;
	-*)	Args="${Args:+$Args }$1";;
	*)	break;;			# First file name
    esac
    shift
done

# Special case: "cp file1 file2": ask for confirmation
if [ $# -eq 2 ] && [ $Force = false ] && [ -f "$2" ] && [ -s "$2" ]
then
    while :
    do
	echon >&2 "$PN: overwrite file <$2> (j/y/n)? "
	read OK < /dev/tty || exit 0
	case "$OK" in
	    [jJyY]*)	break;;
	    [nN]*)	echo >&2 "$PN: nothing copied."; exit 0;;
	esac
    done
fi

if [ $Verbose = true ]
then
    for target				# find last argument
    do :
    done

    for file
    do
        [ x"$file" = x"$target" ] && continue
	echo >&2 "$file"
	cp $Args "$file" "$target"
    done
else
    exec cp $Args "$@"
fi