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

mkdir -p _build
cd _build

../configure \
	--target-os=android --enable-cross-compile --cross-prefix=arm-linux-androideabi- \
	--arch=arm --cpu=armv7-a --enable-jni --enable-mediacodec \
	--disable-static --enable-shared \
	--prefix="`pwd`/out" --disable-debug --disable-doc

make -j6
make install
