#!/bin/bash

export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

export ARBHOME=`pwd`
export PATH=$ARBHOME/bin:$PATH

export PKG_CONFIG_LIBDIR=$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig
export XLIBS=$(shell pkg-config --libs xpm xerces-c)
export XAW_LIBS=$(shell pkg-config --libs xaw7)
export XML_INCLUDES=$(shell pkg-config --cflags xerces-c)
export XINCLUDES=$(shell pkg-config --cflags x11)

make || true

case `uname` in
    Linux)
	echo DARWIN := 0
	echo LINUX := 1
	echo MACH := LINUX
    ;;
    Darwin)
	echo DARWIN := 1
	echo LINUX := 0
	echo MACH := DARWIN
    ;;
esac >> config.makefile

make build
make tarfile_quick
