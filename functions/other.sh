# Loop do command.
# "${@:2}" can be a command bash file.
whiledo() {
    while true; do
        echo "=======$(date '+%Y.%m.%d-%T')======="
        # Write exectue command below.
        for args in "${@:2}" ; do
            "$args";
            # echo "=======Execute finish======="
        done
        sleep "$1"
    done
}

# cat *.conf pretty format.
confprint() {
    perl -ne 'm/^([^#][^\s=]+)\s*(=.*|)/ && printf("%-35s%s\n", $1, $2)' "$1"
}

# Create command tutorial pdf file.
man2pdf() {
    man -t "$1" | ps2pdf -> "$1"
}

# Make & change directory.
mcdir() {
    echo "Creating $@ directory."
    mkdir "$@" && cd "$1"
}

# Goes up many dirs as the number passed as argument, if none goes up by 1 by default
ups() {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [[ -z "$d" ]]; then
        d=..
    fi
    cd $d
}

# Print Hardware information.
pcinfo() {
    # sudo lshw
    # CPU info:
    echo -en "$Red$On_White  CPU Info: $Color_Off$On_White $Color_Off \r\n"
    lscpu

    # RAM info:
    echo -en "$Red$On_White  RAM Info: $Color_Off$On_White $Color_Off \r\n"
    sudo lshw -class memory

    # MotherBoard info:
    echo -en "$Red$On_White  MotherBoard Info: $Color_Off$On_White $Color_Off \r\n"
    sudo dmidecode -t baseboard

    # HDD Info:
    echo -en "$Red$On_White  HDD Info: $Color_Off$On_White $Color_Off \r\n"
    for x in {a..z}
    do
        if [[ -e /dev/sd$x ]]; then
            echo -en "    $Red$On_White   /dev/sd$x $Color_Off$On_White $Color_Off \r\n"
            sudo smartctl -i /dev/sd$x
            echo -en "    $Red$On_White   UUID:  $Color_Off$On_White $Color_Off \r\n"
            blkid /dev/sd$x*
        fi
    done

    # Graphic Info:
    echo -en "$Red$On_White  Graphic Info: $Color_Off$On_White $Color_Off \r\n"
    sudo lshw -class display

    # Network Info:
    echo -en "$Red$On_White  Network Info: $Color_Off$On_White $Color_Off \r\n"
    sudo lshw -C network

    # USB Info:
    echo -en "$Red$On_White  USB Info: $Color_Off$On_White $Color_Off \r\n"
    lsusb -v

    # PCI Info:
    echo -en "$Red$On_White  PCI Info: $Color_Off$On_White $Color_Off \r\n"
    lspci -vv

    # System Info:
    echo -en "$Red$On_White  System Info: $Color_Off$On_White $Color_Off \r\n"
    tecmint_monitor.sh

    # Kernel Info:
    echo -en "$Red$On_White  Kernel Info: $Color_Off$On_White $Color_Off \r\n"
    dmesg | tail
    echo -en "$Red$On_White                    $Color_Off$On_White $Color_Off \r\n"
}

# Remove head & tail unnecessary space/char
trim() {
    if [ -z $1 ]; then # $1 is unset
        sed -e 's/^ *//' -e 's/ *$//'
    else
        # echo "=== $1 ==="
        sed -e 's/^ *//' -e 's/ *$//' -e "s/^$1//" -e "s/$1$//"
    fi
}

# Set default Editor/Terminal
# Change the sh source: sh or dash.
# sudo dpkg-reconfigure dash
default() {
    local param
    case $1 in
        ?)
            echo $"Usage: ${FUNCNAME[0]} [-t|-e]"
            echo $"
Global options:
    -t, terminal
        Set default terminal software.
    -e, editor
        Set default editor software.
"
            return 0
            ;;
        -t|termainal)
            param="x-terminal-emulator"
            ;;
        -e|editor)
            param="editor"
            ;;
    esac
    sudo update-alternatives --config ${param}
    unset param
}

# Generate random string
randomstring() {
    local param='A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~'
    case $1 in
        -a|alphabet)
            shift
            date +%s%N | sha256sum | base64 | head -c "$1" ; echo
            ;;
        -c|custom)
            shift
            if [ -n "${2}" ]; then
                param="${2}"
            fi
            cat /dev/urandom | tr -dc "${param}" | head -c "$1"; echo
            ;;
        ?|*)
            echo $"Usage: ${FUNCNAME[0]} [-a|-c] ..."
            echo $"
Global options:
    -a, alphabet
        Generate string of alphabet.
    -c, custom
        Generate string of custom character.
Example:
    randomstring alphabet 10
    randomstring custom 10
    randomstring custom 10 'a-zA-Z0-9'
"
            ;;

    esac
    unset param
}

# Commas in Numbers
# 18888888888888888888 to 18,888,888,888,888,888,888
commanum() {
    echo $1 | rev | sed 's/.../&,/g' | rev
}

# Query software install/upgrade/remove history.
apt-history() {
    case "$1" in
        install)
            cat /var/log/dpkg.log | grep 'install '
            ;;
        upgrade|remove)
            cat /var/log/dpkg.log | grep $1
            ;;
        rollback)
            cat /var/log/dpkg.log | grep upgrade | \
                grep "$2" -A10000000 | \
                grep "$3" -B10000000 | \
                awk '{print $4"="$5}'
            ;;
        *)
            cat /var/log/dpkg.log
            ;;
        esac
}

# graphviz command
graph() {
    local time=$(dt)
    local tfile
    case $1 in
        jpg|png)
            tfile="$(echo "$2" | sed 's/\..*//')"
            dot -T"${1}" "${tfile}.gv" -o "${tfile}_${time}.${1}"
            ;;
    esac
    echo "Open ${tfile}_${time}.${1}?"
    select tmp in "Yes" "No" ; do
        case "$tmp" in
        Yes)
            xopen "${tfile}_${time}.${1}"
            break
            ;;
        No)
            break
            ;;
        *)
        esac
    done
    unset time tfile
}

# Show folder Capacity
foldersize() {
    # Check arguments illegal or not.
    if [[ $# == 0 ]]; then
        eval "set -- $(pwd)"
    fi
    # Processing..
    echo "Total Directory Capacity:"
    du -sh "$1"
    echo "-------------------------"
    echo "All file of Directory Capacity:"
    du -sh "$1"/*
    echo "-------------------------"
    echo "Top 5 of Directory file Capacity:"
    du -s "$1"/* | sort -rn | head -5
    echo "-------------------------"
}

# Generate file checksum.
checksum() {
    while [ $# != 0 ]; do
        test -f "$1" || shift
        test ! -z "$1" || continue
        local tdate=$(date '+%Y.%m.%d-%T')
        echo "checksum generated Date : $tdate"
        echo -n "crc32 - " && crc32 "$1"
        echo -n "md5sum - " && md5sum "$1"
        echo -n "sha1sum - " && sha1sum "$1"
        shift
    done
    unset tdate
}

# open color from https://rgb.to/
coloropen() {
    if [[ $1 =~ ^[0-9]+$ ]];then
        xopen "https://rgb.to/hex/$1"
    else
        xopen "https://rgb.to/rgb/$1"
    fi
}

# REMIND ME, ITS IMPORTANT! {{{
# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
remindme() {
    zenity --info --text "$1" &
}

# To convert webp to jpg format
dwebp2png() {
    dwebp "$1.webp" -o "$2"
}
