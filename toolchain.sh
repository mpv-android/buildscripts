#!/bin/bash -e

cd android-ndk-r10e
./build/tools/make-standalone-toolchain.sh \
	--arch=arm --platform=android-19 --toolchain=arm-linux-androideabi-4.9 \
	--install-dir=`pwd`/../ndk-toolchain

