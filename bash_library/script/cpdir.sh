#!/bin/bash
##########################################################################
# Title      :  cpdir - copy directory structure
# Author     :  Heiner Steven <heiner.steven@odn.de>
# Date       :  1995-05-31
# Requires   :  
# Category   :  File Utilities
# SCCS-Id.   :  @(#) cpdir  1.4 06/03/15
##########################################################################
# Description
# Ref:
# www.shelldorado.com/scripts/cmds/cpdir.txt - http://www.shelldorado.com/scripts/cmds/cpdir.txt
##########################################################################

PN=`basename "$0"`          # Program name
VER='1.4'

unset CDPATH

CpioOpt=-pdm
FindOpt=

usage () {
    echo >&2 "$PN - copy directory hierarchies, $VER
usage: $PN [-dluv] entry [entry ...] target
    -d  copy only directory structure, without contents
    -l  link files instead of copying then (when possible)
    -u  unconditionally overwrite existing files
    -v  print names of files

Copies all files or directory entries into the target directory.
If the target does not exist already, it is created."
    exit 1
}

msg () {
    for i
    do echo "$PN: $i" >&2
    done
}

fatal () { msg "$@"; exit 1; }

while [ $# -gt 0 ]
do
    case "$1" in
    -v|-u|-l)   CpioOpt="$CpioOpt $1";;
    -d)     FindOpt="-type d";;
    --) shift; break;;
    -h) usage;;
    -*) usage;;
    *)  break;;         # First file name
    esac
    shift
done

[ $# -ge 2 ] || usage

# Find last argument on the command line
for targetdir
do :
done

if [ -d "$targetdir" ]
then :
else
    msg "creating new directory $targetdir"
    mkdir -p -- "$targetdir" ||
        fatal "ERROR: cannot create directory: $targetdir"
fi

# Resolve relative path names
targetdir=`cd -- "$targetdir"; pwd`

[ -n "$targetdir" ] || fatal "ERROR: cannot determine target directory"

# Now copy all source files. Do not process the last argument, because
# it is the name of the destination directory.

while [ $# -ge 2 ]
do
    path=$1; shift
    if [ -d "$path" ]
    then
        (
        cd -- "$path" || exit 1
        find . $FindOpt -print |
            cpio $CpioOpt "$targetdir"
    )
    else
        msg "NOTE: no directory; ignored: $path"
    fi
done