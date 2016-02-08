#!/bin/bash -e

. ../path.sh

[ -f configure ] || ./autogen.sh

FTPATH=`pwd`/../freetype2/_build/out
FBPATH=`pwd`/../fribidi/_build/out

mkdir -p _build
cd _build

PKG_CONFIG_LIBDIR="$FTPATH/lib/pkgconfig:$FBPATH/lib/pkgconfig" \
../configure \
	--host=arm-linux-androideabi \
	--enable-static --disable-shared \
	--disable-require-system-font-provider \
	--prefix="`pwd`/out"

make -j6
make install
