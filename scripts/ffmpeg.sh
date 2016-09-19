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

mkdir -p _build$dir_suffix
cd _build$dir_suffix

cpu=armv7-a
[[ "$ndk_triple" == "aarch64"* ]] && cpu=armv8-a

../configure \
	--target-os=android --enable-cross-compile --cross-prefix=$ndk_triple- \
	--arch=${ndk_triple%%-*} --cpu=$cpu --enable-jni --enable-mediacodec \
	--disable-static --enable-shared \
	--prefix="`pwd`/../../../prefix$dir_suffix" --disable-debug --disable-doc

make -j6
make install
