# ctags extra commands.
ctags() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local exclude_param="--exclude="
    local param
    local file_param="-f .tags"
    while [ $# -gt 0 ]
    do
        case $1 in
        exclude)
            while [ $# -gt 1 ]
            do
                shift
                param="${param} ${exclude_param}${1//\//}"
            done
            # echo "${param}"
            ;;
        excludef)
            shift
            param="${param} ${exclude_param}@${1}"
            ;;
        append)
            param="${param} -a"
            ;;
        dir)    # ctags current directory.
            shift
            param="${param} -R"
            ;;
        *)
            $exec_path "$@"
            unset exec_path exclude_param param file_param
            return 0
            ;;
        esac
        if [ ! $# == 1 ]; then
            shift
        fi
    done
    # echo "${param}"
    $exec_path ${param} ${file_param}
    unset exec_path exclude_param param file_param
}