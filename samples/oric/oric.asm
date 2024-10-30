	processor 6502
    org $0500

Start:
    LDX #$00

Loop:
    INX
    STX $BB80
    JMP Loop         ; Loop back
