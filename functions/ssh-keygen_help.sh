# help_ssh-keygen guide.
help_ssh-keygen() {
    case $1 in
    *)
echo -e $"
ssh welcome message file path:
/etc/update-motd.d/XX-*

    - ${Green} Generate a key for local user.${Color_Off}
        ${Yellow}ssh-keygen -t rsa -C \"E-mail\"${Color_Off}

    - ${Green} Copy local key to remote via ssh${Color_Off}
        ${Yellow}ssh-copy-id -i someserver${Color_Off}
"
    ;;
    esac
}