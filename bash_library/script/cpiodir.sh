#!/bin/bash
##########################################################################
# Title      :	cpiodir - pack directory into cpio-file
# Author     :	Heiner Steven <heiner.steven@odn.de>
# Date       :	1994-08-18
# Category   :	File Utilities
# SCCS-Id.   :	@(#) cpiodir	1.4 11/07/27
##########################################################################
# Description
# Ref:
# www.shelldorado.com/scripts/cmds/cpiodir.txt - http://www.shelldorado.com/scripts/cmds/cpiodir.txt
##########################################################################

PN=`basename "$0"`			# Program name
VER='1.4'

Ext=.cpio.gz			# file extension for compressed cpio archive

usage () {
    echo "$PN - archive directory with cpio, $VER (stv '95)
usage: $PN [-d destination] directory [directory ...]
    -d:  destination directory for archive (default ist current directory)" >&2
    exit 1
}

msg () { echo "$PN:" "$@" >&2; }
fatal () { msg "$@"; exit 1; }

echon () {
    if [ X"$ECHON" = X ]
    then
	# Determine how to "echo" without newline: "echo -n" or "echo ...\c"
	if [ X`echo -n` = X-n ]
	then ECHON=echo; E_N=; NNL="\c"
	else ECHON=echo; E_N=-n; NNL=
	fi
    fi
    $ECHON $E_N "$*$NNL"
}

set -- `getopt d:h "$@"` || usage
while [ $# -gt 0 ]
do
    case "$1" in
	-d)	Dest="$2"; shift;;
	--)	shift; break;;
	-h)	usage;;
	-*)	usage;;
	*)	break;;			# First file name
    esac
    shift
done

[ $# -gt 0 ] || usage

[ -w "${Dest:=.}" ] || fatal "no right to write to destination directory"

for dir
do
    [ -d "$dir" ] || { msg "$dir is no directory - ignored"; continue; }
    [ -r "$dir" -a -x "$dir" ] || {
	msg "no read and execute rights to $dir - ignored"; continue
    }
    case "$dir" in
	/*)	msg "do not start directory names with '/' - ignored"
		continue;;
    esac

    A="$Dest/${dir}$Ext"		# archive name
    echon "$A -	" >&2

    trap "rm -f $A > /dev/null 2>&1; msg '$A deleted'; exit 2" 1 2 3 13 15
    find "$dir" -type f -print | cpio -oc | gzip > "$A"
done