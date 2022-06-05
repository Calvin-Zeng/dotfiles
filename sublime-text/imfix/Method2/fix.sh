#!/bin/bash

printf "複製 libsublime-imfix.so 到 /opt/sublime_text \n"
sudo cp libsublime-imfix.so /opt/sublime_text

printf "複製 subl 到 /usr/bin/subl \n"
sudo cp subl /usr/bin/subl
sudo chmod 755 /usr/bin/subl

printf "複製 sublime_text.desktop 到 /usr/share/applications/sublime_text.desktop \n"
sudo cp sublime_text.desktop /usr/share/applications/sublime_text.desktop

printf "完成"
