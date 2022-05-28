# Incremental Backup
targzincre() {
    local tdate=$(date '+%Y-%m-%d_%H-%M-%S')
    tar zcvf "$1_$tdate".tar.gz "${@:2}" -g "$1_snapshot"
    if test -e "${1}_snapshot" ; then
        echo "Copy record: ${1}_${tdate}.tar.gz_snapshot"
        cp "$1_snapshot" "${1}_${tdate}.tar.gz_snapshot"
    fi
}

tarbz2incre() {
    local tdate=$(date '+%Y-%m-%d_%H-%M-%S')
    tar jcvf "$1_$tdate".tar.bz2 "${@:2}" -g "$1_snapshot"
    if test -e "${1}_snapshot" ; then
        echo "Copy record: ${1}_${tdate}.tar.bz2_snapshot"
        cp "$1_snapshot" "${1}_${tdate}.tar.bz2_snapshot"
    fi
}

# Uncompress incremental Backup of zip file.
tarugzincre() {
    tar zxvf "$1" -C "$2" -g "${1}_snapshot"
    echo "${1} Finished." >> "${2}/extract_record"
}

tarubz2incre() {
    tar jxvf "$1" -C "$2" -g "${1}_snapshot"
    echo "${1} Finished." >> "${2}/extract_record"
}

# refer to https://github.com/algotech/dotaliases/blob/master/bash/cli_aliases
extract() {

    if [[ "$#" -lt 2 ]]; then
      echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz> <extract to where>"
      return 1 #not enough args
    fi

    if [[ ! -e "$1" ]]; then
      echo -e "File does not exist!"
      return 2 # File not found
    fi

    filename=`basename "$1"`

    case "${filename##*.}" in
      tar)
        echo -e "Extracting $1 to $2: (uncompressed tar)"
        tar xvf "$1" -C "$2"
        ;;
      gz)
        echo -e "Extracting $1 to $2: (gip compressed tar)"
        tar xvfz "$1" -C "$2"
        ;;
      tgz)
        echo -e "Extracting $1 to $2: (gip compressed tar)"
        tar xvfz "$1" -C "$2"
        ;;
      xz)
        echo -e "Extracting  $1 to $2: (gip compressed tar)"
        tar Jxvf "$1" -C "$2"
        ;;
      bz2)
        echo -e "Extracting $1 to $2: (bzip compressed tar)"
        tar xvfj "$1" -C "$2"
        ;;
      tbz2)
        echo -e "Extracting $1 to $2: (tbz2 compressed tar)"
        tar xvjf "$1" -C "$2"
        ;;
      zip)
        echo -e "Extracting $1 to $2: (zipp compressed file)"
        unzip "$1" -d "$2"
        ;;
      lzma)
        echo -e "Extracting $1 : (lzma compressed file)"
        unlzma "$1"
        ;;
      rar)
        echo -e "Extracting $1 to $2: (rar compressed file)"
        unrar x "$1" "$2"
        ;;
      7z)
        echo -e  "Extracting $1 to $2: (7zip compressed file)"
        7za x "$1" -o"$2"
        ;;
      xz)
        echo -e  "Extracting $1 : (xz compressed file)"
        unxz  "$1"
        ;;
      exe)
        cabextract "$1"
        ;;
      *)
        echo -e "Unknown archieve format!"
        return
        ;;
    esac
}
