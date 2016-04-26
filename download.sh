#!/bin/bash -e

v_sdk=r24.4.1
v_ndk=r11c
v_lua=5.2.4
v_fribidi=0.19.7

. ./path.sh # load $os var

if [ "$os" == "linux" ]; then
	sdk_ext="tgz"
	os_ndk="linux"
elif [ "$os" == "macosx" ]; then
	sdk_ext="zip"
	os_ndk="darwin"
	if hash ginstall 2>/dev/null; then
		true
	else
		echo "Error: ginstall not found. You probably need GNU coreutils."
		exit 255
	fi
fi

mkdir -p sdk && cd sdk

# android-sdk-linux
if [ "$os" == "linux" ]; then
	wget "http://dl.google.com/android/android-sdk_${v_sdk}-${os}.${sdk_ext}" -O - | \
		tar -xz -f -
elif [ "$os" == "macosx" ]; then
	wget "http://dl.google.com/android/android-sdk_${v_sdk}-${os}.${sdk_ext}"
	unzip "android-sdk_${v_sdk}-${os}.${sdk_ext}"
	rm "android-sdk_${v_sdk}-${os}.${sdk_ext}"
fi
"./android-sdk-${os}/tools/android" update sdk --no-ui --all --filter build-tools-23.0.3,android-23,extra-android-m2repository

# android-ndk-$v_ndk
wget "http://dl.google.com/android/repository/android-ndk-${v_ndk}-${os_ndk}-x86_64.zip"
unzip "android-ndk-${v_ndk}-${os_ndk}-x86_64.zip"
rm "android-ndk-${v_ndk}-${os_ndk}-x86_64.zip"

# ndk-toolchain
cd "android-ndk-${v_ndk}"
./build/tools/make-standalone-toolchain.sh \
	--arch=arm --platform=android-19 --toolchain=arm-linux-androideabi-4.9 \
	--install-dir=`pwd`/../ndk-toolchain
cd ..

cd ..

mkdir -p deps && cd deps

# ffmpeg
git clone https://github.com/FFmpeg/FFmpeg ffmpeg

# freetype2
git clone git://git.sv.nongnu.org/freetype/freetype2.git

# fribidi
mkdir fribidi
cd fribidi
wget http://fribidi.org/download/fribidi-$v_fribidi.tar.bz2 -O - | \
	tar -xj -f - --strip-components=1
cd ..

# libass
git clone https://github.com/libass/libass

# lua
mkdir lua
cd lua
wget http://www.lua.org/ftp/lua-$v_lua.tar.gz -O - | \
	tar -xz -f - --strip-components=1
cd ..

# mpv
git clone https://github.com/mpv-player/mpv

cd ..

# mpv-android
git clone https://github.com/mpv-android/mpv-android
