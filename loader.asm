
; pointers to system ROM routines
ROM_CLS	equ $0d6b
ROM_CHAN_OPEN	equ $1601

; interrupt jump table to $8181
	org $8000
	rept 257
	db $81
	endm

; main loader routine
loader	call ROM_CLS
	ld a,2
	call ROM_CHAN_OPEN

	ld b,11
ldr_nl_loop	ld a,13
	rst 16
	djnz ldr_nl_loop

	ld hl,ldr_str
ldr_str_loop	ld a,(hl)
	cp 0
	jr z,ldr_kb_loop
	rst 16
	inc hl
	jr ldr_str_loop

ldr_kb_loop	halt
	xor a
	in a,($fe)
	cpl
	and 15
	jr z,ldr_kb_loop

	di
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

	call init

	ld a,$80
	ld i,a
	im 2
	ei

	call main

	di
	im 1

	call clean

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

ldr_str	db '     PRESS ANY KEY TO START     ',0

; our custom interrupt handler
	org $8181
	jp interrupt
