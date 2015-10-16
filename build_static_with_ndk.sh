#!/bin/bash

# set the base path to your Android NDK (or export NDK to environment)

if [[ "x$NDK_BASE" == "x" ]]; then
    #NDK_BASE=/opt/android-ndk
    echo "No NDK_BASE set, using $NDK_BASE"
fi

NDK_PLATFORM_VERSION=21
NDK_ABI=arm
NDK_COMPILER_VERSION=4.8
NDK_SYSROOT=$NDK_BASE/platforms/android-$NDK_PLATFORM_VERSION/arch-$NDK_ABI
NDK_UNAME=`uname -s | tr '[A-Z]' '[a-z]'` # Convert Linux -> linux
HOST=$NDK_ABI-linux-androideabi
if [ -d $NDK_BASE/toolchains/$HOST-$NDK_COMPILER_VERSION/prebuilt/$NDK_UNAME-x86 ]; then
    NDK_TOOLCHAIN_BASE=$NDK_BASE/toolchains/$HOST-$NDK_COMPILER_VERSION/prebuilt/$NDK_UNAME-x86
else
    NDK_TOOLCHAIN_BASE=$NDK_BASE/toolchains/$HOST-$NDK_COMPILER_VERSION/prebuilt/$NDK_UNAME-x86_64
fi
export CC="$NDK_TOOLCHAIN_BASE/bin/$HOST-gcc --sysroot=$NDK_SYSROOT"
export LD=$NDK_TOOLCHAIN_BASE/bin/$HOST-ld

./configure \
  --enable-static \
  --host=$HOST \
  --without-x \
  --with-driver=devinput \
  --with-port=none \
  --with-irq=none \
  "$@" && \
make LDFLAGS=-all-static ARCH=arm
