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

[ -f configure ] || ./autogen.sh

mkdir -p _build
cd _build

PKG_CONFIG_LIBDIR="`pwd`/../../../prefix/lib/pkgconfig" \
../configure \
	--host=arm-linux-androideabi \
	--enable-static --disable-shared \
	--disable-require-system-font-provider \
	--prefix="`pwd`/../../../prefix"

make -j6
make install
