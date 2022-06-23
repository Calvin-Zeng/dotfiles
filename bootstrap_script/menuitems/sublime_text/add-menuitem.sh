#!/bin/bash

APP_NAME="sublime_text"

die() {
  echo $1
  exit 1
}

[ -f /opt/sublime_text/$APP_NAME ] && APP_BIN="/opt/sublime_text";
[ -f $HOME/app_images/sublime_text/$APP_NAME ] && APP_BIN="$HOME/app_images/sublime_text";
[ -z $APP_BIN ] && die "Can't found any $APP_NAME path!";

ICON_NAME=sublime-text
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/$APP_NAME.desktop
cat << EOF > $DESKTOP_FILE
# im-config - For ibus use.
#   Exec=$APP_BIN/$APP_NAME %F
# 
# im-config - For fcitx use.
# Common use in Ubuntu 18.04 version before.
#   Exec=env LD_PRELOAD=$HOME/dotfiles/sublime-text/imfix/Method1/libsublime-imfix.so $APP_BIN/$APP_NAME %F
#   Exec=env LD_PRELOAD=$HOME/dotfiles/sublime-text/imfix/Method2/libsublime-imfix.so $APP_BIN/$APP_NAME %F
# $HOME/dotfiles/sublime-text/imfix/Method2/libsublime-imfix.so 

[Desktop Entry]
Version=1.0
Type=Application
Name=Sublime Text
GenericName=Text Editor
Comment=Sophisticated text editor for code, markup and prose 
Exec=$APP_BIN/$APP_NAME %F

Terminal=false
MimeType=text/plain;
Icon=$ICON_NAME.png
Categories=TextEditor;Development;
StartupNotify=true
Actions=new-window;new-file;

[Desktop Action new-window]
Name=New Window
Exec=$APP_BIN/$APP_NAME -n
OnlyShowIn=Unity;

[Desktop Action new-file]
Name=New File
Exec=$APP_BIN/$APP_NAME --command new_file
OnlyShowIn=Unity;
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE
 
xdg-desktop-menu install $DESKTOP_FILE
xdg-icon-resource install --novendor --size 16 "$APP_BIN/Icon/16x16/$ICON_NAME.png" $ICON_NAME
xdg-icon-resource install --novendor --size 32 "$APP_BIN/Icon/32x32/$ICON_NAME.png" $ICON_NAME
xdg-icon-resource install --novendor --size 48 "$APP_BIN/Icon/48x48/$ICON_NAME.png" $ICON_NAME
xdg-icon-resource install --novendor --size 128 "$APP_BIN/Icon/128x128/$ICON_NAME.png" $ICON_NAME
xdg-icon-resource install --novendor --size 256 "$APP_BIN/Icon/256x256/$ICON_NAME.png" $ICON_NAME

rm $DESKTOP_FILE
rm -R $TMP_DIR
