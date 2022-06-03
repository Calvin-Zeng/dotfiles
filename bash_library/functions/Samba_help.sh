# help_Samba guide.
help_Samba() {
    case $1 in
    *)
echo -e $"
${Yellow}Usage:${Color_Off} Samba [options] ...
${Yellow}Global options:${Color_Off}
    ${Green}-d, detect${Color_Off}
        -l, linux
            Detect share folders for linux system.
        -w, win
            Detect share folders for Windows system.
    ${Green}-s, status${Color_Off}
        Show status of samba server.
    ${Green}-m, mount - samba mount.${Color_Off}
        -l, linux
            Mount linux samba ver1.0 share folders.
        -w, win
            Mount windows cifs ver1.0 share folders.
    ${Green}-i, iso${Color_Off}
        Mount ISO file.
    ${Green}-g, gnu${Color_Off}
        Use gnome command to mount samba share folder in nautilus.
    ${Green}-c, check${Color_Off}
        If unmount device show \"Device is busy\"
        Use this command to check which application occupation.
        Ask kill this application or not.

${Yellow}Example:
    ${Yellow}Samba -d -l //127.0.0.1 calvin${Color_Off}
    ${Yellow}Samba -d -w //10.10.67.243 03716 SERCOMM.com${Color_Off}
    ${Yellow}Samba -m -l \"calvin\" \"123\" \"WORKGROUP\" //10.10.67.243/send/ ./ftm${Color_Off}
    ${Yellow}Samba -m -w \"03716\" \"1234\" \"example.com\"//10.10.67.243/send/ ./ftm${Color_Off}
    ${Yellow}Samba -m -i FILENAME.ISO /mnt/iso${Color_Off}
    ${Yellow}Samba -m -g //10.10.67.243/send/${Color_Off}
    ${Yellow}Samba -c ./ftm${Color_Off}

${Yellow}linux mount linux samba server:${Color_Off}
    ${Yellow}sudo mount -o user='carl',password='123456',iocharset=utf8,noperm //10.1.1.244/carl ~/10.1.1.244/${Color_Off}

${Yellow}Fix linux mount Windows partition show: 
    ${Red}The disk contains an unclean file system (0, 0).
    Metadata kept in Windows cache, refused to mount.
    Falling back to read-only mount because the NTFS partition is in an
    unsafe state. Please resume and shutdown Windows fully (no hibernation
    or fast restarting.)
    Could not mount read-write, trying read-only:${Color_Off}
    ${Yellow}sudo ntfsfix /dev/sda3${Color_Off}
"
    ;;
    esac
}