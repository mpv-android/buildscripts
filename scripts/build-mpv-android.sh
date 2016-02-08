#!/bin/bash -e

. ../path.sh

PREFIX=`pwd`/../mpv/_build/out NDK_TOOLCHAIN_VERSION=4.9 ndk-build
android update project -p . --target android-19 --subprojects
ant debug
