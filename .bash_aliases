# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -aF --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
# alias ll='ls -alF'
alias ll='ls -lsaF'
alias lll='ll --color | less -r'
alias la='ls -A'
alias l='ls -CF'
alias lsd='ls -l | grep '^d''  # Or: ls -d */
alias lf='ls -l | egrep -v '^d''

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias sourcebashrc='source ~/.bashrc'
alias help='tldr'
alias cat='bat'
alias beep="paplay /usr/share/sounds/ubuntu/stereo/message.ogg"

# chmod and permissions commands
alias mx='chmod a+x'
alias own='sudo chown'
alias 000='chmod 000'
alias 600='chmod 600'
alias 644='chmod 644'
alias 664='chmod 664'
alias 755='chmod 755'
alias 777='chmod 777'
alias smx='sudo chmod a+x'
alias s000='sudo chmod 000'
alias s600='sudo chmod 600'
alias s644='sudo chmod 644'
alias s664='sudo chmod 664'
alias s755='sudo chmod 755'
alias s777='sudo chmod 777'

# Directories
alias {up,..}='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# Put string to x11 clipboard.
alias xc='xclip -selection clipboard'
alias xc0='nto0 | xclip -selection clipboard'
# Put specific path(dir or file) with out \r\n to x11 clipboard.
alias xcpwd='pwd | nto0 | xclip -selection clipboard'
# Copy file or dir to to X11 clipboard
alias xcfcp='xclip-copyfile'
# Cut file or dir to to X11 clipboard
alias xcfcu='xclip-cutfile'
# Paste file or dir to to X11 clipboard
alias xcfp='xclip-pastefile'

# Command "read" or "showkey -a" to print key code.
alias {showkey,ascii}='echo -e "AscII\t Dec Oct Hex"; showkey -a'

# Output
# echo "abc" | lcase
alias lcase="tr '[:upper:]' '[:lower:]'"
alias ucase="tr '[:lower:]' '[:upper:]'"

# Extra xargs
# When fzf is enable, Need annotate code below.
# alias xargs='xargs -t -0 --no-run-if-empty'
alias xargs1='xargs -t -0 -L 1 --no-run-if-empty'
alias xargsc='xargs -p -0 --no-run-if-empty'
alias xargsc1='xargs -p -0 -L 1 --no-run-if-empty'

# Replace \n  to \0
alias nto0='tr "\n" "\0"'

# Now time
alias dt="date '+%m%d%Y_%s'"

# nice [-20 ~ 19] [command-name] (-20 is highest,19 is lowest)
# nice = 20,The [command-name] executed when no another program in system.
# nice -n [nice] [command-name]
alias priority='nice -n'

# renice [nice] [PID]
alias priorityr='renice'

# also sort -R filename work.
alias randsort='shuf'

# gnome-open opens a file with Gnome's default application
# kde-open opens a file with KDE's default application
alias xopen='xdg-open'

# Use gnome-panel to create a shortcut.
alias addshortcut=' gnome-desktop-item-edit --create-new ./'

# List which daemon occupy port.
# Example:
# lsofport tcp:80
alias lsofport='lsof -i'

# Force system shutdown/reboot
alias shutdown_force='echo 1 | sudo tee /proc/sys/kernel/sysrq; echo o | sudo tee /proc/sysrq-trigger'
alias reboot_force='echo 1 | sudo tee /proc/sys/kernel/sysrq; echo b | sudo tee /proc/sysrq-trigger'

# List current active daemon service.
# sudo systemctl start [service name]
# sudo systemctl stop [service name]
# sudo systemctl restart [service name]
# sudo systemctl reload [service name]
# sudo systemctl enable [service name]
# sudo systemctl disable [service name]
alias systemctl_list='systemctl list-units --type=service --all'
alias systemctl_depend=' systemctl list-dependencies'

# ubuntu version
# Also work:
# uname -a
# cat /etc/*release
# cat /etc/lsb-release
# cat /etc/issue
alias ubuntu_info='lsb_release -a'
# ubuntu-linux-package-support-status
alias ubuntu_packageinfo='ubuntu-support-status'

# apt-get alias
alias saptin='sudo apt-get install'
alias saptup='sudo apt-get update'

#  downgrade
# Reference:
# https://blog.longwin.com.tw/2017/05/debian-package-downgrade-rollback-2017/
# --downgrade specific software:
# sudo dpkg --force-downgrade -i /var/cache/apt/archives/{percona-server-common-5.75.7.17-11-1.jessieamd64.deb, percona-server-server-5.75.7.17-11-1.jessieamd64.deb,percona-server-client-5.75.7.17-11-1.jessieamd64.deb}
# sudo apt-get install percona-server-common-5.7=5.7.17-11-1.jessie percona-server-server-5.7=5.7.17-11-1.jessie percona-server-client-5.7=5.7.17-11-1.jessie
# --downgrade all software:
# apt-history rollback > rollback.txt
# apt-get -s install $(cat rollback.txt | tr '\n' ' ')
# or apt-get install $(cat rollback.txt | tr '\n' ' ')
# List all file of package:
#   dpkg -L fzf
alias saptdw='sudo dpkg --force-downgrade -i'

