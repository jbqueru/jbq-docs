#!/bin/sh

# This script sets up a variety of tools that I (JBQ) use for
# retrocomputing development.
# It installs emulators for Atari ST, ZX Spectrum, Amstrad CPC, Oric,
# as well as the assemblers and packaging tools that allow to write
# code for those.

# Controls the parallelism of the various build stages.
PARALLEL=-j4

mkdir -p ~/code/build/tags || exit $?
mkdir -p ~/code/tools || exit $?
mkdir -p ~/code/exec || exit $?
mkdir -p ~/code/projects/520st || exit $?
mkdir -p ~/code/projects/spectrum || exit $?

if [ ! -f ~/code/build/tags/libspectrum ]
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
  echo libspectrum built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/libspectrum || exit $?
fi

if [ ! -f ~/code/build/tags/fuse-gtk ]
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
  echo fuse-gtk built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/fuse-gtk || exit $?
fi

if [ ! -f ~/code/build/tags/fuse-sdl ]
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
  echo fuse-sdl built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/fuse-sdl || exit $?
fi

if [ ! -f ~/code/build/tags/fbzx ]
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
  echo fbzx built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/fbzx || exit $?
fi

if [ ! -f ~/code/build/tags/hatari ]
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
  echo hatari built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/hatari || exit $?
fi

if [ ! -f ~/code/build/tags/caprice32 ]
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
  echo caprice32 built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/caprice32 || exit $?
fi

if [ ! -f ~/code/build/tags/CLK ]
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
  echo CLK built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/CLK || exit $?
fi

if [ ! -f ~/code/build/tags/zesarux ]
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
  echo zesarux built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/zesarux || exit $?
fi

if [ ! -f ~/code/build/tags/oricutron ]
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
  echo oricutron built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/oricutron || exit $?
fi

if [ ! -f ~/code/build/tags/rmac ]
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
  echo rmac built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/rmac || exit $?
fi

if [ ! -f ~/code/build/tags/upx ]
then
  cd ~/code/tools || exit $?
  if [ ! -d upx ]
  then
    git clone ~/code/git/bundle/upx.bundle || exit $?
    cd upx || exit $?
    git config submodule.vendor/doctest.url ~/code/git/bundle/upx-vendor-doctest.bundle || exit $?
    git config submodule.vendor/lzma-sdk.url ~/code/git/bundle/upx-vendor-lzma-sdk.bundle || exit $?
    git config submodule.vendor/ucl.url ~/code/git/bundle/upx-vendor-ucl.bundle || exit $?
    git config submodule.vendor/valgrind.url ~/code/git/bundle/upx-vendor-valgrind.bundle || exit $?
    git config submodule.vendor/zlib.url ~/code/git/bundle/upx-vendor-zlib.bundle || exit $?
    git submodule init || exit $?
  else
    cd upx || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout v4.2.4 || exit $?
  git -c protocol.file.allow=always submodule update || exit $?
  make $PARALLEL || exit $?
  echo upx built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  echo upx built with vendor/doctest at $(git --git-dir=vendor/doctest/.git log -1 --pretty=oneline) >> ~/code/build/log.txt
  echo upx built with vendor/lzma-sdk at $(git --git-dir=vendor/lzma-sdk/.git log -1 --pretty=oneline) >> ~/code/build/log.txt
  echo upx built with vendor/ucl at $(git --git-dir=vendor/ucl/.git log -1 --pretty=oneline) >> ~/code/build/log.txt
  echo upx built with vendor/valgrind at $(git --git-dir=vendor/valgrind/.git log -1 --pretty=oneline) >> ~/code/build/log.txt
  echo upx built with vendor/zlib at $(git --git-dir=vendor/zlib/.git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/upx || exit $?
fi

if [ ! -f ~/code/build/tags/zasm ]
then
  cd ~/code/tools || exit $?
  if [ ! -d zasm ]
  then
    git clone ~/code/git/bundle/zasm.bundle || exit $?
    cd zasm || exit $?
    git config submodule.Libraries.url ~/code/git/bundle/zasm-libraries.bundle
    git submodule init
  else
    cd zasm || exit $?
    git clean -fdx || exit $?
    git fetch || exit $?
  fi
  git checkout 4.4.13 || exit $?
  git -c protocol.file.allow=always submodule update
  make $PARALLEL || exit $?
  echo zasm built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  echo zasm built with Libraries at $(git --git-dir=Libraries/.git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/zasm || exit $?
fi

if [ ! -f ~/code/build/tags/dasm ]
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
  echo dasm built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/dasm || exit $?
fi

if [ ! -f ~/code/build/tags/zmakebas ]
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
  echo zmakebas built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/zmakebas || exit $?
fi

if [ ! -f ~/code/build/tags/bin2tap ]
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
  echo bin2tap built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/bin2tap || exit $?
fi

if [ ! -f ~/code/build/tags/dsk ]
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
  echo dsk built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/dsk || exit $?
fi

if [ ! -f ~/code/build/tags/osdk ]
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
  echo osdk built at $(git log -1 --pretty=oneline) >> ~/code/build/log.txt
  touch ~/code/build/tags/osdk || exit $?
fi
