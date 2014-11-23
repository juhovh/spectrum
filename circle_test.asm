	org $8000

coords	incbin cdata.dat

putchar	push af
	push bc
	push de
	push hl
	push af
	ld hl,coords
	ld a,b
	and %01111111
	ld l,a
	xor a
	rl l
	adc a,h
	ld h,a
	ld c,(hl)
	inc hl
	ld b,(hl)
	pop af
	call PutChar2
	pop hl
	pop de
	pop bc
	pop af
	ret

main	call ClearScreen
	ld b,0
loop	ld a,'A'
	call putchar
	halt
	call putchar
	inc b
	jr loop

	include utils.asm
	end main
