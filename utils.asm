;; These are the colour values available on ZX Spectrum, if you for example want
;; to have green ink on red paper you can just use (INK_GREEN+PAPER_RED) as the
;; value and store it to the corresponding screen memory address. (which you can
;; get by calling FindColor routine later on)
BLACK	equ %00000000
BLUE	equ %00000001
RED	equ %00000010
MAGENTA	equ %00000011
GREEN	equ %00000100
CYAN	equ %00000101
YELLOW	equ %00000110
WHITE	equ %00000111
INK_BLACK	equ %00000000
INK_BLUE	equ %00000001
INK_RED	equ %00000010
INK_MAGENTA	equ %00000011
INK_GREEN	equ %00000100
INK_CYAN	equ %00000101
INK_YELLOW	equ %00000110
INK_WHITE	equ %00000111
PAPER_BLACK	equ %00000000
PAPER_BLUE	equ %00001000
PAPER_RED	equ %00010000
PAPER_MAGENTA	equ %00011000
PAPER_GREEN	equ %00100000
PAPER_CYAN	equ %00101000
PAPER_YELLOW	equ %00110000
PAPER_WHITE	equ %00111000
BRIGHT	equ %01000000
FLASH	equ %10000000

;; This is a modifyable PixelAddress pointer, it must be a multiply of 256
;; for performance and contain 6144 bytes of free memory. The default value is
;; $4000 but for shadow screen one might want to set it to $c000 instead, other
;; values are probably not very useful.
PixelAddress	dw $4000

;; This is a modifyable ColorAddress pointer, it must be a multiple of 256 for
;; performance and contain 768 bytes of free memory. The default value is $4000
;; but for shadow screen one might want to set it to $d800 instead, other values
;; are useful for different kind of backbuffers.
ColorAddress	dw $5800

;; This is a modifyable CharAddress pointer, it can be anything but must point
;; to a memory address with 1024 bytes of 8x8 character data. The first 256
;; bytes are invisible and never used, it can also point to 2048 bytes of
;; character data for example to add full latin1 character support.
CharAddress	dw $3c00

;; This is a modifyable RandomSeed variable, it contains a 12-bit value where
;; upper 4 bits define the used 256-byte sequence and lower 8 bits define the
;; current position in the sequence.
RandomSeed	dw $0000

	org (($+8) & $FFF8) ; Aligned to closest 8 bytes
BitMasks	db $80,$40,$20,$10,$08,$04,$02,$01
ByteMasks	db $ff,$7f,$3f,$1f,$0f,$07,$03,$01

;; ClearScreen routine using SP for faster memory access.
;; input:
;;   PixelAddress - the used pixel start address
;; destroys:
;;   hl, de, b, flags
ClearScreen	ld hl,(PixelAddress)
	ld de,$1800
	add hl,de
	ld (CS_End+1),sp
	ld sp,hl
	ld de,$0000
	ld b,0
CS_Loop	rept 12
	push de
	endm
	djnz CS_Loop
CS_End	ld sp,$0000
	ret

;; FindRow routine for finding a row start address.
;; input:
;;   PixelAddress - the used pixel start address
;;   b - Y coordinate (0-191)
;; output:
;;   hl - pointer to the pixel address
;; destroys:
;;   a, flags
FindRow	ld hl,(PixelAddress)
	ld a,b
	and %00000111
	add a,h
	ld h,a
	ld a,b
	and %11000000
	rra
	rra
	rra
	add a,h
	ld h,a
	ld a,b
	and %00111000
	rla
	rla
	ld l,a
	ret

;; NextRow routine for finding the next row address.
;; input:
;;   hl - current pixel address
;; output:
;;   hl - next row pixel address
;; destroys:
;;   a, flags
NextRow	inc h
	ld a,h
	and 7
	ret nz
	ld a,l
	add a,32
	ld l,a
	ret c
	ld a,h
	sub 8
	ld h,a
	ret

;; LastRow routine for finding the last row address.
;; input:
;;   hl - current pixel address
;; output:
;;   hl - next row pixel address
;; destroys:
;;   a, flags
LastRow	dec h
	ld a,h
	and 7
	cp 7
	ret nz
	ld a,l
	sub 32
	ld l,a
	ret c
	ld a,h
	add a,8
	ld h,a
	ret

