#!/bin/bash

version=v0.3.2
file="grv_${version}_linux64"
url="https://github.com/rgburke/grv/releases/download/v0.3.2/"
install_prefix=$HOME/local/bin

die() {
  echo $1
  exit 1
}

[ -f grv ] || wget -O grv $url/$file
[ $? -eq  0 ] || die "Download the $url/$file fail!"
chmod +x ./grv
cp ./grv $install_prefix
echo 'Finished.'
