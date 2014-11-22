	org $8000
	include utils.asm

logo	incbin logorice.scr
empty	ds $300

main	; switch border to black
	xor a
	out ($fe),a

	; empty color memory
	ld bc,$2ff
	ld hl,$5800
	ld de,$5801
	ld (hl),0
	ldir

	; Load pixel data
	ld bc,$1800
	ld hl,logo
	ld de,$4000
	ldir

	; Update color memory
	ld hl,logo+$1800
	call DissolveScreen

	; Wait for one second
	ld b,50
	halt
	djnz $-1

	; Empty the screen
	ld hl,empty
	call DissolveScreen
	di
	halt

end main