;; FindPixel routine for finding a pixel address and mask.
;; input:
;;   PixelAddress - the used pixel start address
;;   b - Y coordinate (0-191)
;;   c - X coordinate (0-255)
;; output:
;;   hl - pointer to the pixel address
;;   a - bitmask for the pixel address
;; destroys:
;;   de, flags
FindPixel	call FindRow
	ld a,c
	and %11111000
	rra
	rra
	rra
	or l
	ld l,a
	ld de,BitMasks
	ld a,c
	and %00000111
	or e
	ld e,a
	ld a,(de)
	ret

;; GetPixel routine for getting a pixel from screen.
;; input:
;;   PixelAddress - the used pixel start address
;;   b - Y coordinate (0-191)
;;   c - X coordinate (0-255)
;; output:
;;   a - pixel value
;;   flags - zero flag set if pixel was zero
;; destroys:
;;   hl, de
GetPixel	call FindPixel
	and (hl)
	ret

;; SetPixel routine for setting a pixel on screen.
;; input:
;;   PixelAddress - the used pixel start address
;;   b - Y coordinate (0-191)
;;   c - X coordinate (0-255)
;; destroys:
;;   hl, de, a, flags
SetPixel	call FindPixel
	or (hl)
	ld (hl),a
	ret

;; ClearPixel routine for clearing a pixel on screen.
;; input:
;;   PixelAddress - the used pixel start address
;;   b - Y coordinate (0-191)
;;   c - X coordinate (0-255)
;; destroys:
;;   hl, de, a, flags
ClearPixel	call FindPixel
	cpl
	and (hl)
	ld (hl),a
	ret

;; FindColor routine for finding a color memory address.
;; input:
;;   ColorAddress - the used color start address
;;   b - Y coordinate (0-23)
;;   c - X coordinate (0-31)
;; output:
;;   hl - pointer to the color address
;; destroys:
;;   flags
FindColor	ld hl,(ColorAddress)
	ld a,b
	and %00011000
	rrca
	rrca
	rrca
	add a,h
	ld h,a
	ld a,b
	and %00000111
	rrca
	rrca
	rrca
	ld l,a
	ld a,c
	and %00011111
	or l
	ld l,a
	ret

;; PutBlock routine for plotting a 8x8 block on screen.
;; input:
;;   PixelAddress - the used pixel start address
;;   hl - pointer to 8 bytes of block data
;;   b - Y coordinate (0-23)
;;   c - X coordinate (0-31)
;; destroys:
;;   de, a, flags
PutBlock	push bc
	ex de,hl
	ld a,b
	rlca
	rlca
	rlca
	ld b,a
	call FindRow
	ld a,c
	add a,l
	ld l,a
	ld b,8
PB_Loop	ld a,(de)
	ld (hl),a
	inc de
	inc h
	djnz PB_Loop
	pop bc
	ret

;; FindChar routine for finding a character block.
;; input:
;;   CharAddress - the used charset font
;;   a - character code
;; output:
;;   hl - pointer to character block
;; destroys:
;;   a, flags
FindChar	push de
	ld hl,(CharAddress)
	ld d,0
	rept 3
	rla
	rl d
	endm
	ld e,a
	add hl,de
	pop de
	ret

;; PutChar routine for plotting a character on screen.
;; input:
;;   PixelAddress - the used pixel start address
;;   CharAddress - the used charset font
;;   b - Y coordinate (0-23)
;;   c - X coordinate (0-31)
;;   a - character code
;; destroys:
;;   a, flags
PutChar	push hl
	call FindChar
	call PutBlock
	pop hl
	ret

;; PutString routine for plotting a string on screen.
;; input:
;;   PixelAddress - the used pixel start address
;;   CharAddress - the used charset font
;;   hl - pointer to the string
;;   b - Y coordinate (0-23)
;;   c - X coordinate (0-31)
;; destroys:
;;   de, a, flags
PutString	push hl
	push bc
PS_Loop	ld a,c
	cp 32
	jr nc,PS_Exit
	ld a,(hl)
	or a
	jr z,PS_Exit
	call PutChar
	inc hl
	inc c
	jr PS_Loop
PS_Exit	pop bc
	pop hl
	ret

