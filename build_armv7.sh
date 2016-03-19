#!/bin/env bash

export EPREFIX=${HOME}/gentoo-armv7
armv7a-hardfloat-linux-gnueabi-emerge sys-kernel/linux-headers sys-libs/glibc

CTARGET=armv7a-hardfloat-linux-gnueabi ./rt-sysroot
armv7a-hardfloat-linux-gnueabi-emerge sys-devel/gcc sys-devel/binutils

wget http://dev.gentoo.org/~heroxbd/bootstrap-rap.sh
$chmod 755 bootstrap-rap.sh
$./bootstrap-rap.sh
