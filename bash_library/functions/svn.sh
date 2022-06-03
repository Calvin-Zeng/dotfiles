# svn extra commands.
svn() {
    local exec_path="$(which "${FUNCNAME[0]}")"
    local param
    case $1 in
    cl)
        shift
        param="${param} $1"
        shift
        ;;
    clm)
        shift
        param="${param} cl $1 $(svn st | grep '^M' | awk '{print $2}')"
        shift
        ;;
    ci)
        shift
        param="${param} commit"
        ;;
    lg)
        shift
        param="${param} log -l 10 -v"
        ;;
    pl)
        shift
        param="${param} update"
        ;;
    re)
        shift
        param="${param} up -r $1"
        shift
        ;;
    reall)
        shift
        param="${param} revert --depth infinity"
        ;;
    adall)
        shift
        $exec_path st | grep '^\?' | tr '^\?' ' ' | sed 's/[ ]*//' | sed 's/[ ]/\\ /g' | xargs $exec_path add
        unset param
        return 0
        ;;
    esac
    echo "Parameter: ${param}" "$@"
    $exec_path ${param} "$@"
    unset exec_path param
}

svncp() {
    svn cp "$1" "$2" -r "$3" -m "$4"
}
