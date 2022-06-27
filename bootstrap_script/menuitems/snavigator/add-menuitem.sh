#!/bin/bash

APP_NAME="snavigator"

die() {
  echo $1
  exit 1
}

[ -f /usr/local/bin/$APP_NAME ] && APP_BIN="/usr/local/bin";
[ -f $HOME/local/bin/$APP_NAME ] && APP_BIN="$HOME/local/bin";
[ -z $APP_BIN ] && die "Can't found any $APP_NAME path!";

ICON_NAME=snavigator
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/$APP_NAME.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=snavigator
GenericName=Analysis tool
Comment=source navigator NG is a source code analysis tool.
Exec=$APP_BIN/$APP_NAME

Terminal=false
MimeType=x-content/unix-software;
Icon=$ICON_NAME.png
Categories=TextEditor;Development;
StartupNotify=true
StartupWMClass=MultiWindow&
Actions=Window;Document;
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --novendor --size 48 "$ICON_NAME.png" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
