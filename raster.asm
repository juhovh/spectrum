include loader.asm

init:
 xor a
 out ($fe),a
 ld hl,$5800
 ld de,$5801
 ld bc,$02ff
 ld (hl),$00
 ldir
 ld a,$00
 ld hl,$4000
 ld b,$00
mloop1:
 ld (hl),a 
 inc hl 
 djnz mloop1
 ld a,$ff
 ld hl,$4100
 ld b,$00
mloop2:
 ld (hl),a 
 inc hl
 djnz mloop2
 ld hl,$4000
 ld de,$4200
 ld bc,$0e00
 ldir
 ld hl,$5000
 ld de,$5001
 ld bc,$0fff
 ld (hl),$00
 ldir
 ret

include rasterint.asm

main:
 ld bc,$7ffe
 in a,(c)
 and $01
 jr nz,main
 ret

clear:
 ret

end loader
