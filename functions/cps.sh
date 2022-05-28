# Safe Copy File
# Use diff(Meld) to check file different and copy.
cps() {
    # Check arguments illegal or not.
    if [[ $# != 2 ]]; then
        echo -e "${ARG2} cps SOURCE TARGET ${EXAMPLES} cps oldCode.c newCode.c"
        return 0
    fi
    # Processing..
    target_path=$(echo ${@:$#})
    for args in "$@" ; do
        # Skip:
        # 1. last arg.
        # 2. args not exist.
        if [ "$args" = "$target_path" ] ||
           [ ! -e "$args" ]; then
            break
        fi

        # Both are directory
        if file "$args" |grep 'directory' > /dev/null && \
           file "$target_path" |grep 'directory' > /dev/null  ; then
            for file_args in $args/* ; do
                filename=$(echo ${file_args#*//})
                filename=$(echo ${filename#*/})
                filename=$(echo ${filename#*/})
                echo "Process $filename"
                if [ -e "$target_path/$filename" ] && \
                    file "$file_args" |grep 'text\|empty' > /dev/null && \
                    ! diff "$file_args" "$target_path/$filename" > /dev/null ; then
                    echo "Text file different,use Meld to processing."
                    meld "$file_args" "$target_path/$filename" &
                fi

                # Target file not exist or not text file.
                if [ ! -e "$target_path/$filename" ] || \
                   ! file "$file_args" |grep 'text\|empty' > /dev/null ; then
                    cp "$file_args" "$target_path/$filename"
                fi
            done
        fi

        # Source is not directory,but target is."
        if ! file "$args" |grep 'directory' > /dev/null && \
           file "$target_path" |grep 'directory' > /dev/null  ; then
            if [ -e "$target_path/$args" ] && \
                file "$args" |grep 'text\|empty' > /dev/null && \
                ! diff "$args" "$target_path/$args" > /dev/null ; then
                echo "Text file different,use Meld to processing."
                meld "$args" "$target_path/$args" &
            fi

            # Target file not exist or not text file.
            if [ ! -e "$target_path/$args" ] || \
               ! file "$args" |grep 'text\|empty' > /dev/null ; then
                cp "$args" "$target_path/$args"
            fi
        fi

        if file "$args" |grep 'directory' > /dev/null && \
           ! file "$target_path" |grep 'directory' > /dev/null  ; then
            echo "$args is directory,but $target_path is not."
            echo "Unable to handle this situation."
        fi

        # Both are not directory
        if ! file "$args" |grep 'directory' > /dev/null && \
           ! file "$target_path" |grep 'directory' > /dev/null  ; then
            if [ -e "$target_path" ] && \
                file "$args" |grep 'text\|empty' > /dev/null && \
                ! diff "$args" "$target_path" > /dev/null ; then
                echo "Text file different,use Meld to processing."
                meld "$args" "$target_path" &
            fi

            # Target file not exist or not text file.
            if [ ! -e "$target_path" ] || \
               ! file "$args" |grep 'text\|empty' > /dev/null ; then
                cp "$args" "$target_path"
            fi
        fi
    done
}
