include loader.asm

init:
 xor a
 out ($fe),a

 ld hl,$4000
 ld de,$4001
 ld bc,$00ff
 ld (hl),$00
 ldir

 ld hl,$4100
 ld de,$4101
 ld bc,$00ff
 ld (hl),$ff
 ldir

 ld hl,$4000
 ld de,$4200
 ld bc,$0e00
 ldir

 ld hl,$5000
 ld de,$5001
 ld bc,$0aff
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
 ld a,7
 out ($fe),a

 ld hl,$4000
 ld de,$4001
 ld bc,$17FF
 ld (hl),0
 ldir

 ld hl,$5800
 ld de,$5801
 ld bc,$2FF
 ld (hl),$38
 ldir
 ret

end loader
