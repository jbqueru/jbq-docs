#!/bin/sh

# This script sets up a variety of tools that I (JBQ) use for
# retrocomputing development.
# It installs emulators for Atari ST, ZX Spectrum, Amstrad CPC, Oric,
# as well as the assemblers and packaging tools that allow to write
# code for those.

# Controls the parallelism of the various build stages.
PARALLEL=-j4

mkdir -p ~/code/build || exit $?
mkdir -p ~/code/roms/download || exit $?
mkdir -p ~/code/tools || exit $?
mkdir -p ~/code/exec || exit $?
mkdir -p ~/code/projects/520st || exit $?
mkdir -p ~/code/projects/spectrum || exit $?

if [ ! -f ~/code/build/libspectrum.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d libspectrum ]
  then
    git clone ~/code/git/bundle/libspectrum.bundle || exit $?
    cd libspectrum || exit $?
  else
    cd libspectrum || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout libspectrum-1.5.0 || exit $?
  ./autogen.sh || exit $?
  ./configure --prefix ~/code/tools/install || exit $?
  make $PARALLEL || exit $?
  make install || exit $?
  touch ~/code/build/libspectrum.built || exit $?
fi

if [ ! -f ~/code/build/fuse-gtk.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d fuse-gtk ]
  then
    git clone ~/code/git/bundle/fuse.bundle fuse-gtk || exit $?
    cd fuse-gtk || exit $?
  else
    cd fuse-gtk || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout fuse-1.6.0 || exit $?
  ./autogen.sh || exit $?
  PKG_CONFIG_PATH=~/code/tools/install/lib/pkgconfig ./configure --with-gtk || exit $?
  make $PARALLEL || exit $?
  mv fuse fuse-gtk || exit $?
  touch ~/code/build/fuse-gtk.built || exit $?
fi

if [ ! -f ~/code/build/fuse-sdl.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d fuse-sdl ]
  then
    git clone ~/code/git/bundle/fuse.bundle fuse-sdl || exit $?
    cd fuse-sdl || exit $?
  else
    cd fuse-sdl || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout fuse-1.6.0 || exit $?
  ./autogen.sh || exit $?
  PKG_CONFIG_PATH=~/code/tools/install/lib/pkgconfig ./configure --with-sdl || exit $?
  make $PARALLEL || exit $?
  mv fuse fuse-sdl|| exit $?
  touch ~/code/build/fuse-sdl.built || exit $?
fi

if [ ! -f ~/code/build/fbzx.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d fbzx ]
  then
    git clone ~/code/git/bundle/fbzx.bundle || exit $?
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
  cd ~/code/tools || exit $?
  if [ ! -d hatari ]
  then
    git clone ~/code/git/bundle/hatari.bundle || exit $?
    cd hatari || exit $?
  else
    cd hatari || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 18b9a293821311e091be163b492eec7e4323cc72 || exit $?
  ./configure || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/hatari.built || exit $?
fi

if [ ! -f ~/code/build/caprice32.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d caprice32 ]
  then
    git clone ~/code/git/bundle/caprice32.bundle || exit $?
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
  cd ~/code/tools || exit $?
  if [ ! -d CLK ]
  then
    git clone ~/code/git/bundle/CLK.bundle || exit $?
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
  cd ~/code/tools || exit $?
  if [ ! -d zesarux ]
  then
    git clone ~/code/git/bundle/zesarux.bundle || exit $?
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
  cd ~/code/tools || exit $?
  if [ ! -d oricutron ]
  then
    git clone ~/code/git/bundle/oricutron.bundle || exit $?
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
    git clone ~/code/git/bundle/rmac.bundle || exit $?
    cd rmac || exit $?
  else
    cd rmac || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
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
  git checkout 4.4.15 || exit $?
  make $PARALLEL || exit $?
  touch ~/code/build/zasm.built || exit $?
fi

if [ ! -f ~/code/build/dasm.built ]
then
  cd ~/code/tools || exit $?
  if [ ! -d dasm ]
  then
    git clone ~/code/git/bundle/dasm.bundle || exit $?
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
    git clone ~/code/git/bundle/zmakebas.bundle || exit $?
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
    git clone ~/code/git/bundle/bin2tap.bundle || exit $?
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
    git clone ~/code/git/bundle/dsk.bundle || exit $?
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
    git clone ~/code/git/bundle/osdk.bundle || exit $?
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
