#!/bin/bash -e

. ../path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf {app,.}/build app/src/main/{libs,obj}
	exit 0
else
	exit 255
fi

if [ -f ../prefix64/lib/libmpv.so ]; then
	prefix64=$PWD/../prefix64
else
	echo >&2 "Warning: libmpv.so not found in native prefix for arm64, support will be omitted"
	prefix64=
fi

PREFIX=$PWD/../prefix PREFIX64=$prefix64 \
NDK_TOOLCHAIN_VERSION=4.9 \
ndk-build -C app/src/main
./gradlew assembleDebug
