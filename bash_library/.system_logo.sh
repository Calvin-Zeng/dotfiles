#!/bin/bash
# You can use below command to generate ASCII logo.
# linuxlogo  > ./logotest

eval $(uptime -p | sed -n -e "s/^up \+\([0-9]\+\).*/time=\1/p")
unit="$(uptime -p | awk '{print $3}')"
# echo "$time $unit"

if [ $time -lt 30 ] && [ $unit = "minutes" ] ; then
/usr/bin/cat<<'EOF'
  [0m[2J[1;1H[0;25;37;47m[0m                                                                                         [0;1;40;33m_..._
                [0;1;40;38m.-.                                                                    [0;1;40;33m.'     '.
          [0;0;40;33m.-'``[0;1;40;38m(|||)                                                                  [0;1;40;33m/  _   _  \
       [0;1;40;33m,`\[0;0;40;33m \   [0;1;40;38m `-`[0;0;40;33m.                 [0;1;40;33m88                         88                    | (o)_(o) |
      [0;1;40;33m/   \ [0;0;40;33m'``-.   `                [0;1;40;33m88                         88                     \(     ) /
    [0;0;40;33m.-. [0;1;40;33m ,       [0;0;40;33m`___:      [0;1;40;33m88   88  88,888,  88   88  ,88888, 88888  88   88          //'._.'\ \
   [0;0;40;33m(:::) [0;1;40;33m:       [0;1;40;38m ___       [0;1;40;33m88   88  88   88  88   88  88   88  88    88   88         //   .   \ \
    [0;0;40;33m`-` [0;1;40;33m `       [0;1;40;38m,   :      [0;1;40;33m88   88  88   88  88   88  88   88  88    88   88        ||   .     \ \
     [0;1;40;33m \   /[0;1;40;38m ,..-`   ,       [0;1;40;33m88   88  88   88  88   88  88   88  88    88   88        |\   :     / |
       [0;1;40;33m`./ [0;1;40;38m/    [0;1;40;33m.-.[0;1;40;38m`        [0;1;40;33m'88888'  '88888'  '88888'  88   88  '8888 '88888'        \ `) '   (`  /_
          [0;1;40;38m`-..-[0;1;40;33m(   )                                                               _)``".____,.'"` (_
                [0;1;40;33m`-`                                                                )     )'--'(     (
                                                                                    '---`      `---`

  [1;37;40mLinux Version 5.11.0-25-generic, Compiled #27~20.04.1-Ubuntu SMP Tue Jul 13 17:41:23 UTC 2021[0m
  [7C[1;37;40mEight 1.16GHz Intel i5 Processors, 16GB RAM, 19046 Bogomips Total[0m
  [29C[1;37;40mThinkBook-14[0m

  [0m[255D
EOF
fi

# cat<<'EOF'
#            _..._
#          .'     '.
#         /  _   _  \
#         | (o)_(o) |
#          \(     ) /
#          //'._.'\ \
#         //   .   \ \
#        ||   .     \ \
#        |\   :     / |
#        \ `) '   (`  /_
#      _)``".____,.'"` (_
#      )     )'--'(     (
#       '---`      `---`
# EOF