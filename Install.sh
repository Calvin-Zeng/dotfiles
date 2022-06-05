#!/bin/bash
source SourceList.sh

SCRIPT_PATH=$(readlink -f $0)
REPO_PATH=$(dirname $SCRIPT_PATH)
DATE=$(date +"%Y-%m-%d")
BACKUP_FOLDER="backup"

confirm() {
  read -r -p "$1" answer
  case $answer in
      ""|[Yy]* ) return 0;;
      [Nn]* ) return 1;;
      * ) echo "Please answer Y or N."; return 1;;
  esac
}

# It will insert/update the dotfiles_dir path variable in .bashrc when this script process the .bashrc symbolic link.
# so, you don't worry the repository changed the location or naming else name.
update_dotfiles_path() {
    # Remove the old dotfiles hook in ~/.bashrc
    sed -i -f "$REPO_PATH/.bashrc_sed.scr" $REPO_PATH/bash_library/.bashrc

    cat << EOF >> $REPO_PATH/bash_library/.bashrc
# dotfiles hook.
dotfiles_dir="$REPO_PATH"
[ -f "\$dotfiles_dir/.bash_profile" ] && source "\$dotfiles_dir/.bash_profile";

unset dotfiles_dir color_prompt force_color_prompt
EOF
}

cd "$REPO_PATH";

confirm "This script will change the dotfiles(type: file) to symbolic link, Are you sure? ([Y]/N): "
[ $? -eq 1 ] && echo "Nothing to do." && exit 0

for ((i = 0; i < ${#T_Name[@]}; i++)); do
    target="${T_Path[$i]}/${T_Name[$i]}"
    backup="${REPO_PATH}/$BACKUP_FOLDER/${DATE}/"
    # echo "$backup"

    # The filename maybe is same as the other application, just path is different.
    [ -z "${S_Name[$i]}" ] || source="${REPO_PATH}/${S_Name[$i]}"
    [ -z "${S_Name[$i]}" ] && source="${REPO_PATH}/${T_Name[$i]}"

    confirm "Change the $target to symbolic link($source), Are you sure? ([Y]/N): "
    [ $? -eq 1 ] && echo "Skip." && continue

    [ ! -f "$source" ] && [ ! -d "$source" ] && continue

    # Handle the symbolic link.
    if [ -L "$target" ]; then
        # Check the path is link to repo.
        if [ "$source" != "$(readlink $target)" ]; then
            confirm "The $target is a symbolic link, but it isn't link to $source, modify? ([Y]/N): "
            [ $? -eq 0 ] && rm "$target" || continue
        else
            # Update the dotfiles_dir path in .bashrc
            [ "${T_Name[$i]}" == "bash/.bashrc" ] && update_dotfiles_path
            continue
        fi
    fi

    # If the original dot file/folder is entity, then backup it.
    if [ -f "$target" ] || [ -d "$target" ]; then
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

    [ ! -d "$T_Path" ] && confirm "Folder: $T_Path isn't exist. Create? ([Y]/N): "
    [ $? -eq 0 ] && mkdir -p "$T_Path" || continue

    # create a symbolic link to repo dot file.
    ln -s "$source" "$target"

    # Update the dotfiles_dir path in .bashrc
    [ "${T_Name[$i]}" == "bash/.bashrc" ] && update_dotfiles_path
    echo 'Finished.'
done
