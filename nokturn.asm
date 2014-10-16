org $8000

main:
 ld hl,song
 xor a
 ld ($c00A),a
 call $c003
 ei
loop:
 halt
 call $c005 ; about 5000 T states
 xor a
 in a,($fe)
 cpl
 and 15
 jr z,loop
 call $c008
 ret

song:
incbin Nokturn.pt3

org $c000
incbin PTxPlay

end main
