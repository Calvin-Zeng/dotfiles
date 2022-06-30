#!/bin/bash

APP_NAME="OpenShot"
APP_VERSION="v2.6.1-x86_64"

die() {
  echo $1
  exit 1
}

[ -f $HOME/app_images/$APP_NAME/$APP_NAME-$APP_VERSION.AppImage ] && APP_BIN="$HOME/app_images/$APP_NAME";
[ -z $APP_BIN ] && die "Can't found any $APP_NAME path!";

ICON_NAME=OpenShot
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/$APP_NAME.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=OpenShot
GenericName=Video Editor
Comment=We designed OpenShot Video Editor to be an easy to use, quick to learn, and surprisingly powerful video editor.
Exec=$APP_BIN/$APP_NAME-$APP_VERSION.AppImage

Terminal=false
MimeType=x-content/unix-software;
Icon=$ICON_NAME.svg
Categories=Video;
StartupNotify=true
#Actions=Windows;
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --novendor --size 48 "$ICON_NAME.svg" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
