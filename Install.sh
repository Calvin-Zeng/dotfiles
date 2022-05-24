#!/bin/bash
source SourceList.sh

SCRIPT_PATH=$(readlink -f $0)
REPO_PATH=$(dirname $SCRIPT_PATH)
DATE=$(date +"%Y-%m-%d")

# It will insert/update the dotfiles_dir path variable in .bashrc when this script process the .bashrc symbolic link.
# so, you don't worry the repository changed the location or naming else name.
update_dotfiles_path() {
    # Remove the old dotfiles hook in ~/.bashrc
    sed -i -f "$REPO_PATH/.bashrc_sed.scr" $REPO_PATH/.bashrc

    cat << EOF >> $REPO_PATH/.bashrc
# dotfiles hook.
dotfiles_dir="$REPO_PATH"
[ -f "\$dotfiles_dir/.bash_profile" ] && source "\$dotfiles_dir/.bash_profile";

unset dotfiles_dir
EOF
}

cd "$REPO_PATH";

read -r -p "This script will change the dotfiles(type: file) to symbolic link, Are you sure? (Y/[N]): " answer
case $answer in
    [Yy]* ) ;;
    *|[Nn]* )
        echo "Nothing to do."
        exit;;
esac

for ((i = 0; i < ${#T_Name[@]}; i++)); do
    target="${T_Path[$i]}/${T_Name[$i]}"
    backup="${REPO_PATH}/Backup/${DATE}/"

    # The filename maybe is same as the other application, just path is different.
    [ -z "${S_Name[$i]}" ] || source="${REPO_PATH}/${S_Name[$i]}"
    [ -z "${S_Name[$i]}" ] && source="${REPO_PATH}/${T_Name[$i]}"
    # echo "$target"
    # echo "$backup"
    # echo "$source"

    # repo dot file is present, then create a symbolic link to repo dot file.
    if [ -f "$source" ]; then
        # Handle the symbolic link.
        if [ -L "$target" ]; then
            # Check the path is link to repo.
            if [ "$source" != "$(readlink $target)" ]; then
                read -r -p "The $target is a symbolic link, but it isn't link to $source, modify? ([Y]/N): " answer
                case $answer in
                    ""|[Yy]* ) rm "$target";;
                    [Nn]* ) continue;;
                    * ) echo "Please answer Y or N, Ignore!"; continue;;
                esac
            else
                # Update the dotfiles_dir path in .bashrc
                [ "${T_Name[$i]}" == ".bashrc" ] && update_dotfiles_path
                continue
            fi
        fi

        # If the original dot file is file type, then backup it.
        if [ -f "$target" ]; then
            [ ! -d "$backup" ] && mkdir -p "$backup"

            # The filename maybe is same as the other application, just path is different.
            if [ ! -z "${S_Name[$i]}" ] ; then
                echo "Backup the $target to $backup/${S_Name[$i]}"
                mv "$target" "$backup/${S_Name[$i]}"
            else
                echo "Backup the $target to $backup"
                mv "$target" "$backup"
            fi
        fi

        ln -s "$source" "$target"

        # Update the dotfiles_dir path in .bashrc
        [ "${T_Name[$i]}" == ".bashrc" ] && update_dotfiles_path
    fi
done
