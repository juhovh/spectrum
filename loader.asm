org $8000

REPT 257
db $81 ; interrupt handler at $8181
ENDM

ROM_CLS       EQU $0D6B
ROM_CHAN_OPEN EQU $1601

ldr_string:
db '     PRESS ANY KEY TO START     ',0

loader:
 ; store main registers
 push af
 push bc
 push de
 push hl
 push ix

 ; clear screen
 call ROM_CLS

 ; open channel 2
 ld a,2
 call ROM_CHAN_OPEN

 ; add 11 newlines
 ld b,11
ldr_nl_loop:
 ld a,13
 rst 16
 djnz ldr_nl_loop

 ; print string
 ld hl,ldr_string
ldr_str_loop:
 ld a,(hl)
 cp 0
 jr z,ldr_kb_loop
 rst 16
 inc hl
 jr ldr_str_loop

 ; wait for keypress
ldr_kb_loop:
 halt
 xor a
 in a,($fe)
 cpl
 and 15
 jr z,ldr_kb_loop

 ; disable interrupts
 di

 ; store shadow registers
 exx
 ex af,af'
 push af
 push bc
 push de
 push hl
 push iy

 ; call user provided init
 call init

 ; initialize im 2 jump table to $8000
 ld a,$80
 ld i,a
 im 2

 ; enable interrupts
 ei

 ; call user provided main loop
 call main

 ; disable interrupts
 di

 ; call user provided clear
 call clear

 ; enable default im 1 interrupts
 im 1

 ; restore shadow registers
 pop iy
 pop hl
 pop de
 pop bc
 pop af
 exx
 ex af,af'

 ; enable interrupts
 ei

 ; restore main registers
 pop ix
 pop hl
 pop de
 pop bc
 pop af
 ret

; our custom interrupt handler
org $8181
 jp interrupt
