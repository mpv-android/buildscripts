#!/bin/bash -e

. ../path.sh

[ -f builds/unix/configure ] || ./autogen.sh

mkdir -p _build
cd _build

PKG_CONFIG=/bin/false \
../configure \
	--host=arm-linux-androideabi \
	--enable-static --disable-shared \
	--with-png=no \
	--prefix="`pwd`/out"

make -j6
make install
