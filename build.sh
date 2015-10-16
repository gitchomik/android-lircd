#!/bin/bash

export CC="arm-linux-gnueabihf-gcc"
export LD="arm-linux-gnueabihf-ld"

./configure \
  --host=arm-linux-gnueabihf \
  --without-x \
  --with-driver=devinput \
  --with-port=none \
  --with-irq=none \
  "$@" && \

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
