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

prefix="`pwd`/../../../prefix$dir_suffix"
../configure \
	--target-os=android --enable-cross-compile --cross-prefix=$ndk_triple- \
	--extra-cflags="-I$prefix/include" \
	--extra-ldflags="-L$prefix/lib" \
	--arch=${ndk_triple%%-*} --cpu=$cpu --enable-{jni,mediacodec,openssl} \
	--disable-static --enable-shared \
	--prefix="$prefix" --disable-debug --disable-doc

make -j6
make install
