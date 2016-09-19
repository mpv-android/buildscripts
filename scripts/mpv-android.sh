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

PREFIX=`pwd`/../prefix/ PREFIX64=`pwd`/../prefix64 NDK_TOOLCHAIN_VERSION=4.9 ndk-build -C app/src/main
./gradlew assembleDebug
