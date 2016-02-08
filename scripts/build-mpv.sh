#!/bin/bash -e

. ../path.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# mpv needs another hack for linking to work
export PATH="$DIR/../bin:$PATH"

FFPATH=`pwd`/../ffmpeg/_build/out
ALPATH=`pwd`/../openal-soft-android/_build/out

./bootstrap.py

CC=arm-linux-androideabi-gcc LDFLAGS="-llog -lOpenSLES" \
PKG_CONFIG_LIBDIR="$FFPATH/lib/pkgconfig:$ALPATH/lib/pkgconfig" \
./waf configure \
	--enable-android --disable-iconv --disable-libass --enable-openal \
	--enable-libmpv-shared \
	--prefix=/ --disable-debug-build --disable-manpage-build \
	-o "`pwd`/_build"

./waf build -p -j6
./waf install --destdir="`pwd`/_build/out"
arm-linux-androideabi-strip ./_build/out/lib/libmpv.so # unstripped libraries confuse ndk-build
