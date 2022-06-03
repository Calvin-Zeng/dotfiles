# owrt(OpenWrt) extra commands.
# TBD:functions - Simplified the code, use {} to extend.
owrt() {
    local param
    while [ $# -gt 0 ]
    do
        case $1 in
        -v|debug)
            param="V=s"
            ;;
        -l|linux)
            shift
            make target/linux/"$1" ${param}
            if [ $? -ne 0 ]; then
                echo "Linux $1 compile failed,stop."
                alert "Linux $1 compile failed,stop."
                unset param
                return 1
            fi
            unset param
            return 0
            ;;
        -m|make)
            shift
            while [ $# != 0 ]; do
                make package/"$1"/compile ${param}
                if [ $? -ne 0 ]; then
                    echo -en "$Red$On_White Package $1 compile failed,stop. $Color_Off$On_White$Color_Off \r\n"
                    alert "Package $1 compile failed,stop."
                    unset param
                    return 1
                fi
                make package/"$1"/install
                shift
            done
            echo "Package total compile Finished!"
            alert "Package total compile Finished!"
            beep
            unset param
            return 0
            ;;
        -c|clean)
            shift
            while [ $# != 0 ]; do
                make package/"$1"/clean
                shift
            done
            unset param
            return 0
            ;;
        -r|rebuild)
            shift
            package -c "$@"
            if [ "$param" == "V=s" ]; then
                package -v -m "$@"
            else
                package -m "$@"
            fi
            if [ $? -ne 0 ]; then
                unset param
                return 1
            fi
            unset param
            return 0
            ;;
        -i|install)
            shift
            while [ $# != 0 ]; do
                make package/"$1"/install
                shift
            done
            unset param
            return 0
            ;;
        -u|update)  # OpenWRT feeds update.
            fp -b .config
            ./scripts/feeds clean
            ./scripts/feeds update -a
            ./scripts/feeds install -a
            return 0
            ;;
        esac
        shift
    done
    unset param
}
