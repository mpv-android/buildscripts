#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH="$DIR/ndk-toolchain/bin:$DIR/android-ndk-r10e:$DIR/android-sdk-linux/tools:$PATH"
#export ANDROID_HOME="$DIR/android-sdk-linux"
