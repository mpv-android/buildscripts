#!/bin/bash -e

cleanbuild=0
nodeps=0
target=mpv-android

# i would've used a dict but putting arrays in a dict is not a thing

dep_ffmpeg=()
dep_freetype2=()
dep_fribidi=()
dep_libass=(freetype2 fribidi)
dep_lua=()
dep_openal_soft_android=()
dep_mpv=(ffmpeg libass lua openal-soft-android)
dep_mpv_android=(mpv)

getdeps () {
	varname="dep_${1//-/_}[*]"
	echo ${!varname}
}

build () {
	if [ ! -d $1 ]; then
		echo >&2 -e "\033[1;31mTarget $1 not found\033[m"
		return 1
	fi
	echo >&2 -e "\033[1;34mBuilding $1...\033[m"
	if [ $nodeps -eq 0 ]; then
		deps=$(getdeps $1)
		echo >&2 "Dependencies: $deps"
		for dep in $deps; do
			build $dep
		done
	fi
	cd $1
	[ $cleanbuild -eq 1 ] && ../scripts/$1.sh clean
	../scripts/$1.sh build
	cd ..
}

usage () {
	echo "Usage: buildall.sh [--clean] [--no-deps] [target]"
	echo "Builds the specified target (default: $target)"
	echo "--clean      Clean build dirs before compiling"
	echo "--no-deps    Do not build dependencies"
	exit 0
}

for i in "$@"; do
	case $i in
		--clean)
		cleanbuild=1
		;;
		--no-deps)
		nodeps=1
		;;
		-h|--help)
		usage
		;;
		*)
		target=$i
		;;
	esac
done

build $target

[ "$target" == "mpv-android" ] && ls -lh ./mpv-android/app/build/outputs/apk/app-debug.apk
