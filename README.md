# Building

## Download dependencies

`download.sh` will take of installing the Android SDK/NDK and downloading the sources.

```
./download.sh
```

## Install Android SDK

Run `./android-sdk-linux/tools/android` and check `Android 4.4.2 (API 19)`. You don't need things named `** system image`.

## Build

```
./buildall.sh
```

Run `buildall.sh` with `--clean` to clean the build directories before building.

# Credits, notes, etc

These build scripts were created by @sfan5, thanks!

