#!/bin/bash

##########################################################################
# Shellscript:	avg - calculate the average of a column
# Author     :	Heiner Steven <heiner.steven@odn.de>
# Date       :	19.09.94
# Category   :	Desktop
# SCCS-Id.   :	@(#) avg	1.3 05/07/15
##########################################################################
# Changes
# 22.06.95 hs	specify the column as argument (0.2)
# 19.05.96 hs	Allow multiple files, -f and -t option (0.3)
# Reference:
# http://www.shelldorado.com/scripts/cmds/avg.txt
##########################################################################

PN=`basename "$0"`			# program name
VER='1.3'

Col=1					# Column
Delim=					# Field delimiter

Usage () {
    echo >&2 "$PN - calculate the average, $VER (stv '94)
usage: $PN [-f column] [-t delim] [file ...]
    -f: specify column (default is $Col)
    -t: field delimiter (default is whitespace)"
    exit 1
}

Msg () {
    for i
    do echo "$PN: $i" >&2
    done
}

Fatal () { Msg "$@"; exit 1; }

#set -- `getopt hf: "$@"`
while getopts :hf: opt
do
    case "$opt" in
	f)	Col="$OPTARG";;
	t)	Delim="$OPTARG";;
	h)	Usage;;
	*)	Usage;;
    esac
done
shift `expr ${OPTIND:-1} - 1`

case "$Col" in
    *[!0-9]*)	Fatal "no column number: $Col";;
esac

awk ${Delim:+-F "$Delim"} '
    (NF >= '$Col' && $'$Col' != "") { Sum += $'$Col'; n++; }
    END { if ( n ) printf "%g\n", Sum / n; }
' "$@"