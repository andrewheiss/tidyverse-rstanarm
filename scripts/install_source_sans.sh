#!/usr/bin/env sh
FONT_NAME="SourceSansPro"
FONT_URL="https://github.com/adobe-fonts/source-sans-pro/archive/2.020R-ro/1.075R-it.zip"

mkdir /tmp/${FONT_NAME}
cd /tmp/${FONT_NAME}
wget ${FONT_URL} -O ${FONT_NAME}.zip
unzip -o -j ${FONT_NAME}.zip
cp *.otf /usr/share/fonts
fc-cache -f -v
