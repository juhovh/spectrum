org $8000	
include utils.asm

ourcolour	equ PAPER_BLACK+INK_BLUE+COLOUR_BRIGHT

main:
	;; Clear everything on the screen
	call ClearScreen

	;; Set border colour to black
	ld a,INK_BLACK
	out ($fe),a

	;; We want to write 768 bytes to $5800
	ld hl,$5800
	ld bc,768
loop:
	;; Load the colour we want
	ld (hl),ourcolour
	;; Increase hl and decrease bc
	inc hl
	dec bc
	;; Check if bc is completely 0
	ld a,b
	or c
	;; Continue loop if not 0
	jr nz,loop

	;; Set some pixels to check that our blue colour works
	ld b,0
	ld c,0
	call SetPixel
	inc b
	inc c
	call SetPixel
	di
	halt

end main
