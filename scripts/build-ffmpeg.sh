#!/bin/bash -e

. ../path.sh

mkdir -p _build
cd _build

../configure \
	--target-os=android --enable-cross-compile --cross-prefix=arm-linux-androideabi- \
	--arch=arm --cpu=armv7-a \
	--enable-static --disable-shared \
	--prefix="`pwd`/out" --disable-debug --disable-doc

make -j6
make install