# Delete software,leave config file.
alias saptre='sudo apt-get remove'
# Delete software and config file.
alias saptpu='sudo apt-get remove --purge'
# apt-get autoclean just remove out of date deb package file.
alias saptcl='sudo apt-get autoclean && sudo apt-get autoremove'
# Delete /var/cache/apt/archives/ cache file.
alias saptclpackage='sudo apt-get clean'
# Only download package file not install.
alias saptdl='sudo apt-get install --download-only'
# Show depends library of package.
alias saptdepends='apt-cache depends'
# alias saptdepends='apt-cache show build-essential | grep ^Depends'
# Show current installed package.
alias aptinfo='apt-cache policy'
# Show current available package in archive.
alias aptmadison='apt-cache madison'
# Show changelog of package.
alias aptchangelog='sudo apt-get changelog'

# cmake
# Debug & Release in CMAKE
# Reference:
# https://stackoverflow.com/questions/7724569/debug-vs-release-in-cmake
alias cmake_debug='cmake -DCMAKE_BUILD_TYPE=Debug'
alias cmake_release='cmake -DCMAKE_BUILD_TYPE=Release'

# Show all function in *.so
alias dumpsofunc='readelf -s'
# File output to binary.
alias dumpbinary='xxd -b'
# EASY CLI JSON FORMATTING
# Ex: echo '{"json":"obj"}' | python -mjson.tool
alias dumpjson='python -mjson.tool'

# Update locate datebase.
alias locateupdate='sudo updatedb -U ./'

# Find file or folder permission.
alias find_notpermdir='find ./ -type d -not -perm'
alias find_permdir='find ./ -type d -perm'
alias find_notpermfile='find ./ -type f -not -perm'
alias find_permfile='find ./ -type f -perm'

# Clear file content.
alias fileclear='cat /dev/null >'

# grep set
alias _grep_mac='grep -o -E "'"([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}"'"'
alias _grep_ip='grep -o "'"inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)"'" | sed 's/inet.//g''

alias turnscreenoff='sleep 5;xset dpms force off'
# alias turntouchpadon='xinput enable $TOUCHPAD'
# alias turntouchpadoff='xinput disable $TOUCHPAD'
alias turntouchpad='sh $CALVINSCRIPT/Linux/fn_touchpad-fix.sh'

# Zenity Alias
alias {zenity_pcolor,colorsel}='zenity --color-selection'

# GNOME desktop environment setting
# Enable click to minimize on Ubuntu using command line (recommended):
#       gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
#       gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'skip'
#       gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'cycle-windows'
#       gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'previews'
#   Set it back to default:
#       gsettings reset org.gnome.shell.extensions.dash-to-dock click-action
#   Adjsut mouse speed:
#       Formula equivalent to:
#       800 <-----> 6400 dpi
#       -1  <-----> 1
#       6400 - 800 = 5400 / 20 (step) = 280 dpi/ 1 step
#       800 + 280x = 2000 dpi (You want 2000 dpi.)
#       x = 4.28571429
#       4.28571429 * 0.1 = 0.42857143
#       0.42857143 - 1 = -0.57142857
#       gsettings set org.gnome.desktop.peripherals.mouse speed -0.57142857  -> 2000 dpi
#
# How to make finer volume-steps in Ubuntu (Unity)?
#   Reference:
#   https://askubuntu.com/questions/10525/how-can-i-make-the-volume-change-in-smaller-increments
#   https://askubuntu.com/questions/908050/how-to-make-finer-volume-steps-in-ubuntu-unity-17-04
#   Solution 1:
#      gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 1
#      gsettings get org.gnome.settings-daemon.plugins.media-keys volume-step
#   Solution 2:
#       Press Shift+XF86AudioRaiseVolume or Shift+XF86AudioLowerVolume (usually the dedicated volume up / down keys on the keyboard) to change the volume with a smaller step size.

# Setting Gnome screen sacle.
# xrandr --output eDP-1 --scale 0.5x0.5 --output HDMI-1 --scale 2x2
# xrandr --output HDMI-1 --off
alias gsettingsscaling='gsettings set org.gnome.desktop.interface text-scaling-factor'
alias gsettingsscalingreset='gsettings reset org.gnome.desktop.interface text-scaling-factor'
