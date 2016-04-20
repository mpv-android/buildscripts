#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH="$DIR/sdk/ndk-toolchain/bin:$DIR/sdk/android-ndk-r11c:$DIR/sdk/android-sdk-linux/tools:$PATH"
export ANDROID_HOME="$DIR/sdk/android-sdk-linux"
