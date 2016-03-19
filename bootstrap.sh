#!/bin/env bash


export EPREFIX=${HOME}/gentoo
export PATH="$EPREFIX/usr/bin:$EPREFIX/bin:$EPREFIX/tmp/usr/bin:$EPREFIX/tmp/bin:/usr/bin:/bin"

wget http://rsync.prefix.bitzolder.nl/scripts/bootstrap-prefix.sh

chmod 755 bootstrap-prefix.sh
./bootstrap-prefix.sh $EPREFIX stage1
./bootstrap-prefix.sh $EPREFIX stage2
./bootstrap-prefix.sh $EPREFIX stage3

hash -r
emerge -e system
cd $EPREFIX/usr/portage/scripts
./bootstrap-prefix.sh $EPREFIX startscript
