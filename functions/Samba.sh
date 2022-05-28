# Samba extra commands.
Samba() {
    case $1 in
    -d|detect)
    shift
    case $1 in
        -l|linux)   # Detect share folders for linux system.
            shift
            # smbdetect //127.0.0.1 calvin
            smbclient -L "$1" -U "$2"
            ;;
        -w|win)     # Detect share folders for Windows system.
            shift
            # smbclient -W SERCOMM.com -L //10.10.67.243 -U 03716
            smbclient -L "$1" -U "$2" -W "$3"
            ;;
        *)
            echo "-l or -w"
            ;;
    esac
    ;;
    -s|status)      # Show status of samba server.
    sudo smbstatus -d
    ;;
    -m|mount)       # samba mount.
    shift
    case $1 in
        -l|linux)   # Mount linux samba ver1.0 share folders.
            shift
            # sudo mount -t cifs //192.168.2.3/public ~/2.3_public/
            # sudo mount -o user="calvin",password="123",domain="WORKGROUP",iocharset=utf8,file_mode=0777,dir_mode=0777,soft,user,noperm,vers=1.0 //10.10.67.243/send/ ./ftm
            # file_mode=0777,dir_mode=0777 is Optional
            sudo mount -o user="$1",password="$2",domain="$3",iocharset=utf8,soft,user,noperm,vers=1.0 "$4" "$5"
            ;;
        -w|win)     # mount windows cifs ver1.0 share folders.
            shift
            # sudo mount -t cifs -o user=03716,password=1234,domain=example.com,iocharset=utf8,file_mode=0777,dir_mode=0777,soft,user,noperm,vers=1.0 //10.10.67.243/send/ ./ftm
            # file_mode=0777,dir_mode=0777 is Optional
            sudo mount -t cifs -o user="$1",password="$2",domain="$3",iocharset=utf8,soft,user,noperm,vers=1.0 "$4" "$5"
            ;;
        -i|iso)
            shift
            # mount -o loop -t iso9660 FILENAME.ISO /mnt/iso
            mount -o loop -t iso9660 "$@"
            ;;
        -g|gnu)     # Use gnome command to mount samba shar folder in nautilus.
            shift
            gvfs-mount smb://"$1"
            ;;
    esac
    ;;
    -c|check)
    # If unmount device show "Device is busy"
    # Use this command to check which application occupation.
    # Ask kill this application or not.
    shift
    fuser -m -v -i -k "$@"
    ;;
    esac
}