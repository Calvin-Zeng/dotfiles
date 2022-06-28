#!/bin/bash
xdg-desktop-menu uninstall chromeopen.desktop
xdg-mime uninstall --mode user chromeopen.xml
xdg-icon-resource uninstall --context mimetypes --size 16 application-x-mswinurl
xdg-icon-resource uninstall --context mimetypes --size 24 application-x-mswinurl
xdg-icon-resource uninstall --context mimetypes --size 48 application-x-mswinurl
xdg-icon-resource uninstall --context mimetypes --size 64 application-x-mswinurl
xdg-icon-resource uninstall --context mimetypes --size 128 application-x-mswinurl
xdg-icon-resource uninstall --context mimetypes --size 256 application-x-mswinurl
update-mime-database ~/.local/share/mime
update-icon-caches ~/.local/share/icons
