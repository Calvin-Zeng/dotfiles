#!/bin/bash

APP_NAME="OneNote"
APP_VERSION="2022.4.127"

die() {
  echo $1
  exit 1
}

[ -f $HOME/app_images/$APP_NAME/P3X-$APP_NAME-$APP_VERSION.AppImage ] && APP_BIN="$HOME/app_images/$APP_NAME";
[ -z $APP_BIN ] && die "Can't found any $APP_NAME path!";

ICON_NAME=OneNote
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/$APP_NAME.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=p3x-onenote
GenericName=Notes tool
Comment=Microsoft OneNote is a note-taking program for free-form information gathering and multi-user collaboration.
Exec$APP_BIN/P3X-$APP_NAME-$APP_VERSION.AppImage


Terminal=false
MimeType=x-content/unix-software;
Icon=$ICON_NAME.svg
Categories=Office;WordProcessor;
StartupNotify=true
StartupWMClass=p3x-onenote
#Actions=Window;Document;
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --novendor --size 48 "$ICON_NAME.svg" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
