#!/bin/bash -e

CLEANBUILD=0

cd FFmpeg
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-ffmpeg.sh
cd ..

cd openal-soft-android
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-openal.sh
cd ..

cd mpv
[ $CLEANBUILD -eq 1 ] && rm -rf _build
../scripts/build-mpv.sh
cd ..

cd mpv-android
[ $CLEANBUILD -eq 1 ] && rm -rf bin gen libs obj
../scripts/build-mpv-android.sh
cd ..

ls -lh ./mpv-android/bin/MPVActivity-debug.apk
