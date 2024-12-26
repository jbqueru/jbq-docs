#!/bin/sh

# This script sets up a variety of tools that I (JBQ) use for
# retrocomputing development.
# It installs emulators for Atari ST, ZX Spectrum, Amstrad CPC, Oric,
# as well as the assemblers and packaging tools that allow to write
# code for those.

echo '(*) preparing directories'
mkdir -p ~/code/git/mirror || exit $?
rm -rf ~/code/git/bundle || exit $?
mkdir -p ~/code/git/bundle || exit $?

cd ~/code/git/mirror || exit $?

if [ ! -d libspectrum.git ]
then
  echo '(*) cloning libspectrum'
  git clone --bare https://git.code.sf.net/p/fuse-emulator/libspectrum || exit $?
else
  echo '(*) updating libspectrum'
  git --git-dir=libspectrum.git fetch || exit $?
fi
echo '(*) creating libspectrum bundle'
git --git-dir=libspectrum.git bundle create ../bundle/libspectrum.bundle --branches --tags HEAD || exit $?

if [ ! -d fuse.git ]
then
  echo '(*) cloning fuse'
  git clone --bare https://git.code.sf.net/p/fuse-emulator/fuse || exit $?
else
  echo '(*) updating fuse'
  git --git-dir=fuse.git fetch || exit $?
fi
echo '(*) creating fuse bundle'
git --git-dir=fuse.git bundle create ../bundle/fuse.bundle --branches --tags HEAD || exit $?

if [ ! -d fbzx.git ]
then
  echo '(*) cloning fbzx'
  git clone --bare https://gitlab.com/rastersoft/fbzx.git || exit $?
else
  echo '(*) updating fbzx'
  git --git-dir=fbzx.git fetch || exit $?
fi
echo '(*) creating fbzx bundle'
git --git-dir=fbzx.git bundle create ../bundle/fbzx.bundle --branches --tags HEAD || exit $?

if [ ! -d hatari.git ]
then
  echo '(*) cloning hatari'
  git clone --bare https://git.tuxfamily.org/hatari/hatari.git/ || exit $?
else
  echo '(*) updating hatari'
  git --git-dir=hatari.git fetch || exit $?
fi
echo '(*) creating hatari bundle'
git --git-dir=hatari.git bundle create ../bundle/hatari.bundle --branches --tags HEAD || exit $?

if [ ! -d caprice32.git ]
then
  echo '(*) cloning caprice32'
  git clone --bare https://github.com/ColinPitrat/caprice32.git || exit $?
else
  echo '(*) updating caprice32'
  git --git-dir=caprice32.git fetch || exit $?
fi
echo '(*) creating caprice32 bundle'
git --git-dir=caprice32.git bundle create ../bundle/caprice32.bundle --branches --tags HEAD || exit $?

if [ ! -d CLK.git ]
then
  echo '(*) cloning CLK'
  git clone --bare https://github.com/TomHarte/CLK.git || exit $?
else
  echo '(*) updating CLK'
  git --git-dir=CLK.git fetch || exit $?
fi
echo '(*) creating CLK bundle'
git --git-dir=CLK.git bundle create ../bundle/CLK.bundle --branches --tags HEAD || exit $?

if [ ! -d zesarux.git ]
then
  echo '(*) cloning zesarux'
  git clone --bare https://github.com/chernandezba/zesarux.git || exit $?
else
  echo '(*) updating zesarux'
  git --git-dir=zesarux.git fetch || exit $?
fi
echo '(*) creating zesarux bundle'
git --git-dir=zesarux.git bundle create ../bundle/zesarux.bundle --branches --tags HEAD || exit $?

if [ ! -d oricutron.git ]
then
  echo '(*) cloning oricutron'
  git clone --bare https://github.com/pete-gordon/oricutron.git || exit $?
else
  echo '(*) updating oricutron'
  git --git-dir=oricutron.git fetch || exit $?
fi
echo '(*) creating oricutron bundle'
git --git-dir=oricutron.git bundle create ../bundle/oricutron.bundle --branches --tags HEAD || exit $?

if [ ! -d rmac.git ]
then
  echo '(*) cloning rmac'
  git clone --bare http://tiddly.mooo.com:5000/rmac/rmac.git || exit $?
else
  echo '(*) updating rmac'
  git --git-dir=rmac.git fetch || exit $?
fi
echo '(*) creating rmac bundle'
git --git-dir=rmac.git bundle create ../bundle/rmac.bundle --branches --tags HEAD || exit $?

if [ ! -d upx.git ]
then
  echo '(*) cloning upx'
  git clone --bare https://github.com/upx/upx.git || exit $?
else
  echo '(*) updating upx'
  git --git-dir=upx.git fetch || exit $?
fi
echo '(*) creating upx bundle'
git --git-dir=upx.git bundle create ../bundle/upx.bundle --branches --tags HEAD || exit $?

if [ ! -d upx-vendor-doctest.git ]
then
  echo '(*) cloning upx vendor doctest'
  git clone --bare https://github.com/upx/upx-vendor-doctest.git || exit $?
else
  echo '(*) updating upx vendor doctest'
  git --git-dir=upx-vendor-doctest.git fetch || exit $?
fi
echo '(*) creating upx vendor doctest bundle'
git --git-dir=upx-vendor-doctest.git bundle create ../bundle/upx-vendor-doctest.bundle --branches --tags HEAD || exit $?

