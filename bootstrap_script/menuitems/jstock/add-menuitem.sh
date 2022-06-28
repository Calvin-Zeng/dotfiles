#!/bin/bash

APP_NAME="jstock"

die() {
  echo $1
  exit 1
}

[ -f $HOME/app_images/jstock/$APP_NAME.sh ] && APP_BIN="$HOME/app_images/jstock";
[ -z $APP_BIN ] && die "Can't found any $APP_NAME path!";

ICON_NAME=jstock
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/$APP_NAME.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Name=JStock
GenericName=JStock
Comment=Stock market software
Exec=$APP_BIN/$APP_NAME.sh
Terminal=false
Type=Application
Icon=$ICON_NAME.png
Categories=GNOME;GTK;Utility
StartupNotify=false
StartupWMClass=org-yccheok-jstock-gui-JStock
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --novendor --size 48 "$ICON_NAME.png" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
