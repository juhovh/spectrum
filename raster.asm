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
 ld bc,$07ff
 ld (hl),$00
 ldir

 ld hl,$5800
 ld de,$5801
 ld bc,$02ff
 ld (hl),$07
 ldir

 ld hl,song
 xor a
 ld (PTxPlay+10),a
 call PTxPlay+3
 ret

main:
 ld bc,$7ffe
 in a,(c)
 and $01
 jr nz,main
 ret

clear:
 call PTxPlay+8

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

datasrc: dw $4000

interrupt:
 di
 push af
 push bc
 push de
 push hl
 push ix
 exx
 ex af,af'
 push af
 push bc
 push de
 push hl
 push iy

 ld (rsp+1),sp
 ld hl,(datasrc)
 exx
 ld hl,$5060+16         ; first line $5060
scrl:
 exx
 ld sp,hl
 pop af
 pop bc
 pop de
 pop ix
 ex af,af'
 exx
 pop af
 pop bc
 pop de
 pop iy
 ld sp,hl
 push iy
 push de
 push bc
 push af
 ex af,af'
 exx
 push ix
 push de
 push bc
 push af
 ld de,16
 add hl,de
 exx
 ld de,16
 add hl,de
 exx
 ld sp,hl
 pop af
 pop bc
 pop de
 pop ix
 ex af,af'
 exx
 pop af
 pop bc
 pop de
 pop iy
 ld sp,hl
 push iy
 push de
 push bc
 push af
 ex af,af'
 exx
 push ix
 push de
 push bc
 push af
 ld de,16
 add hl,de
 exx
 ld de,-16
 add hl,de
 inc h
 ld a,h
 and $07
 jr nz,scrl
 ld a,h
 sub 8
 ld h,a
 ld a,l
 add a,32
 ld l,a
 cp $C0                 ; last line $50C0
 jr c,scrl
rsp:
 ld sp,0
 ld b,38
 djnz $
 nop

 ld de,fillerdata
 ld a,0
 call filler
 call PTxPlay+5

 ld hl,fillerdata
 ld de,fillerdata+1
 ld bc,63
 ld (hl),$00
 ldir

 ld hl,counter
 inc (hl)

 ld de,bardata1
 ld a,(counter)
 and $3f
 cp $20
 jr c,plot1
 ld de,bardata2
 add a,$10
plot1:
 call plotbar

 ld de,bardata2
 ld a,(counter)
 and $3f
 cp $20
 jr c,plot2
 ld de,bardata1
 sub $10
plot2:
 add a,$10
 call plotbar

 pop iy
 pop hl
 pop de
 pop bc
 pop af
 exx
 ex af,af'
 pop ix
 pop hl
 pop de
 pop bc
 pop af
 ei
 ret

plotbar:
 and $3f
 ld hl,sinetable
 add a,l
 ld l,a
 ld a,0
 adc a,h
 ld h,a
 ld a,(hl)
 ex de,hl
 ld de,fillerdata
 add a,e
 ld e,a
 ld a,0
 adc a,d
 ld d,a
 ld bc,16
 ldir
 ret

counter:
db 0

sinetable:
db $00, $00, $00, $01, $01, $02, $04, $05
db $07, $08, $0A, $0C, $0E, $11, $13, $15
db $17, $1A, $1C, $1E, $21, $23, $25, $27
db $28, $2A, $2B, $2D, $2E, $2E, $2F, $2F
db $30, $2F, $2F, $2E, $2E, $2D, $2B, $2A
db $28, $27, $25, $23, $21, $1E, $1C, $1A
db $18, $15, $13, $11, $0E, $0C, $0A, $08
db $07, $05, $04, $02, $01, $01, $00, $00

bardata1:
db $08, $09, $19, $1b, $2b, $2d, $3d, $3f
db $2f, $2d, $1d, $1b, $0b, $09, $01, $00

bardata2:
db $00, $03, $03, $1e, $1e, $37, $37, $3e
db $36, $3f, $37, $36, $1e, $1b, $03, $00

fillerdata:
ds 64

;; The first line where this routine is relevant is the line 64, but we need
;; to start during line 63, which starts 62*228-24 = 14112 T states after
;; interrupt. The first run from "ld l,h" until "out ($fe),a" takes 183
;; T states and our line is 24+128+24 = 176 T states long, plus we need to do
;; the timing based on the second "out ($fe),a" because that is when contended
;; memory starts The earliest time the second out can happen is 14112+176 =
;; 14288 T states after interrupt, and the latest is 63*228-24 = 14340 T
;; states after interrupt.
;;
;; Because we have 183 T states between the first two out instructions and our
;; first out instruction is 11 T states and our ld instruction is 7 T states,
;; we should start running this routine between 14087 and 14139 T states after
;; interrupt. Handling contended memory makes our routine very unstable and
;; even interrupt handler can vary -+3 T states, so we should aim to the
;; middle, which is 14113 T states.
;;
;; Further runs of this routine should always be exactly 2*228 = 456 T states
;; long, because our handling of contended memory should always add exactly 84
;; extra T states to the loop.
;;
;; On Spectrum +2A and +3 we seem to have problems if the routine starts at
;; 14113 T states, but we can tune it down to 14109 T states and things work
;; much nicer on all 128K platforms, this seems to be a glitch with a
;; different contended memory delay pattern that can be fixed by being early.

genfiller MACRO address, rows
LOCAL _idx
idx DEFL 0
REPT rows
 LOCAL fillloop
 ld b,4
fillloop DEFL $
 out ($fe),a
 ld a,(de)
 ld h,a
 ld l,a
 and %00111000
 rrca
 rrca
 rrca
 inc de
 nop
 ld (address+idx*$20+$00),hl
 ld (address+idx*$20+$02),hl
 ld (address+idx*$20+$04),hl
 ld (address+idx*$20+$06),hl
 ld (address+idx*$20+$08),hl
 ld (address+idx*$20+$0A),hl
 ld (address+idx*$20+$0C),hl
 ld (address+idx*$20+$0E),hl
 out ($fe),a
 ld (address+idx*$20+$10),hl
 ld (address+idx*$20+$12),hl
 ld (address+idx*$20+$14),hl
 ld (address+idx*$20+$16),hl
 ld (address+idx*$20+$18),hl
 ld (address+idx*$20+$1A),hl
 ld (address+idx*$20+$1C),hl
 ld (address+idx*$20+$1E),hl
 nop
 nop
 nop
 nop
 ld a,l 
 and %00000111
 dec b
 jr z,$+4       ; if zero, then 12 T states
 jr fillloop    ; otherwise 12+7 T states
idx DEFL idx + 1
ENDM
 ld b,0
 out ($fe),a    ; last line, nothing to do
 ld b,16
 djnz $
 nop
 nop
 xor a
 out ($fe),a    ; change border back to black
ENDM

filler:
 genfiller $5800, 16
 ret

org $c000
PTxPlay:
incbin PTxPlay

song:
incbin ROBOCOP.pt3

end loader
