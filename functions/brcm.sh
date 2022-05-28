# Broadcom commands.
brcm() {
    local model
    local clean
    local param=""
    while [ $# -gt 0 ]
    do
        case $1 in
        -M|model)
            shift
            model="$1"
            echo "Compile $model"
            ;;
        -c|clean)
            clean=1
            ;;
        -a|all)
            shift
            [[ $clean = 1 ]] && param="clean" || param=""
            echo "param=${param}"
            make PROFILE="$model" "$param"
            ;;
        -k|kernel)
            shift
            [[ $clean = 1 ]] && param="kernel_clean" || param="kernel"
            echo "param=${param}"
            make PROFILE="$model" "$param"
            ;;
        -m|modules)
            shift
            echo "param=${param}"
            make PROFILE="$model" modules
            ;;
        -u|userspace)
            shift
            [[ $clean = 1 ]] && param="userspace_clean" || param="userspace"
            echo "param=${param}"
            make PROFILE="$model" "$param"
            ;;
        -b|buildimage)
            shift
            echo "param=${param}"
            make PROFILE="$model" buildimage
            ;;
        esac
        shift
    done
}
