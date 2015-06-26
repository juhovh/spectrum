all:
	cc -o bas2tap bas2tap.c
	./bas2tap -a10 -sLOADER loader.bas loader.tap
	zcc +zx -lndos -lm -zorg=53248 -o ftrc.tmp ../ftrc.c
	python ../z88dkpatcher.py ftrc.tmp ftrc.bin
	pasmo --tap --name SCREEN screen.asm screen.tap
	pasmo --tap --name PROGRAM program.asm program.tap
	cat loader.tap screen.tap program.tap > spinal.tap

wav:
	appmake +zx --dumb --audio --binfile spinal.tap