;; RandomByte routine for getting a random number in the range [0,255]. The
;; produced random numbers loop every 256 times unless the seed is changed.
;; See: http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng
;; input:
;;   RandomSeed - a 12-bit seed for random
;; output:
;;   RandomSeed - lowest 8 bits updated for next step
;;   a - random number in the range [0,255]
;; destroys:
;;   flags
RandomByte	push hl
	ld hl,RNG_Table
	ld a,(RandomSeed+1)
	and $0f
	add a,l
	ld l,a
	ld a,0
	adc a,h
	ld h,a
	ld a,(RandomSeed)
	or a
	jr z,RNG_DoXOR
	sla a
	jr z,RNG_NoXOR
	jr nc,RNG_NoXOR
RNG_DoXOR	xor (hl)
RNG_NoXOR	ld (RandomSeed),a
	pop hl
	ret

RNG_Table	db $1d,$2b,$2d,$4d,$5f,$63,$65,$69
	db $71,$87,$8d,$a9,$c3,$cf,$e7,$f5

;; DissolveScreen routine for fading color memory from old state to new state.
;; Can be used for fading nicely between an empty screen and a colored screen.
;; input:
;;   RandomSeed - a 12-bit seed for random
;;   ColorAddress - the used color start address
;; destroys:
;;   a, flags
DissolveScreen	push bc
	push de
	push hl
	ld b,0
DS_Idx	defl 0
DS_Loop	rept 3
	call RandomByte
	ld d,DS_Idx
	ld e,a
	pop hl
	push hl
	add hl,de
	ld a,(hl)
	ld hl,(ColorAddress)
	add hl,de
	ld (hl),a
	push bc
	ld b,128
	djnz $
	pop bc
DS_Idx	defl DS_Idx+1
	endm
	djnz DS_Loop
	jr nz,DS_Loop
	pop hl
	pop de
	pop bc
	ret

;; CopyByte routine for copying a byte to a memory address with a bit offset.
;; For example to copy byte %11100111 in (de) to address (hl) with offset
;; %00010000 would result (hl),(hl+1) containing %00011100,%11100000. If the
;; offset was for example %00000101 the result would be different, namely
;; %00000111,%00111000. For plotting XOR is always used, so if there is already
;; some content it will be modified accordingly.
;; input:
;;   hl - output start address
;;   de - input byte address
;;   a - mask of start bit
;;   c - >248 if not overflowing to second byte
;; destroys:
;;   bc, a, flags
CopyByte	ld b,c	; Overflow flag in c
	ld c,a	; Start mask in c
	ld a,(de)	; Output byte in a
	ld d,b	; Overflow flag in d
	ld b,0xff	; Bitmask in b
CB_Rotate	rl c
	jr c,CB_EndRotate
	srl b
	rrca
	jr CB_Rotate
CB_EndRotate	ld c,a	; Rotated byte in c
	and b
	xor (hl)
	ld (hl),a
	ld a,d	; Overflow flag in a
	cp 249	; Check if >248
	ret nc
	inc hl
	ld a,b
	cpl	; Complement of bitmask in a
	and c
	xor (hl)
	ld (hl),a
	dec hl
	ret

;; PutByte for putting a byte in (hl) on screen with a pixel location.
;; input:
;;   b - Y coordinate (0-191)
;;   c - X coordinate (0-255)
;;   hl - pointer to the outputted byte
;; destroys:
;;   de, a, flags
PutByte	push bc
	push hl
	push hl
	call FindPixel
	pop de
	call CopyByte
	pop hl
	pop bc
	ret

;; PutSprite for putting a 8x8 block in any pixel location.
;; input:
;;   b - Y coordinate (0-191)
;;   c - X coordinate (0-255)
;;   hl - pointer to the sprite data
;; destroys:
;;   a, flags
PutSprite	ld d,8
	push bc
	push hl
	push de
PS_Loop2	call PutByte
	inc hl
	inc b
	ld a,b	; Check if Y coordinate >191
	cp 192
	jr nc,PS_Out
	pop de
	dec d
	push de
	jr nz,PS_Loop2
PS_Out	pop de
	pop hl
	pop bc
	ret

;; PutChar routine for plotting a character on screen.
;; input:
;;   PixelAddress - the used pixel start address
;;   CharAddress - the used charset font
;;   b - Y coordinate (0-191)
;;   c - X coordinate (0-255)
;;   a - character code
;; destroys:
;;   a, flags
PutChar2	call FindChar
	call PutSprite
	ret
