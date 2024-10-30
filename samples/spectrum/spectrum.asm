  .z80

  org $5e00

  DI
  LD HL, $4000
  LD B, L
Loop:
  LD (HL), B
  INC HL
  DJNZ Loop
Forever:
  JR Forever
