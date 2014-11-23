    org $8000

INCLUDE utils.asm

scroll_buffer ds 256, $FF

buffer_fill_count    db 0

start:
    call DrawTestPattern
    call ScrollScreenUp

    di
    halt
    ret


ScrollScreenUp:
    ;; Number of rows to scroll
    ;; Must be divisable by 8
    ld b, 192
ScrollRowLoop
    ;; ld a, b
    ;; and 7
    ;; call z, ReloadScrollBuffer

    halt
    call ScrollOneRowUp
    ld a, b
    and 7
    neg
    add a, 7
    call FillLastRow
    djnz ScrollRowLoop
    ret

;; destroys:
;;   a,de,hl,flags
ScrollOneRowUp:
    push bc
    ld hl, $4000
    ld b, 191
Copy_loop
    call CopyRow
    call NextRow
    djnz Copy_loop
    pop bc
    ret
    

DrawTestPattern:
    ld hl, $50E0
    ld de, $50E1
    ld bc, 31
    ld (hl), %00110011
    ldir

    ld hl, $51E0
    ld de, $51E1
    ld bc, 31
    ld (hl), %11001100
    ldir

    ret

;; Copy a row from scroll buffer to the last line in the screen buffer
;; input:
;;   a - row number to copy (0-7)
;; destroys:
;;   a,de,hl,flags
FillLastRow:
    push bc
    ld a, b
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
    ld de, $57E0
    ld bc, 32
    ldir
    pop bc
    ret

;; Fill next 8 lines in scroll_buffer
;; destroys:
;;   a,de,hl,flags
ReloadScrollBuffer:
    ld a, (buffer_fill_count)
    inc a
    ld (buffer_fill_count), a
    
    push bc
    ld hl, scroll_buffer
    ld (hl), a
    ld d, h
    ld e, l
    inc de
    ld bc, 255
    ldir
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

end start
