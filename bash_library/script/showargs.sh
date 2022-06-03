#!/bin/bash

# showargs - show command line arguments
#
# Author:	Heiner Steven <heiner.steven@odn.de>
# Category:	Debugging

exec 1>&2
echo "$0: $# parameters:"
for i
do echo "<$i>"
done
exit 0