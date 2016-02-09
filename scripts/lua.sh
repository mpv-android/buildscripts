#!/bin/bash -e

. ../path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -r _build
	make clean
	exit 0
else
	exit 255
fi

mkdir -p _build/out

[ -f flag.patched ] || (patch -p0 --verbose < build.patch; touch flag.patched)

# LUA_T= and LUAC_T= disable building lua & luac
make CC=arm-linux-androideabi-gcc PLAT=linux LUA_T= LUAC_T= -j6

# TO_BIN=/dev/null disables installing lua & luac
make INSTALL_TOP=`pwd`/_build/out TO_BIN=/dev/null install
mkdir -p _build/out/lib/pkgconfig

# make pc only generates a partial pkg-config file because ????
make INSTALL_TOP=`pwd`/_build/out pc >_build/out/lib/pkgconfig/lua.pc
cat >>_build/out/lib/pkgconfig/lua.pc <<'EOF'
Name: Lua
Description: 
Version: ${version}
Libs: -L${libdir} -llua
Cflags: -I${includedir}
EOF
