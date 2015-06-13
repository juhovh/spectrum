;; Copyright (c) 2014 Antti Ajanki
;;
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;; THE SOFTWARE.

scroll_buffer ds 256, $00

credits_string
    db '            Futurice            '
    db '            spectrum            '
    db '              demo              '
    db '                                '
    db '        Made in Finland         '
    db '    Assembled in London, UK     '
    db '                                '
    db '    Thank you for watching!!    '
    db '     You, sir, are awesome!     '
    db '                                '
    db '            Code by:            '
    db '      Juho, Teemu, Antti,       '
    db '      Tiina, Heidi, Kimmo       '
    db '                                '
    db '            Music by:           '
    db '   Arto, Markus, Jetro, Janos   '
    db '                                '
    db '           Greetings to:        '
    db '            Futurice            '
    db '           Graffathon           '
    db '     Lean IT Consultancies      '
    db $00

buffer_fill_count    db 0

;; Scroll one screenful upwards filling with $FF pixels
;; input:
;;   PixelAddress - Base address for the screen

ScrollScreenUp:
    ld a, $00
    call FillScrollBuffer
    ld b, 192
SSU_Loop
    halt
    call ScrollOneRowUp
    ld a, b
    and 7
    neg
    add a, 8
    and 7
    call FillLastRow
    djnz SSU_Loop
    ret

;; Scroll credits text
;; input:
;;   credits_string - String lines to scroll
;;   PixelAddress - Base address for the screen
ScrollCredits:
    ;; Number of rows to scroll
    ;; Must be divisable by 8
    ld bc, 384
    ld a, 0
    ld (buffer_fill_count), a
SC_Loop
    ld a, c
    and 7
    call z, ReloadScrollBuffer
    halt
    call ScrollOneRowUp
    ld a, c
    and 7
    neg
    add a, 8
    and 7
    call FillLastRow
    dec bc
    ld a,b
    or c
    jr nz, SC_Loop
    ret

;; destroys:
;;   a,de,hl,flags
ScrollOneRowUp:
    push bc
    ld hl, (PixelAddress)
    ld b, 191
Copy_loop
    call CopyRow
    call NextRow
    djnz Copy_loop
    pop bc
    ret

;; Copy a row from scroll buffer to the last line in the screen buffer
;; input:
;;   a - row number to copy (0-7)
;; destroys:
;;   a,de,hl,flags
FillLastRow:
    push bc
    and 7
    sla a
    sla a
    sla a
    sla a
    sla a
    ld hl, scroll_buffer
    ld d, 0
    ld e, a
    add hl, de
    ld b, h
    ld c, l
    ld hl, (PixelAddress)
    ld de, $17E0
    add hl, de
    ex de, hl
    ld h, b
    ld l, c
    ld bc, 32
    ldir
    pop bc
    ret

;; Fill next 8 lines in scroll_buffer
;; destroys:
;;   a, de, hl, flags
ReloadScrollBuffer:
    push bc
    ld a, (buffer_fill_count)
    inc a
    ld (buffer_fill_count), a

    dec a
    or a
    ld d, 0
    ld e, a
    rept 5
    rl e
    rl d
    endm
    ld hl, credits_string
    add hl, de
    ld a, (hl)
    or a
    jp z, RSB_Empty
    
    ld de, scroll_buffer
    call PutStringOffscreen
    jp RSB_End
    
RSB_Empty
    ld a, (buffer_fill_count)
    dec a
    ld (buffer_fill_count), a
    ld a, 0
    call FillScrollBuffer

RSB_End
    pop bc
    ret

;; Fill scroll_buffer with one color
;; input:
;;   a - byte used for filling
;; destroys:
;;   bc, de, hl, flags
FillScrollBuffer
    ld hl, scroll_buffer
    ld de, scroll_buffer
    inc de
    ld (hl), a
    ld bc, 255
    ldir
    ret
    
;; Plot a 8x8 block to a offscreen buffer.
;; Offscreen buffer must be 256 pixels wide.
;; input:
;;   de - pointer to 8 bytes of block data
;;   hl - pointer to offscreen buffer
PutBlockOffscreen
    push bc
    ld bc, 32
    rept 8
    ld a, (de)
    ld (hl), a
    inc de
    add hl, bc
    endm
    pop bc
    ret

;; PutCharOffscreen routine for plotting a character onto a buffer.
;; input:
;;   CharAddress - the used charset font
;;   de - offscreen buffer
;;   a - character code
;; destroys:
;;   a, flags
PutCharOffscreen	push hl
    push de
    push bc
    ld b, d
    ld c, e
    ld hl,(CharAddress)
    ld d,0
    rla
    rl d
    rla
    rl d
    rla
    rl d
    ld e,a
    add hl,de
    ld d, h
    ld e, l
    ld h, b
    ld l, c
    call PutBlockOffscreen
    pop bc
    pop de
    pop hl
    ret

;; PutString routine for plotting a string to an offscreen buffer
;; input:
;;   CharAddress - the used charset font
;;   hl - pointer to the 32 letter string
;;   de - pointer to the offscreen buffer
;; destroys:
;;   de, hl, a, flags
PutStringOffscreen
    push bc
    ld b, 32

PSO_Loop
    ld a, (hl)
    inc hl
    call PutCharOffscreen
    inc de
    dec b
    jr nz, PSO_Loop
    
    pop bc
    ret

;; destroys:
;;   a,de,flags
CopyRow:
    push bc
    push hl
    ld d,h
    ld e,l
    call NextRow
    ld bc,32
    ldir
    pop hl
    pop bc
    ret 
