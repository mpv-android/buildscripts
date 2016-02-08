#!/bin/bash -e

. ../path.sh

mkdir -p _build
cd _build

PKG_CONFIG=/bin/false cmake .. \
	-DCMAKE_C_COMPILER=arm-linux-androideabi-gcc \
	-DCMAKE_FIND_ROOT_PATH=`pwd`/../../ndk-toolchain/sysroot \
	-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
	-DCMAKE_INSTALL_PREFIX=`pwd`/out \
	-DWAVE=0 -DANDROID=0 -DREQUIRE_OPENSL=1 \
	-DCMAKE_BUILD_TYPE=Release -DUTILS=0 -DLIBTYPE=STATIC

make -j6
make install
