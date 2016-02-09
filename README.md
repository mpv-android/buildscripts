# Building

## Download dependencies

`download.sh` will take of installing the Android SDK/NDK and downloading the sources.

```
./download.sh
```

## Install Android SDK components

Run `./android-sdk-linux/tools/android` and check `Android 4.4.2 (API 19)` and `Android 6.0 (API 23)`. You don't need things named `** system image`.

Additionally install `Android SDK Build-tools` version 23.0.2 and `Android Support Repository`.

## Build

```
./buildall.sh
```

Run `buildall.sh` with `--clean` to clean the build directories before building.

# Credits, notes, etc

These build scripts were created by @sfan5, thanks!

