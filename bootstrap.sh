#!/bin/env bash

export ABI=64
export CBUILD="x86_64-pc-linux-gnu"
export CFLAGS="-O2 -pipe -march=corei7"
export CHOST="x86_64-pc-linux-gnu"
export CXXFLAGS="-O2 -pipe -march=corei7"
export LDFLAGS="-Wl,-O1 -Wl,--as-needed"
export MAKEOPTS="-j5"

export EPREFIX=${HOME}/gentoo
export PATH="$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:/usr/bin:/bin"

wget http://rsync.prefix.bitzolder.nl/scripts/bootstrap-prefix.sh

chmod 755 bootstrap-prefix.sh

./bootstrap-prefix.sh $EPREFIX stage1 || exit 1
./bootstrap-prefix.sh $EPREFIX stage2 || exit 1
./bootstrap-prefix.sh $EPREFIX stage3 || exit 1

hash -r
emerge -e system || exit 1
cd $EPREFIX/usr/portage/scripts
./bootstrap-prefix.sh $EPREFIX startscript
