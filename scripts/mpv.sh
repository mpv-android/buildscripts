#!/bin/bash -e

. ../../path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build$dir_suffix
	exit 0
else
	exit 255
fi

[ -f waf ] || ./bootstrap.py

CC=$ndk_triple-gcc \
PKG_CONFIG_LIBDIR="`pwd`/../../prefix$dir_suffix/lib/pkgconfig" \
./waf configure \
	--disable-iconv --lua=52 \
	--enable-libmpv-shared \
	--prefix=/ --disable-manpage-build \
	-o "`pwd`/_build$dir_suffix"

./waf build -p -j6
./waf install --destdir="`pwd`/../../prefix$dir_suffix"
