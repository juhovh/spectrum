;; Copyright (c) 2014 Teemu Turunen
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

empty	ds $300

	; empty color memory
	ld bc,$2ff
	ld hl,$5800
	ld de,$5801
	ld (hl),0
	ldir

	; Load pixel data
	ld bc,$1800
	ld hl,robos
	ld de,$4000
	ldir

	; Update color memory
	ld hl,robos+$1800
	call DissolveScreen

	; Wait for five seconds
	ld b,250
	halt
	djnz $-1

        ; Wait for five seconds
        ld b,250
        halt
        djnz $-1

        ; Wait for five seconds
        ld b,250
        halt
        djnz $-1

        ; Wait for three seconds
        ld b,150
        halt
        djnz $-1

	; Empty the screen
	ld hl,empty
	call DissolveScreen
