#!/bin/sh

zmakebas -a 1 -n Spectrum -o loader.tap loader.bas
zasm spectrum.asm -o spectrum.bin
bin2tap spectrum.bin spectrum.tap -a 0x5e00
cat loader.tap spectrum.tap > tape.tap
fuse-gtk -tap tape.tap
