include loader.asm

init	call PTxPlay
	ret

interrupt	call PTxPlay+5
	ei
	ret

; Loop until space is pressed
main	halt
	ld a,$7f
	in a,($fe)
	rra
	jr c,main
	ret

clean	call PTxPlay+8
	ret

org $c000
PTxPlay	incbin PTxPlay
	incbin cycler.pt3

end loader
