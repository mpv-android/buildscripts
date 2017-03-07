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

nativeprefix () {
	if [ -f ../$1/lib/libmpv.so ]; then
		echo $PWD/../$1
	else
		echo >&2 "Warning: libmpv.so not found in native prefix for $2, support will be omitted"
	fi
}

prefix64=$(nativeprefix prefix64 "arm64")
prefix_x64=$(nativeprefix prefix-x64 "x86_64")

PREFIX=$PWD/../prefix PREFIX64=$prefix64 PREFIX_X64=$prefix_x64 \
NDK_TOOLCHAIN_VERSION=4.9 \
ndk-build -C app/src/main
./gradlew assembleDebug
