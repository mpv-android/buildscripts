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

# You'll need to use the non-git version of fribidi as the git version is missing some files

mkdir -p _build
cd _build

PKG_CONFIG=/bin/false \
../configure \
	--host=arm-linux-androideabi \
	--enable-static --disable-shared \
	--prefix="`pwd`/../../../prefix"

make -j6
make install
