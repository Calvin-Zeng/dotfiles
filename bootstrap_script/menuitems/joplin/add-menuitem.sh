#!/bin/bash

APP_NAME="Joplin"
APP_VERSION="2.8.8"

die() {
  echo $1
  exit 1
}

[ -f $HOME/app_images/$APP_NAME/$APP_NAME-$APP_VERSION.AppImage ] && APP_BIN="$HOME/app_images/$APP_NAME";
[ -z $APP_BIN ] && die "Can't found any $APP_NAME path!";

ICON_NAME=Joplin
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/$APP_NAME.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=Joplin
GenericName=Notes tool
Comment=Joplin is a note-taking program for free-form information gathering and multi-user collaboration.
Exec=$APP_BIN/$APP_NAME-$APP_VERSION.AppImage

Terminal=false
MimeType=x-content/unix-software;
Icon=$ICON_NAME.png
Categories=Office;
StartupNotify=true
StartupWMClass=Joplin
#Actions=Window;Document;
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --novendor --size 48 "$ICON_NAME.png" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
