#!/bin/sh

# This script sets up a variety of tools that I (JBQ) use for
# retrocomputing development.
# It installs emulators for Atari ST, ZX Spectrum, Amstrad CPC, Oric,
# as well as the assemblers and packaging tools that allow to write
# code for those.

# Controls the parallelism of the various build stages.
PARALLEL=-j4

mkdir -p ~/code/build || exit $?
mkdir -p ~/code/emulators || exit $?
mkdir -p ~/code/libraries || exit $?
mkdir -p ~/code/roms/download || exit $?
mkdir -p ~/code/tools || exit $?
mkdir -p ~/code/exec || exit $?
mkdir -p ~/code/projects/520st || exit $?
mkdir -p ~/code/projects/spectrum || exit $?

if [ ! -f ~/code/build/packages.fetched ]
then
  echo Fetching apt packages requires root password
  sudo apt install build-essential golang-go \
  git cmake scons autoconf libtool flex bison \
  libsdl1.2-dev libsdl2-dev libpng-dev \
  libfreetype-dev libgtk-3-dev libncurses-dev || exit $?
  touch ~/code/build/packages.fetched || exit $?
fi

if [ ! -f ~/code/build/libspectrum.built ]
then
  cd ~/code/libraries || exit $?
  if [ ! -d libspectrum ]
  then
    git clone https://git.code.sf.net/p/fuse-emulator/libspectrum || exit $?
    cd libspectrum || exit $?
  else
    cd libspectrum || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout libspectrum-1.5.0 || exit $?
  ./autogen.sh || exit $?
  ./configure --prefix ~/code/install || exit $?
  make $PARALLEL || exit $?
  make install || exit $?
  touch ~/code/build/libspectrum.built || exit $?
fi

if [ ! -f ~/code/build/fuse-gtk.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d fuse-gtk ]
  then
    git clone https://git.code.sf.net/p/fuse-emulator/fuse fuse-gtk || exit $?
    cd fuse-gtk || exit $?
  else
    cd fuse-gtk || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout fuse-1.6.0 || exit $?
  ./autogen.sh || exit $?
  PKG_CONFIG_PATH=~/code/install/lib/pkgconfig ./configure --with-gtk || exit $?
  make $PARALLEL || exit $?
  mv fuse fuse-gtk || exit $?
  touch ~/code/build/fuse-gtk.built || exit $?
fi

if [ ! -f ~/code/build/fuse-sdl.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d fuse-sdl ]
  then
    git clone https://git.code.sf.net/p/fuse-emulator/fuse fuse-sdl || exit $?
    cd fuse-sdl || exit $?
  else
    cd fuse-sdl || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout fuse-1.6.0 || exit $?
  ./autogen.sh || exit $?
  PKG_CONFIG_PATH=~/code/install/lib/pkgconfig ./configure --with-sdl || exit $?
  make $PARALLEL || exit $?
  mv fuse fuse-sdl|| exit $?
  touch ~/code/build/fuse-sdl.built || exit $?
fi

if [ ! -f ~/code/build/fbzx.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d fbzx ]
  then
    git clone https://gitlab.com/rastersoft/fbzx.git || exit $?
    cd fbzx || exit $?
  else
    cd fbzx || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 4.8.0 || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/fbzx.built || exit $?
fi

if [ ! -f ~/code/build/hatari.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d hatari ]
  then
    git clone https://git.tuxfamily.org/hatari/hatari.git/ || exit $?
    cd hatari || exit $?
  else
    cd hatari || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout v2.5.0 || exit $?
  ./configure || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/hatari.built || exit $?
fi

if [ ! -f ~/code/build/caprice32.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d caprice32 ]
  then
    git clone https://github.com/ColinPitrat/caprice32.git || exit $?
    cd caprice32 || exit $?
  else
    cd caprice32 || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 48e215e06060c4e83a9df7b74af83aff1ec73077 || exit $?
  make APP_PATH=$PWD -j4 || exit $?
  touch ~/code/build/caprice32.built || exit $?
fi

if [ ! -f ~/code/build/CLK.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d CLK ]
  then
    git clone https://github.com/TomHarte/CLK.git || exit $?
    cd CLK || exit $?
  else
    cd CLK || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 2024-10-19 || exit $?
  cd OSBindings/SDL || exit $?
  scons $PARALLEL || exit $?
  touch ~/code/build/CLK.built || exit $?
