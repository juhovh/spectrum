include loader.asm

init	call PTxPlay
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

interrupt	call PTxPlay+5
	ei
	ret

org $c000
PTxPlay	incbin PTxPlay
	incbin Nokturn.pt3

end loader
