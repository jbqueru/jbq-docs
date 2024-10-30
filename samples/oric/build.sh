#!/bin/sh

dasm oric.asm -f3 -ooric.bin
header oric.bin oric.tap 0x500
oricutron -t oric.tap
