org $8000

main	call PTxPlay
loop	halt
	call PTxPlay+5
	ld a,$7f
	in a,($fe)
	rra
	jr c,loop
	call PTxPlay+8
	ret

org $c000

PTxPlay	incbin PTxPlay
	incbin Nokturn.pt3

end main
