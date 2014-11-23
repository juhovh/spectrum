	org $8000
	rept 257
	db $81
	endm

LoadDefault	ret

SetCallback	macro label,addr
	push hl
	if not nul addr
	ld hl,addr
	else
	ld hl,LoadDefault
	endif
	ld (label+1),hl
	pop hl
	endm

Load	macro main,int,init,clean
	SetCallback LoadMain,main
	SetCallback LoadInt,int
	SetCallback LoadInit,init
	SetCallback LoadClean,clean
	call Loader
	endm

Loader	di
	push af
	push bc
	push de
	push hl
	push ix

	exx
	ex af,af'

	push af
	push bc
	push de
	push hl
	push iy

LoadInit	call LoadDefault

	ld a,$80
	ld i,a
	im 2
	ei

LoadMain	call LoadDefault

	di
	im 1

LoadClean	call LoadDefault

	pop iy
	pop hl
	pop de
	pop bc
	pop af

	ex af,af'
	exx

	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ei
	ret

	org $817e ; 33150
	jp main

	org $8181
	di
	exx
	ex af,af'
LoadInt	call LoadDefault
	ex af,af'
	exx
	ei
	reti
