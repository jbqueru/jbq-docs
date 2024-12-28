#!/bin/sh

# This script sets up a variety of tools that I (JBQ) use for
# retrocomputing development.
# It downloads and copies rom files for some emulators

mkdir -p ~/code/roms/download || exit $?

cd ~/code/roms/download || exit $?
if [ ! -f emutos-192k-1.3.zip ]
then
  curl -L https://sourceforge.net/projects/emutos/files/emutos/1.3/emutos-192k-1.3.zip/download --output emutos-192k-1.3.zip || exit $?
fi
if [ ! -f emutos-256k-1.3.zip ]
then
  curl -L https://sourceforge.net/projects/emutos/files/emutos/1.3/emutos-256k-1.3.zip/download --output emutos-256k-1.3.zip || exit $?
fi
if [ ! -f emutos-512k-1.3.zip ]
then
  curl -L https://sourceforge.net/projects/emutos/files/emutos/1.3/emutos-512k-1.3.zip/download --output emutos-512k-1.3.zip || exit $?
fi
if [ ! -f emutos-1024k-1.3.zip ]
then
  curl -L https://sourceforge.net/projects/emutos/files/emutos/1.3/emutos-1024k-1.3.zip/download --output emutos-1024k-1.3.zip || exit $?
fi

cd ~/code/roms || exit $?
if [ ! -d emutos-192k-1.3 ]
then
  unzip ~/code/roms/download/emutos-192k-1.3.zip || exit $?
fi
if [ ! -d emutos-256k-1.3 ]
then
  unzip ~/code/roms/download/emutos-256k-1.3.zip || exit $?
fi
if [ ! -d emutos-512k-1.3 ]
then
  unzip ~/code/roms/download/emutos-512k-1.3.zip || exit $?
fi
if [ ! -d emutos-1024k-1.3 ]
then
  unzip ~/code/roms/download/emutos-1024k-1.3.zip || exit $?
fi

cd ~/code/exec || exit $?
if [ ! -d spectrum-roms ]
then
  cp -R ~/code/tools/fbzx/data/spectrum-roms . || exit $?
fi
if [ ! -d ZXSpectrum ]
then
  cp -R ~/code/tools/CLK/ROMImages/* . || exit $?
fi
if [ ! -f 48.rom ]
then
  cp -R ~/code/tools/fuse-gtk/roms/* . || exit $?
fi

mkdir -p ~/code/tools/hatari/share/hatari || exit $?
if [ ! -f ~/code/tools/hatari/share/hatari/tos.img ]
then
  cp ~/code/roms/emutos-256k-1.3/etos256us.img ~/code/tools/hatari/share/hatari/tos.img || exit $?
fi
