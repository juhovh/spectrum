all:
	zcc +zx -lndos -lm -zorg=40960 -o ftrc.tmp ftrc.c
	python z88dkpatcher.py ftrc.tmp ftrc.bin
	pasmo --tapbas player_int.asm player_int.tap
clean:
	rm -f *.bin *.tmp *.tap *.def

