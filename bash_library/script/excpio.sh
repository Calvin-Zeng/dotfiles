#!/bin/bash
##########################################################################
# Title      :	excpio - extract directories from cpio archive
# Author     :	Heiner Steven <heiner.steven@odn.de>
# Date       :	1994-09-23
# Requires   :
# Category   :	File Utilities
# SCCS-Id.   :	@(#) excpio	1.2 03/12/19
##########################################################################
# Description
# Ref:
# www.shelldorado.com/scripts/cmds/excpio.txt - http://www.shelldorado.com/scripts/cmds/excpio.txt
##########################################################################

PN=`basename "$0"`			# Program name
VER='1.2'

usage () {
    echo >&2 "$PN - extract directories from cpio archive, $VER (stv '94)
usage: $PN [-hutv] archive [file|directory ...]
    -u:   unconditionally overwrite existing files
    -t:   show table of contents
    -v:   (verbose) print all file names
    -h:   (help)    print this help

archive is the name of the created cpio archive. The extension
.cpio is appended, if not already present.

If no file or directory name is specified, all files and
directories (including subdirectories) are default."

    exit 1
}

msg () {
    for i
    do echo "$PN: $i" >&2
    done
}
fatal () { msg "$@"; exit 1; }

CpioOpt=dm
while [ $# -gt 0 ]
do
    case "$1" in
	-h)	usage;;
	-v)	CpioOpt="${CpioOpt}v";;
	-u)	CpioOpt="${CpioOpt}u";;
	-t)	CpioOpt="${CpioOpt}t";;
	--)	shift; break2;;		# Simulate getopt
	*)	break;;			# File name
    esac
    shift
done

[ $# -lt 1 ] && usage

Archive="$1"; shift
[ -r "$Archive" ] || Archive="$Archive.cpio"
[ -r "$Archive" ] || fatal "Archive $Archive not found"

cpio -ic${CpioOpt} "$@" < $Archive