if [ ! -d upx-vendor-lzma-sdk.git ]
then
  echo '(*) cloning upx vendor lzma sdk'
  git clone --bare https://github.com/upx/upx-vendor-lzma-sdk.git || exit $?
else
  echo '(*) updating upx vendor lzma sdk'
  git --git-dir=upx-vendor-lzma-sdk.git fetch || exit $?
fi
echo '(*) creating upx vendor lzma sdk bundle'
git --git-dir=upx-vendor-lzma-sdk.git bundle create ../bundle/upx-vendor-lzma-sdk.bundle --branches --tags HEAD || exit $?

if [ ! -d upx-vendor-ucl.git ]
then
  echo '(*) cloning upx vendor ucl'
  git clone --bare https://github.com/upx/upx-vendor-ucl.git || exit $?
else
  echo '(*) updating upx vendor ucl'
  git --git-dir=upx-vendor-ucl.git fetch || exit $?
fi
echo '(*) creating upx vendor ucl bundle'
git --git-dir=upx-vendor-ucl.git bundle create ../bundle/upx-vendor-ucl.bundle --branches --tags HEAD || exit $?

if [ ! -d upx-vendor-valgrind.git ]
then
  echo '(*) cloning upx vendor valgrind'
  git clone --bare https://github.com/upx/upx-vendor-valgrind.git || exit $?
else
  echo '(*) updating upx vendor valgrind'
  git --git-dir=upx-vendor-valgrind.git fetch || exit $?
fi
echo '(*) creating upx vendor valgrind bundle'
git --git-dir=upx-vendor-valgrind.git bundle create ../bundle/upx-vendor-valgrind.bundle --branches --tags HEAD || exit $?

if [ ! -d upx-vendor-zlib.git ]
then
  echo '(*) cloning upx vendor zlib'
  git clone --bare https://github.com/upx/upx-vendor-zlib.git || exit $?
else
  echo '(*) updating upx vendor zlib'
  git --git-dir=upx-vendor-zlib.git fetch || exit $?
fi
echo '(*) creating upx vendor zlib bundle'
git --git-dir=upx-vendor-zlib.git bundle create ../bundle/upx-vendor-zlib.bundle --branches --tags HEAD || exit $?

if [ ! -d zasm.git ]
then
  echo '(*) cloning zasm'
  git clone --bare https://github.com/Megatokio/zasm.git || exit $?
else
  echo '(*) updating zasm'
  git --git-dir=zasm.git fetch || exit $?
fi
echo '(*) creating zasm bundle'
git --git-dir=zasm.git bundle create ../bundle/zasm.bundle --branches --tags HEAD || exit $?

if [ ! -d zasm.Libraries.git ]
then
  echo '(*) cloning zasm libraries'
  git clone --bare https://github.com/Megatokio/Libraries.git zasm-libraries.git|| exit $?
else
  echo '(*) updating zasm libraries'
  git --git-dir=zasm-libraries.git fetch || exit $?
fi
echo '(*) creating zasm libraries bundle'
git --git-dir=zasm-libraries.git bundle create ../bundle/zasm-libraries.bundle --branches --tags HEAD || exit $?

if [ ! -d dasm.git ]
then
  echo '(*) cloning dasm'
  git clone --bare https://github.com/dasm-assembler/dasm.git || exit $?
else
  echo '(*) updating dasm'
  git --git-dir=dasm.git fetch || exit $?
fi
echo '(*) creating dasm bundle'
git --git-dir=dasm.git bundle create ../bundle/dasm.bundle --branches --tags HEAD || exit $?

if [ ! -d zmakebas.git ]
then
  echo '(*) cloning zmakebas'
  git clone --bare https://github.com/chris-y/zmakebas.git || exit $?
else
  echo '(*) updating zmakebas'
  git --git-dir=zmakebas.git fetch || exit $?
fi
echo '(*) creating zmakebas bundle'
git --git-dir=zmakebas.git bundle create ../bundle/zmakebas.bundle --branches --tags HEAD || exit $?

if [ ! -d bin2tap.git ]
then
  echo '(*) cloning bin2tap'
  git clone --bare https://github.com/retro-speccy/bin2tap.git || exit $?
else
  echo '(*) updating bin2tap'
  git --git-dir=bin2tap.git fetch || exit $?
fi
echo '(*) creating bin2tap bundle'
git --git-dir=bin2tap.git bundle create ../bundle/bin2tap.bundle --branches --tags HEAD || exit $?

if [ ! -d dsk.git ]
then
  echo '(*) cloning dsk'
  git clone --bare https://github.com/jeromelesaux/dsk.git || exit $?
else
  echo '(*) updating dsk'
  git --git-dir=dsk.git fetch || exit $?
fi
echo '(*) creating dskbundle'
git --git-dir=dsk.git bundle create ../bundle/dsk.bundle --branches --tags HEAD || exit $?

if [ ! -d osdk.git ]
then
  echo '(*) cloning osdk'
  git clone --bare https://github.com/Oric-Software-Development-Kit/osdk.git || exit $?
else
  echo '(*) updating osdk'
  git --git-dir=osdk.git fetch || exit $?
fi
echo '(*) creating osdk'
git --git-dir=osdk.git bundle create ../bundle/osdk.bundle --branches --tags HEAD || exit $?

echo '(*) preparing mirror archive'
cd ~/code/git || exit $?
cp -R bundle archive.`date -u +%Y%m%d-%H%M%S` || exit $?

exit 0
