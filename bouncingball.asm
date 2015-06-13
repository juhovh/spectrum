;; Copyright (c) 2014 Tiina Romu and Heidi Lehtevä
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

;; Variables
default_colour              equ PAPER_BLACK+INK_GREEN+BRIGHT
end_colour                  equ PAPER_BLACK+INK_GREEN+BRIGHT+FLASH
loop_counter                db 0
direction_y                 db 1
direction_x                 db 1

string:
db 'Awesome!',0

bouncingball:
    ;; Clear screen before doing anything else
    call ClearScreen

    ;; Border colour
    ld a, INK_BLACK
    out ($fe),a

    ;; We want to set backgroung colour
    ;; we have 768 bytes and we start from address pointer $5800
    ld hl,$5800
    ld bc,768

    ld a, 0
    ld (loop_counter), a

background_loop:
    ;; Load the colour we want to the 8x8 pixel cell
    ld (hl),default_colour

    ;; Increase hl and decrease bc
    inc hl
    dec bc

    ;; Check if bc is completely 0
    ld a,b
    or c

    ;; Continue loop if not 0
    jr nz,background_loop

    call DrawHome

    ;; set value needed in draw-loop
    ld b,3
    ld c,3



draw_loop:
    ;; Clear previous pixel drawn and change coordinates
    call ClearBall
    ld a, (direction_x)
    ld h, a

    ld a, c
    add a, h
    ld c, a

    ld a, (direction_y)
    ld h, a

    ld a, b
    add a, h
    ld b, a

    ;; Stop loop after
    ld a, (loop_counter)
    cp 10        ;; max bumbs
    jr z, FinishLoop

    ;; Check if Y is over 191
    ld a,b
    cp 189
    jr z, SetValueYToMax

    ;; Check if Y is less than 0
    ld a,b
    cp 2
    jr z, SetValueYToZero

    ;; Check if X is over 255
    ld a,c
    cp 253
    jr z, SetValueXToMax

    ;; Check if Y is less than 0
    ld a,c
    cp 2
    jr z, SetValueXToZero

    ;; Draw ball to screen
    call DrawBall

    push bc

    ;; Wait a while before moving ball
    ld b,1
    halt
    djnz $-1

    pop bc
    jr draw_loop

;; Our very own functions to set values to X and Y when we meet borders

FinishLoop ld a, INK_BLACK
    out ($fe),a

    ld hl, string
    ld b, 10
    ld c, 12
    call PutString

    ld hl,$5800
    ld bc,768
    jp EndLoop


DrawHome ld a,%11111100
    ld ($400F),a
    ld ($410F),a
    ld ($420F),a
    ld ($430F),a

    ld a,%00111111
    ld ($400E),a
    ld ($410E),a
    ld ($420E),a
    ld ($430E),a

    ld a,%11111111
    ld ($440F),a
    ld ($440E),a
    ld ($450F),a
    ld ($450E),a

    ret

;; Load the colour we want to the 8x8 pixel cell
EndLoop ld (hl),end_colour

    ;; Increase hl and decrease bc
    inc hl
    dec bc

    ;; Check if bc is completely 0
    ld a,b
    or c

    ;; Continue loop if not 0
    jr nz, EndLoop

    ret

SetValueYToMax  ld a, 255
    ld (direction_y), a
    ld a, INK_MAGENTA
    out ($fe),a
    jp IncreaseCounter

SetValueYToZero ld a, 1
    ld (direction_y), a
    ld a, INK_BLUE
    out ($fe),a
    jp IncreaseCounter

SetValueXToMax  ld a, 255
    ld (direction_x), a
    ld a, INK_CYAN
    out ($fe),a
    jp IncreaseCounter

SetValueXToZero ld a, 1
    ld (direction_x), a
    ld a, INK_YELLOW
    out ($fe),a
    jp IncreaseCounter

Draw5Pixels call SetPixel
    push bc

    ;; y=2
    ld a, b
    add a, 2
    ld b, a
    call SetPixel

    ;; y=1
    ld a, b
    add a, -1
    ld b, a
    call SetPixel

    ;; y=-1
    ld a, b
    add a, -2
    ld b, a
    call SetPixel

    ;; y=-2
    ld a, b
    add a, -1
    ld b, a
    call SetPixel

    pop bc
    ret

Draw3Pixels call SetPixel
    push bc

    ;; y=1
    ld a, b
    add a, 1
    ld b, a
    call SetPixel

    ;; y=-1
    ld a, b
    add a, -2
    ld b, a
    call SetPixel

    pop bc
    ret

Clear5Pixels call ClearPixel
    push bc

    ;; y=2
    ld a, b
    add a, 2
    ld b, a
    call ClearPixel

    ;; y=1
    ld a, b
    add a, -1
    ld b, a
    call ClearPixel

    ;; y=-1
    ld a, b
    add a, -2
    ld b, a
    call ClearPixel

    ;; y=-2
    ld a, b
    add a, -1
    ld b, a
    call ClearPixel

    pop bc
    ret

Clear3Pixels call ClearPixel
    push bc

    ;; y=1
    ld a, b
    add a, 1
    ld b, a
    call ClearPixel

    ;; y=-1
    ld a, b
    add a, -2
    ld b, a
    call ClearPixel

    pop bc
    ret

DrawBall call Draw5Pixels
    push bc

    ;; x=1
    ld a, c
    add a, 1
    ld c, a
    call Draw5Pixels

    ;; x=-1
    ld a, c
    add a, -2
    ld c, a
    call Draw5Pixels

    ;; x=-2
    ld a, c
    add a, -1
    ld c, a
    call Draw3Pixels

    ;; x=2
    ld a, c
    add a, 4
    ld c, a
    call Draw3Pixels

    pop bc
    ret

ClearBall call Clear5Pixels
    push bc

    ;; x=1
    ld a, c
    add a, 1
    ld c, a
    call Clear5Pixels

    ;; x=-1
    ld a, c
    add a, -2
    ld c, a
    call Clear5Pixels

    ;; x=-2
    ld a, c
    add a, -1
    ld c, a
    call Clear3Pixels

    ;; x=2
    ld a, c
    add a, 4
    ld c, a
    call Clear3Pixels
    call DrawHome

    pop bc
    ret

IncreaseCounter ld a, (loop_counter)
    ld h, a
    inc h
    ld a, h
    ld (loop_counter), a
    jp draw_loop

