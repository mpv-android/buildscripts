#!/bin/bash -e

v_sdk=r24.4.1
v_ndk=r10e
v_lua=5.2.4
v_fribidi=0.19.7

# android-ndk-$v_ndk
wget http://dl.google.com/android/ndk/android-ndk-$v_ndk-linux-x86_64.bin
7z x android-ndk-$v_ndk-linux-x86_64.bin
rm android-ndk-$v_ndk-linux-x86_64.bin

# android-sdk-linux
wget http://dl.google.com/android/android-sdk_$v_sdk-linux.tgz -O - | \
	tar -xz -f -

# ndk-toolchain
cd android-ndk-$v_ndk
./build/tools/make-standalone-toolchain.sh \
	--arch=arm --platform=android-19 --toolchain=arm-linux-androideabi-4.9 \
	--install-dir=`pwd`/../ndk-toolchain
cd ..

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

# openal-soft-android
git clone https://github.com/AerialX/openal-soft-android

# mpv 
git clone -b android https://github.com/xyzz/mpv

# mpv-android
git clone https://github.com/xyzz/mpv-android
