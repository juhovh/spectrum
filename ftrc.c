#include <stdlib.h>
#include <graphics.h>

// compile with
// zcc +zx -lndos -lm -create-app -o ftrc ftrc.c

main()
{
	int i, x, y, dx, dy, r, dr;
	clg();

	// laz0rs
	for (i = 0; i < 250; i++) {
		x = rand() % getmaxx();
		y = rand() % getmaxy();
		dx = rand() % getmaxx();
		dy = rand() % getmaxy();
		draw(0, 0, x, y);
		draw(0, 0, dx, dy);
		ftrc();
	}
	clg();

	// sc4nn3rz
	for(i = 0; i < 100; i ++) {
		x = rand() % getmaxx();
		y = rand() % getmaxy();
		draw(x, 0, x, getmaxy());
		draw(0, y, getmaxx(), y);
		ftrc();
	}
	clg();

	// chA0z
	for (i = 0; i < 250; i++) {
		x = rand() % getmaxx();
		y = rand() % getmaxy();
		dx = rand() % getmaxx();
		dy = rand() % getmaxy();
		draw(x, y, dx, dy);
		draw(y, x, dy, dx);
		draw(x, dy, dy, x);
		awsm();
	}

	// dissolve
	for (i = 0; i < 150; i++) {
		x = rand() % getmaxx();
		y = rand() % getmaxy();
		dx = rand() % getmaxx();
		dy = rand() % getmaxy();
		uncircle(x, y, rand()%getmaxx(), 1);
		uncircle(y, x, rand()%getmaxx(), 1);
		undraw(x, y, dx, dy);
		undraw(y, x, dy, dx);
		undraw(0, y, getmaxx(), y);
		undraw(dx, 0, dx, getmaxy());
		awsm();
	}
	clg();
}

int ftrc() {
	// F
	clga(10, 40, 60, 20);
	clga(10, 70, 40, 20);
	clga(10, 65, 20, 80);
	// T
	clga(50, 40, 80, 20);
	clga(80, 40, 20, 100);
	// R
	clga(130, 40, 60, 20);
	clga(130, 65, 20, 70);
	clga(170, 40, 20, 40);
	clga(150, 80, 30, 20);
	clga(170, 100, 20, 60);
	// C
	clga(195, 40, 50, 20);
	clga(195, 60, 20, 80);
	clga(195, 120, 50, 20);
	return 0;
}

int awsm() {
	// A
	clga(10, 40, 50, 20);
	clga(10, 70, 40, 20);
	clga(10, 65, 20, 80);
	clga(40, 40, 20, 90);
	// W
	clga(65, 40, 20, 90);
	clga(90, 80, 10, 50);
	clga(105, 40, 20, 90);
	clga(65, 110, 60, 20);
	// S
	clga(130, 40, 50, 20);
	clga(130, 40, 20, 50);
	clga(130, 70, 50, 20);
	clga(160, 70, 20, 40);
	clga(130, 110, 50, 20);
	// M
	clga(185, 40, 50, 20);
	clga(185, 40, 20, 90);
	clga(210, 40, 10, 50);
	clga(225, 40, 20, 110);

	return 0;
}
