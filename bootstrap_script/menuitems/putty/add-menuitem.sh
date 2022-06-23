#!/bin/bash
# sudo apt-get install imagemagick
# cd putty-0.77/icons
# make

APP_NAME="putty"

die() {
  echo $1
  exit 1
}

[ -f /usr/local/bin/$APP_NAME ] && APP_BIN="/usr/local/bin";
[ -f $HOME/local/bin/$APP_NAME ] && APP_BIN="$HOME/local/bin";
[ -z $APP_BIN ] && die "Can't found any $APP_NAME path!";

ICON_NAME=simontatham-putty
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/putty.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=putty
GenericName=Develop tool
Comment=PuTTY is an SSH and telnet client,
Exec=$APP_BIN/putty

Terminal=false
MimeType=x-content/unix-software;
Icon=$ICON_NAME.png
Categories=Development;
StartupNotify=true
#Actions=Window;Document;
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --size 16 "$ICON_NAME-16.png" $ICON_NAME
xdg-icon-resource install --size 32 "$ICON_NAME-32.png" $ICON_NAME
xdg-icon-resource install --size 48 "$ICON_NAME-48.png" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
