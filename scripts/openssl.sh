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

plat=android-armeabi
[[ "$ndk_triple" == "aarch64"* ]] && plat=android64-aarch64

CROSS_COMPILE=$ndk_triple- \
../Configure $plat \
	no-shared \
	--prefix="`pwd`/../../../prefix$dir_suffix"

CROSS_SYSROOT=$(dirname "$(which $ndk_triple-gcc)")/../sysroot \
make -j6
make install_sw # openssl takes AGES to install docs otherwise
