#!/bin/bash -e

. ../path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build
	exit 0
else
	exit 255
fi

FFPATH=`pwd`/../ffmpeg/_build/out
ASPATH=`pwd`/../libass/_build/out
LUPATH=`pwd`/../lua/_build/out
ALPATH=`pwd`/../openal-soft-android/_build/out
# required by libass:
FTPATH=`pwd`/../freetype2/_build/out
FBPATH=`pwd`/../fribidi/_build/out

[ -f waf ] || ./bootstrap.py

CC=arm-linux-androideabi-gcc LDFLAGS="-llog -lOpenSLES" \
PKG_CONFIG_LIBDIR="$FFPATH/lib/pkgconfig:$ASPATH/lib/pkgconfig:$LUPATH/lib/pkgconfig:$ALPATH/lib/pkgconfig:$FTPATH/lib/pkgconfig:$FBPATH/lib/pkgconfig" \
./waf configure \
	--enable-android --disable-iconv --enable-openal --lua=52 \
	--enable-libmpv-shared \
	--prefix=/ --disable-debug-build --disable-manpage-build \
	-o "`pwd`/_build"

./waf build -p -j6
./waf install --destdir="`pwd`/_build/out"
