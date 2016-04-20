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

[ -f builds/unix/configure ] || ./autogen.sh

mkdir -p _build
cd _build

PKG_CONFIG=/bin/false \
../configure \
	--host=arm-linux-androideabi \
	--enable-static --disable-shared \
	--with-png=no \
	--prefix="`pwd`/../../../prefix"

make -j6
make install
