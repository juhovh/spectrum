include ../loader.asm
include ../utils.asm

PTxStart        equ PTxPlayer
PTxInit equ PTxPlayer+3
PTxPlay equ PTxPlayer+5
PTxClean        equ PTxPlayer+8

SaveScreen:
	ld de,$e000
	ld hl,$4000
	ld bc,6912
	ldir
	ret

RestoreScreen:
	ld de,$4000
	ld hl,$e000
	ld bc,6912
	ldir
	ret

main	xor a
	out ($fe),a
	xor a

	; Save our loading screen to $e000
	call SaveScreen

        ; gravity bling
	ld hl,song3
        call PTxInit

        ; logo + flower
	Load growing,intr
        
        ; scroll the logo up
        Load ScrollScreenUp,intr

        call ClearScreen

	; robots!
        Load dissolv,intr

        call ClearScreen

        ; the bouncing ball
        Load bball,intr

        xor a 
        ld hl,song4
        call PTxInit
        Load waitfortanka,intr

        call ClearScreen

        xor a 
        ld hl,song1
        call PTxInit

        ld hl,$5800
        ld de,$5801
        ld (hl),$04
        ld bc,$2FF
        ldir

        ; FTRC
        Load ftrc_c,intr

        call ClearScreen
        xor a 
        ld hl,song2
        call PTxInit

        Load ScrollCredits,intr

        call PTxClean

	call RestoreScreen
	jp main

intr    push af
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

        call PTxPlay

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
        ret

waitfortanka nop
        ld de,760
tankaloop halt
        dec de
        ld a,d
        or e
        cp 0
        jr nz,tankaloop
        ret

growing	nop
	include ../growing.asm
	ret

bball nop
	include ../bouncingball.asm
        ret

scroller nop
	include ../scroll.asm
        ret

dissolv nop
	include ../dissolve.asm
        ret

robos	incbin ../roboto.scr
song1	incbin ../cycler.pt3
song2   incbin ../bussipysakilla-slow.pt3
song3	incbin ../gravity_bling.pt3

org $c000
PTxPlayer	incbin ../PTxPlay

;; There was no space before the player and it cannot
;; be relocated without recompiling it with another assembler
song4	incbin ../kankankan.pt3

org 53248
ftrc_c	incbin ftrc.bin

end
