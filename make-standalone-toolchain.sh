#!/usr/bin/bash

ANDROID_LEVL=$1
ARCH=$2
ARCH_ARM=arch-arm
ARCH_X86=arch-x86
DIR_VNC_SERVER=$HOME/android-vnc-server

if [ "$ARCH" = "$ARCH_ARM" ]; then
	TOOLCHAIN=arm-linux-androideabi-4.9	
elif [ "$ARCH" = "$ARCH_X86" ]; then
	TOOLCHAIN=x86_64-4.9	
else
	echo "$ARCH does not supported"
	return
fi

echo "ANDROID LEVEL: $ANDROID_LEVL"
echo "ARCHITECTURE: $ARCH"
echo "TOOLCHAIN: $TOOLCHAIN"

#Selecting SYSTEM ROOT
SYSROOT=$NDK/platforms/$ANDROID_LEVL/$ARCH
echo SYSROOT: $SYSROOT

#Invoking the compiler
echo "Compiler settings"

INSTALL_DIR=$HOME/toolchain_$ANDROID_LEVL\_$ARCH

echo toolchain will be installed in $INSTALL_DIR
$NDK/build/tools/make-standalone-toolchain.sh --platform=$ANDROID_LEVL --install-dir=$INSTALL_DIR --toolchain=$TOOLCHAIN

export PATH=$INSTALL_DIR/bin:$PATH
if [ "$ARCH" = "$ARCH_ARM" ]; then
	export CC=arm-linux-androideabi-gcc
	export CXX=arm-linux-androideabi-g++
elif [ "$ARCH" = "$ARCH_X86" ]; then
	export CC=arm-linux-androideabi-gcc
	export CXX=arm-linux-androideabi-g++
else
	echo "Cannot export CC and CSS.."
	return
fi

echo "accessing VNCServer Projects..."
cd $DIR_VNC_SERVER
ndk-build
