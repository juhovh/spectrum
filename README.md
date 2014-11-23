ZX Spectrum Utilities
=====================

Random utilities freely used in ZX Spectrum products, more information and
documentation should be added here later.

For build environment, read
http://futurice.com/blog/build-environment-like-its-1986 blog post.

To compile for example the music player, write:

`pasmo --tapbas player.asm player.tap`

If you want to convert it to wav so that you can record it to a tape, you can
try:

`appmake +zx --dumb --audio -b player.tap`

The resulting player.wav should contain the application binary.

Linking C code to ASM code
--------------------------

If you have a working C program in `hello.c` and want to include it in your
assembly code, you could do the following.

`zcc +zx -lndos -lm -zorg=40960 -o hello.bin hello.c`

Then create a `hello.asm` file with following contents:

```
org $8000
main
  call hello_c
  ret

org 40960
hello_c incbin hello.bin

end main
```

Compile `hello.asm` with `pasmo --tapbas hello.asm hello.tap` and you have a
nice working file. You probably want to use some other free memory address
instead of 40960 ($a000) and call the C routine from your ASM code, but this
should get you started.

License
-------

```
Copyright (c) 2014 Juho Vähä-Herttua

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