fi

if [ ! -f ~/code/build/zesarux.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d zesarux ]
  then
    git clone https://github.com/chernandezba/zesarux.git || exit $?
    cd zesarux || exit $?
  else
    cd zesarux || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout ZEsarUX-11.0 || exit $?
  cd src || exit $?
  CFLAGS=-O3 ./configure || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/zesarux.built || exit $?
fi

if [ ! -f ~/code/build/oricutron.built ]
then
  cd ~/code/emulators || exit $?
  if [ ! -d oricutron ]
  then
    git clone https://github.com/pete-gordon/oricutron.git || exit $?
    cd oricutron || exit $?
  else
    cd oricutron || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout V1_2_5 || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/oricutron.built || exit $?
fi

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
  cp -R ~/code/emulators/fbzx/data/spectrum-roms . || exit $?
fi
if [ ! -d ZXSpectrum ]
then
  cp -R ~/code/emulators/CLK/ROMImages/* . || exit $?
fi
if [ ! -f 48.rom ]
then
  cp -R ~/code/emulators/fuse-gtk/roms/* . || exit $?
fi

mkdir -p ~/code/emulators/hatari/share/hatari || exit $?
if [ ! -f ~/code/emulators/hatari/share/hatari/tos.img ]
then
  cp ~/code/roms/emutos-192k-1.3/etos192us.img ~/code/emulators/hatari/share/hatari/tos.img || exit $?
fi

if [ ! -f ~/code/build/rmac.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d rmac ]
  then
    git clone http://tiddly.mooo.com:5000/rmac/rmac.git || exit $?
    cd rmac || exit $?
  else
    cd rmac || exit $?
    git clean -fdx || exit $?
    git fetch
  fi
  git checkout v2.2.24 || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/rmac.built || exit $?
fi

if [ ! -f ~/code/build/upx.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d upx ]
  then
    git clone --recurse-submodules https://github.com/upx/upx.git || exit $?
    cd upx || exit $?
  else
    cd upx || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout v4.2.4 || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/upx.built || exit $?
fi

if [ ! -f ~/code/build/zasm.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d zasm ]
  then
    git clone --recurse-submodules https://github.com/Megatokio/zasm.git || exit $?
    cd zasm || exit $?
  else
    cd zasm || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 4.4.13 || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/zasm.built || exit $?
fi

if [ ! -f ~/code/build/dasm.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d dasm ]
  then
    git clone https://github.com/dasm-assembler/dasm.git || exit $?
    cd dasm || exit $?
  else
    cd dasm || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 2.20.14.1 || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/dasm.built || exit $?
fi

if [ ! -f ~/code/build/zmakebas.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d zmakebas ]
  then
    git clone https://github.com/chris-y/zmakebas.git || exit $?
    cd zmakebas || exit $?
  else
    cd zmakebas || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout v1.8.5 || exit $?
  make $PARALLEL zmakebas || exit $?
  touch ~/code/build/zmakebas.built || exit $?
fi

if [ ! -f ~/code/build/bin2tap.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d bin2tap ]
  then
    git clone https://github.com/retro-speccy/bin2tap.git || exit $?
    cd bin2tap || exit $?
  else
    cd bin2tap || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout b74421d43f112d39c726d2299083f56c3022f093
  go mod init bin2tap || exit $?
  go mod tidy || exit $?
  go build . || exit $?
  touch ~/code/build/bin2tap.built || exit $?
fi

if [ ! -f ~/code/build/dsk.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d dsk ]
  then
    git clone https://github.com/jeromelesaux/dsk.git || exit $?
    cd dsk || exit $?
  else
    cd dsk || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout v0.24 || exit $?
  make $PARALLEL || exit $?
  cp binaries/dsk-linux-amd64 binaries/dsk || exit $?
  touch ~/code/build/dsk.built || exit $?
fi

if [ ! -f ~/code/build/osdk.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d osdk ]
  then
    git clone https://github.com/Oric-Software-Development-Kit/osdk.git || exit $?
    cd osdk || exit $?
  else
    cd osdk || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 4eba1414632f53d5448fcb96333fef1689dd3d83 || exit $?
  cd osdk/main/common || exit $?
  make $PARALLEL || exit $?
  cd ../header || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/osdk.built || exit $?
fi
