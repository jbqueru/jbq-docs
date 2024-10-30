#!/bin/sh

zasm cpc.asm -o CPC.BIN
dsk -dsk floppy.dsk -format
dsk -dsk floppy.dsk -put -amsdosfile CPC.BIN -force -type binary -exec \#1000 -load \#1000
cap32 floppy.dsk -a 'run "CPC.BIN"'