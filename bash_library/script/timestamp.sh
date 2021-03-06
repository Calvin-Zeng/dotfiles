##########################################################################
# Title      :	timestamp - periodically write time stamp
# Author     :	Heiner Steven <heiner.steven@odn.de>
# Date       :	1994-02-04
# Requires   :	
# Category   :	Debugging
# SCCS-Id.   :	@(#) timestamp	1.3 07/02/01
##########################################################################
# Beschreibung:
# Reference:
# http://www.shelldorado.com/scripts/cmds/timestamp.txt
##########################################################################

PN=`basename "$0"`			# Program name
VER='1.3'

datefmt='%Y-%m-%d %H:%M:%S'

Sek=${1:-60}				# Interval (seconds)
case "$Sek" in
    [0-9][0-9]*)
	;;				# correct
    *)
	echo >&2 "$PN - print time stamp, $VER
usage: $PN [interval]

Prints current time all <Intervall> seconds
(default: 60)."
	exit 1;;
esac

while true
do
    echo "-------------------(`date \"+$datefmt\"`)-------------------"
    sleep $Sek
done