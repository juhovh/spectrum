all:
	cc -o bas2tap bas2tap.c
	./bas2tap -a10 -sLOADER loader.bas loader.tap
	pasmo --tap --name SCREEN screen.asm screen.tap
	pasmo --tap --name PROGRAM program.asm program.tap
	cat loader.tap screen.tap program.tap > final.tap

wav:
	appmake +zx --dumb --audio --binfile final.tap
