	.z80
#target ram

#code text, $1000, $100

#code text
	DI
	LD	HL, $c000
	LD	B, 0
draw:
	LD	(HL), B
	INC	HL
	DJNZ	draw
loop:
	JR	loop
