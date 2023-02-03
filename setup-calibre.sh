#!/bin/bash
export DEBIAN_FRONTEND="noninteractive"

PACKAGES+=("xz-utils")

if [ ! -L /usr/lib/x86_64-linux-gnu/libGL.so.1 ]; then
    PACKAGES+=("libgl1-mesa-glx")
fi

if [ ! -L /usr/lib/x86_64-linux-gnu/libxdamage.so.1 ]; then
    PACKAGES+=("libxdamage1")
fi

if [ ! -L /usr/lib/x86_64-linux-gnu/libEGL.so.1 ]; then
    PACKAGES+=("libegl1")
fi

if [ ! -L /usr/lib/x86_64-linux-gnu/libxkbcommon.so.0 ]; then
    PACKAGES+=("libxkbcommon0")
fi

if [ ! -L /usr/lib/x86_64-linux-gnu/libOpenGL.so.0 ]; then
    PACKAGES+=("libopengl0")
fi

if [ -v "PACKAGES[@]" ]; then
    apt-get update
    apt-get install -y "${PACKAGES[@]}"
fi

echo "**** Fetching calibre bin ****" 
if [ -z ${CALIBRE_RELEASE+x} ]; then
    CALIBRE_RELEASE=$(curl -sX GET "https://api.github.com/repos/kovidgoyal/calibre/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
fi 

mkdir -p \
    /app/calibre

if [ "$(uname -m)" == "x86_64" ]; then
    curl -o \
        /tmp/calibre.txz -L \
        "https://github.com/kovidgoyal/calibre/releases/download/${CALIBRE_RELEASE}/calibre-${CALIBRE_RELEASE:1}-x86_64.txz"
fi

if [ "$(uname -m)" == "aarch64" ]; then
    curl -o \
        /tmp/calibre.txz -L \
        "https://github.com/kovidgoyal/calibre/releases/download/${CALIBRE_RELEASE}/calibre-${CALIBRE_RELEASE:1}-arm64.txz"
fi

tar xf \
    /tmp/calibre.txz \
    -C /app/calibre

rm /tmp/calibre.txz

if [ ! -e /usr/bin/calibre-server ]; then
    /app/calibre/calibre_postinstall
fi

rm $0