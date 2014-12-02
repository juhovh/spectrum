# Binary patches di and ei out of libsrc/graphics/spectrum/swapgfxbk.asm
# Needed to get interrupt routines up and running

import sys

oldbytes = bytearray.fromhex(u'f3 c9 fd 21 3a 5c fb c9')
newbytes = bytearray.fromhex(u'00 c9 fd 21 3a 5c 00 c9')

if len(sys.argv) != 3:
	print "Usage", sys.argv[0], "<input> <output>"
	sys.exit(0)

with open(sys.argv[1], 'rb') as f1:
	fdata = f1.read();
	for i in range(0, len(fdata)-len(oldbytes)+1):
		ourbytes = fdata[i:i+len(oldbytes)]
		if ourbytes == oldbytes:
			print "Patching at index", i
			fdata = fdata[0:i] + newbytes + fdata[i+len(oldbytes):]
	with open(sys.argv[2], 'wb') as f2:
		f2.write(fdata)
