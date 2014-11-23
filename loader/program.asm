include ../loader.asm
include ../utils.asm

main	xor a
	out ($fe),a
	xor a
	ld hl,song1
	call $c003
	Load growing,$c005
	jr $
	call $c008
	ret

growing	nop
	include ../growing.asm
	ret

song1	incbin ../cycler.pt3

	org $c000
	incbin ../PTxPlay

end
