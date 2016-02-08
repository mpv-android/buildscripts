#!/bin/bash -e

CLEANBUILD=0

cd ffmpeg
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-ffmpeg.sh
cd ..

cd freetype2
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-freetype2.sh
cd ..

cd fribidi
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-fribidi.sh
cd ..

# dep: freetype2, fribidi
cd libass
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-libass.sh
cd ..

# cd lua
# [ $CLEANBUILD -eq 1 ] && make clean
# ./build.sh
# cd ..

cd openal-soft-android
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-openal.sh
cd ..

# dep: ffmpeg, libass, lua, openal-soft-android
cd mpv
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-mpv.sh
cd ..

# dep: mpv
cd mpv-android
[ $CLEANBUILD -eq 1 ] && rm -rf bin gen libs obj
../scripts/build-mpv-android.sh
cd ..

ls -lh ./mpv-android/bin/MPVActivity-debug.apk
