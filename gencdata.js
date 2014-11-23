var fs = require('fs');

// Generates a lookup table for circle
var rounds = 128;
var radius = 90;
var xcenter = 128;
var ycenter = 96;
var xoffset = -4;
var yoffset = -4;
var buffer = new Buffer(2*rounds);
for (var i=0; i<rounds; i++) {
  var angle = i*2*Math.PI/rounds;
  var sin = Math.sin(angle);
  var cos = -Math.cos(angle);
  var xcoord = Math.round(xcenter+sin*radius+xoffset);
  var ycoord = Math.round(ycenter+cos*radius+yoffset);
  buffer[i*2] = xcoord;
  buffer[i*2+1] = ycoord;
}
fs.writeFileSync('cdata.dat', buffer);
