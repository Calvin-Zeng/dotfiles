#!/bin/bash
# refer to https://gist.github.com/ketan/2866a236596636311d64
# Run in go using - 
# <exec command="bash">
#   <arg>-c</arg>
#   <arg>curl -s https://gist.githubusercontent.com/ketan/2866a236596636311d64/raw/ansi-color-test.sh | bash</arg>
# </exec>

echo "<script>console.log('42')</script>"

echo -e "\033[01;32mHELLO^[\033[00m"

bash <( curl -s https://raw.githubusercontent.com/fidian/ansi/master/ansi) --color-table

#8 bit color table (256 colors)
# ESC[ 38;5;⟨n⟩ m Select foreground color
# ESC[ 48;5;⟨n⟩ m Select background color
#   0-  7:  standard colors (as in ESC [ 30–37 m)
#   8- 15:  high intensity colors (as in ESC [ 90–97 m)
#  16-231:  6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
# 232-255:  grayscale from black to white in 24 steps
echo -en "\n   +  "
for i in {0..35}; do
    printf "%2b " $i
done
printf "\n\n %3b  " 0
for i in {0..15}; do
    echo -en "\033[48;5;${i}m ${i}  \033[m "
done
#for i in 16 52 88 124 160 196 232; do
for i in {0..6}; do
    let "i = i*36 +16"
    printf "\n\n %3b  " $i
    for j in {0..35}; do
        let "val = i+j"
        echo -en "\033[48;5;${val}m ${val} \033[m "
    done
done
echo -e "\n"

# something else

T='gYw'   # The test text
echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m";
    done
    echo;
done
echo
