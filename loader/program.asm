	org $8000

main	xor a
	out ($fe),a
	di
	halt
	end
