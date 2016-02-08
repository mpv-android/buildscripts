# Building

## Install Android SDK/NDK

SDK: Download `android-sdk_r24.4.1-linux.tgz` from https://developer.android.com/sdk/index.html#Other and untar to `android-sdk-linux`

NDK: Download `android-ndk-r10e-linux-x86_64.bin` from https://developer.android.com/ndk/downloads/index.html and unpack to `android-ndk-r10e`

## Clone repositories

```
git clone https://github.com/FFmpeg/FFmpeg.git
git clone https://github.com/AerialX/openal-soft-android.git
git clone https://github.com/xyzz/mpv-android.git
git clone https://github.com/xyzz/mpv.git && cd mpv && git checkout android && cd ..
```

## Install Android SDK

Run `./android-sdk-linux/tools/android` and check `Android 4.4.2 (API 19)`. You don't need things named `** system image`.

## Make a standalone NDK toolchain

```
./toolchain.sh
```

## Build

```
./buildall.sh
```

# Credits, notes, etc

These build scripts were created by @sfan5, thanks!

A huge hack lives in the `bin` directory, since I don't know `waf` at all this is the only way I could come up with to ensure that when linking static libs all required symbols are kept. Another problem the hack solves is setting the `soname` of the generated mpv library to `libmpv.so` (no version).
