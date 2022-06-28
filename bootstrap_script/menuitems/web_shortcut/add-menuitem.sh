#!/bin/bash
# refer to https://unix.stackexchange.com/questions/585997/assign-an-icon-to-a-custom-mimetype
#          https://askubuntu.com/questions/1238924/assign-an-icon-to-a-custom-mimetype

ICON_NAME=application-x-mswinurl
TMP_DIR=`mktemp --directory` 
DESKTOP_FILE=$TMP_DIR/chromeopen.desktop
cat << EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=Web Shortcut
GenericName=perl script
Comment=Open Windows .url extension with script.
Exec=$HOME/dotfiles/bash_library/script/chromeopen.sh %F

Terminal=false
#MimeType=text/x-url;
MimeType=application/x-mswinurl;
Icon=$ICON_NAME.png
Categories=Text;
StartupNotify=true
Actions=Window;Document;
EOF

# seems necessary to refresh immediately:
chmod 644 $DESKTOP_FILE

# Note: Maybe need add this syntax to /etc/mime.types?
# application/x-mswinurl          		url 
xdg-desktop-menu install $DESKTOP_FILE
xdg-mime install --mode user chromeopen.xml
xdg-icon-resource install --context mimetypes --size 16 "${ICON_NAME}_16.png" $ICON_NAME
xdg-icon-resource install --context mimetypes --size 24 "${ICON_NAME}_24.png" $ICON_NAME
xdg-icon-resource install --context mimetypes --size 48 "${ICON_NAME}_48.png" $ICON_NAME
xdg-icon-resource install --context mimetypes --size 64 "${ICON_NAME}_64.png" $ICON_NAME
xdg-icon-resource install --context mimetypes --size 128 "${ICON_NAME}_128.png" $ICON_NAME
xdg-icon-resource install --context mimetypes --size 256 "${ICON_NAME}_256.png" $ICON_NAME
update-mime-database ~/.local/share/mime
update-icon-caches ~/.local/share/icons

rm $DESKTOP_FILE
rm -R $TMP_DIR
