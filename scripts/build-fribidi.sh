#!/bin/bash -e

. ../path.sh

# You'll need to use the non-git version of fribidi as the git version is missing some files

mkdir -p _build
cd _build

PKG_CONFIG=/bin/false \
../configure \
	--host=arm-linux-androideabi \
	--enable-static --disable-shared \
	--prefix="`pwd`/out"

make -j6
make install
