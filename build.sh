#!/bin/sh

cd internal

$ANDROID_CXX -O3 -c libintl.cpp -o libintl.o
$ANDROID_AR rs ../libintl.a libintl.o

cd ..

INSTALL_PREFIX=$ANDROID_TOOLCHAIN_ROOT/sysroot/usr/

cp libintl.a $INSTALL_PREFIX/lib
cp libintl.h $INSTALL_PREFIX/include
