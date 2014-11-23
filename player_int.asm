include loader.asm

PTxInit	equ PTxPlayer
PTxPlay	equ PTxPlayer+5
PTxClean	equ PTxPlayer+8

start	call PTxInit
	Load main,PTxPlay
	call PTxClean
	ret

; Loop until space is pressed
main	halt
	ld a,$7f
	in a,($fe)
	rra
	jr c,main
	ret

org $c000
PTxPlayer	incbin PTxPlay
	incbin cycler.pt3

end start
