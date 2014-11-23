	org $8000
	include utils.asm
byte	db $ff
main	ld b,190
	ld c,190
	ld de,byte
loop	call PutByte
	dec c
	dec b
	jr nz,loop
	di
	halt
	end main
