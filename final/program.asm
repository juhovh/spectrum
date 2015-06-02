include ../loader.asm
include ../utils.asm

PTxStart        equ PTxPlayer
PTxInit equ PTxPlayer+3
PTxPlay equ PTxPlayer+5
PTxClean        equ PTxPlayer+8

main	xor a
	out ($fe),a
	xor a

        ; gravity bling
	ld hl,song3
        call PTxInit
        Load intr
        call PTxClean

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
        ld hl,song1
        call PTxInit
        Load intr
        call PTxClean

        ; FTRC
        Load ftrc_c,intr

	ret

intr    push af
        push bc
        push de
        push hl
        push ix
        call PTxPlay
        pop ix
        pop hl
        pop de
        pop bc
        pop af
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
song4	incbin ../kankankan.pt3

org $c000
PTxPlayer	incbin ../PTxPlay

org 53248 
ftrc_c	incbin ../ftrc.bin

end
