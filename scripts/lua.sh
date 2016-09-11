#!/bin/bash -e

. ../../path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	make clean
	exit 0
else
	exit 255
fi

# FIXME: multiarch doesn't work correctly yet (built in src dir)

# LUA_T= and LUAC_T= disable building lua & luac
# -Dgetlocaledecpoint()=('.') fixes bionic missing decimal_point in localeconv
make CC="$ndk_triple-gcc -Dgetlocaledecpoint\(\)=\(\'.\'\)" \
	AR="$ndk_triple-ar r" \
	RANLIB="$ndk_triple-ranlib" \
	PLAT=linux LUA_T= LUAC_T= -j6

INSTALL=install
[ "$os" == "macosx" ] && INSTALL=ginstall

# TO_BIN=/dev/null disables installing lua & luac
make INSTALL="$INSTALL" INSTALL_TOP=`pwd`/../../prefix$dir_suffix TO_BIN=/dev/null install

# make pc only generates a partial pkg-config file because ????
mkdir -p ../../prefix$dir_suffix/lib/pkgconfig
make INSTALL_TOP=`pwd`/../../prefix pc > ../../prefix$dir_suffix/lib/pkgconfig/lua.pc
cat >>../../prefix$dir_suffix/lib/pkgconfig/lua.pc <<'EOF'
Name: Lua
Description:
Version: ${version}
Libs: -L${libdir} -llua
Cflags: -I${includedir}
EOF
