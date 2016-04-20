#!/bin/bash -e

. ../../path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build
	exit 0
else
	exit 255
fi

[ -f waf ] || ./bootstrap.py

CC=arm-linux-androideabi-gcc \
PKG_CONFIG_LIBDIR="`pwd`/../../prefix/lib/pkgconfig" \
./waf configure \
	--disable-iconv --lua=52 \
	--enable-libmpv-shared \
	--prefix=/ --disable-manpage-build \
	-o "`pwd`/_build"

./waf build -p -j6
./waf install --destdir="`pwd`/../../prefix"
