
; beginning always 23 cycles

interrupt:
 push hl         ; 11    11
 push de         ; 11    22
 push bc         ; 11    33
 push af         ; 11    44
 ld hl,$51df     ; 10    54
 ld c,$07        ; 7     61
loop1:           ; contents 1041
 ld b,$20        ; 7     68
loop2:           ; contents 19
 rl (hl)         ; 15    83
 dec l           ; 4     87
 djnz loop2      ; 1000  1087    31*(19+13)+8
 ld l,$df        ; 7     1094
 inc h           ; 4     1098
 dec c           ; 4     1102
 jp nz,loop1     ; 6316  7418    6*(1041+10)+10
 ld c,$02        ; 7     7425
loop3:           ; contents 3295
 ld b,$fd        ; 7     7432
 djnz $          ; 3284  10716   252*13+8
 dec c           ; 4     10720
 jr nz,loop3     ; 3314  14034   1*(3295+10)+7
 ld de,fillerdata; 10    14044
 ld a,(de)       ; 7     14051
 ld h,a          ; 4     14055
 and $38         ; 7     14062
 rrca            ; 4     14066
 rrca            ; 4     14070
 rrca            ; 4     14074
 ld b,a          ; 4     14078
 inc e           ; 4     14082
 xor a           ; 4     14086

 call filler     ; 17    14103
 ld b,15
 djnz $
 xor a 
 out ($fe),a
 pop af 
 pop bc 
 pop de 
 pop hl 
 ei
 ret 

fillerdata:
db $0b, $2e, $3e, $2b, $08, $08, $09, $19
db $1b, $2b, $2d, $3d, $3f, $2f, $2d, $1d
db $1b, $0b, $09, $01, $01, $25, $37, $3e
db $2c, $08, $01, $13, $25, $37, $01, $02
db $03, $04, $05, $06, $07, $06, $05, $04
db $03, $02, $01, $07, $35, $23, $11, $00
db $15, $37, $3e, $2a, $03, $03, $1e, $1e
db $37, $37, $3f, $37, $36, $1e, $1b, $03

;; The first line where this routine is relevant is the line 64, but we need
;; to start during line 63, which starts 62*228-24 = 14112 T states after
;; interrupt. The first run from "ld l,h" until "out ($fe),a" takes only 155
;; T states and our line is 24+128+24 = 176 T states long, which means we
;; need to start in the middle and do timing based on the second "out
;; ($fe),a". The earliest time it can happen is 14112+176 = 14288 T states
;; after interrupt, and the latest is 63*228-24 = 14340 T states after
;; interrupt.
;;
;; Because we have 155 T states between the first two out instructions and our
;; first out instruction is 11 T states and our ld instruction is 7 T states,
;; we should start running this routine between 14115 and 14167 T states after
;; interrupt. Handling contended memory makes our routine very unstable and
;; even interrupt handler can vary -+3 T states, so we should definitely aim
;; to the middle, which is 14141 T states.
;;
;; Further runs of this routine should always be exactly 2*228 = 456 T states
;; long, because our handling of contended memory should always add exactly 84
;; extra T states to the loop.

outloop MACRO address
 ld c,$04
 out ($fe),a
 ld l,h
 ld a,b
 nop
 nop
 ld (address+$00),hl
 ld (address+$02),hl
 ld (address+$04),hl
 ld (address+$06),hl
 ld (address+$08),hl
 ld (address+$0A),hl
 ld (address+$0C),hl
 ld (address+$0E),hl
 out ($fe),a
 ld (address+$10),hl
 ld (address+$12),hl
 ld (address+$14),hl
 ld (address+$16),hl
 ld (address+$18),hl
 ld (address+$1A),hl
 ld (address+$1C),hl
 ld (address+$1E),hl
 nop
 ld a,(de) 
 inc de 
 ld h,a 
 and $38
 rrca
 rrca
 rrca 
 ld b,a 
 ld a,l 
 and $07
 dec c 
 jr z,$+4
 jr $-72
ENDM

org $a000
filler:
 outloop $5800
 outloop $5820
 outloop $5840
 outloop $5860
 outloop $5880
 outloop $58A0
 outloop $58C0
 outloop $58E0
 outloop $5900
 outloop $5920
 outloop $5940
 outloop $5960
 outloop $5980
 outloop $59A0
 outloop $59C0
 outloop $59E0
 ld c,$04
 out ($fe),a
 ret

