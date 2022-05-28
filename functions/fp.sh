# fp extra commands.
fp() {
    case $1 in
        -s|swap)   # Quickly swap two file.
            shift
            test -e "$1" || echo "$1 Not exist."
            test -e "$2" || echo "$2 Not exist."
            test -e "$1" || return 0
            test -e "$2" || return 0
            local FileSour=$(echo "$1" | sed 's/\/$//')
            local FileTar=$(echo "$2" | sed 's/\/$//')
            local Date=$(date '+%Y-%m-%d_%H-%M-%S')
            echo "${Date} $1 <=> $2"
            mv "${FileSour}" "${FileSour}.${Date}"
            mv "${FileTar}" "${FileSour}"
            mv "${FileSour}.${Date}" "${FileTar}"
            ;;
        -b|backup)    # Backup file to file.XX.XX.XX-XX:XX:XX format.
            shift
            while [ $# != 0 ]; do
                test -e "$1" || shift
                test ! -z "$1" || continue
                local FileSour=$(echo "$1" | sed 's/\/$//')
                local Date=$(date '+%Y-%m-%d_%H-%M-%S')
                echo "Move ${FileSour} to ${FileSour}.${Date}"
                mv "${FileSour}" "${FileSour}.${Date}"
                shift
            done
            ;;
        -rb|revert)    # Revert file.XX.XX.XX-XX:XX:XX name to file.
            shift
            while [ $# != 0 ]; do
                test -e "$1" || shift
                test ! -z "$1" || continue
                local Date=$(date '+%Y-%m-%d_%H-%M-%S')
                local FileSour=$(echo "$1" | sed 's/\.[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}//')

                if [[ -e "${FileSour}" ]]; then
                    echo "Target file exist! Backup target file."
                    echo "Move ${FileSour} to ${FileSour}.${Date}"
                    mv "${FileSour}" "${FileSour}.${Date}"
                fi

                echo "Move $1 to $FileSour"
                rename 's/\.[0-9]{4}-[0-9]{2}-[0-9]{2}_[0-9]{2}-[0-9]{2}-[0-9]{2}//' "$1"
                shift
            done
            ;;
        -r|rename)    # Files name to Upper/Lower/custom case.
            local param
            shift
            case $1 in
                -l|low)
                    shift
                    param='y/A-Z/a-z/'
                    ;;
                -u|up)
                    shift
                    param='y/a-z/A-Z/'
                    ;;
                *)
                    param="$1"
                    shift
                    ;;
            esac
            rename -n "${param}" "$@"
            select tmp in "Yes" "No" ; do
                case "$tmp" in
                Yes)
                    rename "${param}" "$@"
                    break
                    ;;
                No)
                    break
                    ;;
                *)
                esac
            done
            ;;
        -n|number)
            shift
            i=1;
            pad=$3;

            if [ -z $3 ]; then
                echo "args 3 is Empty.Default no pad."
                pad=1;
            fi

            for x in $1 ; do
                echo "Rename $x to $2$(printf "%0$(echo $pad)d" $i)${4} File."
                mv "$x" "$2$(printf "%0$(echo $pad)d" $i)${4}";
                let i=i+1;
            done
            ;;
    esac
    unset FileSour FileTar Date param
}
