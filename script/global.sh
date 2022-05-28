#!/bin/bash

##########################################################################
# Title      :	global - execute command in every subdirectory
# Author     :	Heiner Steven <heiner.steven@odn.de>
# Date       :	1994-09-29
# Requires   :	
# Category   :	File Utilities
# SCCS-Id.   :	@(#) global	1.4 18/04/27
##########################################################################
# Description
# Reference:
# http://www.shelldorado.com/scripts/cmds/global.txt
##########################################################################

PN=`basename "$0"`			# program name
VER='1.4'

usage () {
    echo >&2 "$PN - execute command in subdirectories, $VER (stv '94)
usage: $PN [-v] command [argument ...]
    -v   verbose, print current path

The given command is executed in every subdirectory of the current
directory, depth first. At last it is executed in the current
directory, too.

If the command contains embedded blanks, it must be enclosed in
quotation marks \"...\" or '...'."
    exit 1
}

err () {
    for i
    do echo "$PN: $i" >&2
    done
}

fatal () { err "$@"; exit 1; }
msg () { [ "$silent" = no ] && err "$@"; }

MyPath=$(realpath $0)

# Export "silent" to subshells, because parameters to the
# invoking shells are not passed to the subshells
: ${silent:=yes}		# yes/no, may be set from calling shell
export silent

while [ $# -gt 0 ]
do
    case "$1" in
	-v)	silent=no;;
	--)	shift; break;;		# End of parameter list
	-h)	usage;;
	-*)	usage;;
	*)	break;;			# Command
    esac
    shift
done

[ $# -lt 1 ] && usage

for i in *
do
    [ -d "$i" ] || continue
    cd -- "$i"
    "$MyPath" "$@"			# recurse into subdirectories
    cd ..
done
msg "`pwd`"
eval "$@"
