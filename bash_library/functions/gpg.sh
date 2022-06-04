# gpg extra commands.
gpg() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local param
    case $1 in
    list)
        gpg --list-key
        gpg --list-secret-keys
        return 0
        ;;
    -g|generate)
        shift
        param="${param} --full-gen-key"
        ;;
    -e|edit)
        shift
        param="${param} --edit-key"
        ;;
    -d|delete)
        shift
        param="${param} --delete-secret-and-public-key"
        ;;
    -i|import)
        shift
        param="${param} --import"
        ;;
    -s|sign)
        shift
        param="${param} --sign-key"
        ;;
    -e|export)
        shift
        case $1 in
        -p|pub)
            shift
            param="${param} --export -a"
            ;;
        -s|sec)
            shift
            param="${param} --export-secret-keys -a"
            ;;
        esac
        ;;
    esac
    echo "Parameter: ${param}" "$@"
    $exec_path ${param} "$@"
    unset exec_path param
}

engpg() {
    gpg -er $__gpg__key $1
}

degpg() {
    gpg -do ${1%.*}{,.gpg}
}