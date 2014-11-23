; drawing the growing flower, pixel by pixel

ld b,50
halt
djnz $-1

ld b,1
halt
djnz $-1

ld b,113
ld c,141
call ClearPixel

ld b,1
halt
djnz $-1

ld b,112
ld c,143

Draw112:
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw112

ld b,1
halt
djnz $-1

ld b,111
ld c,143

Draw111:
  dec c
  call ClearPixel
  ld a,c
  cp 138
  jr nz,Draw111

ld b,1
halt
djnz $-1

ld b,110
ld c,143

Draw110:
  dec c
  call ClearPixel
  ld a,c
  cp 138
  jr nz,Draw110

ld b,1
halt
djnz $-1

ld b,109
ld c,143

Draw109:
  dec c
  call ClearPixel
  ld a,c
  cp 137
  jr nz,Draw109

ld b,1
halt
djnz $-1

ld b,108
ld c,143

Draw108:
  dec c
  call ClearPixel
  ld a,c
  cp 137
  jr nz,Draw108

ld b,1
halt
djnz $-1

ld b,107
ld c,143

Draw107:
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw107

ld b,1
halt
djnz $-1

ld b,106
ld c,143

Draw106:
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw106

ld b,1
halt
djnz $-1

ld b,105
ld c,143

Draw105:
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw105

ld b,1
halt
djnz $-1

ld b,104
ld c,144

Draw104:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw104

ld b,1
halt
djnz $-1

ld b,103
ld c,144

Draw103:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw103

ld b,1
halt
djnz $-1

ld b,102
ld c,144

Draw102:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw102

ld b,2
halt
djnz $-1

ld b,101
ld c,144

Draw101:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw101

ld b,2
halt
djnz $-1

ld b,100
ld c,144

Draw100:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw100

ld b,2
halt
djnz $-1

ld b,99
ld c,144

Draw99:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw99

ld b,2
halt
djnz $-1

ld b,98
ld c,144

Draw98:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw98

ld b,2
halt
djnz $-1

ld b,97
ld c,144

Draw97:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw97

ld b,2
halt
djnz $-1

ld b,96
ld c,144

Draw96:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw96

ld b,2
halt
djnz $-1

ld b,95
ld c,144

Draw95:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw95

ld b,2
halt
djnz $-1

ld b,94
ld c,144

Draw94:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw94

ld b,3
halt
djnz $-1

ld b,93
ld c,144

Draw93:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw93

ld b,4
halt
djnz $-1

ld b,92
ld c,160
Draw92:
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw92

ld b,5
halt
djnz $-1

ld b,91
ld c,165

Draw91:
  dec c
  call ClearPixel
  ld a,c
  cp 134
  jr nz,Draw91

ld b,5
halt
djnz $-1

ld b,90
ld c,170

Draw90:
  dec c
  call ClearPixel
  ld a,c
  cp 130
  jr nz,Draw90

ld b,5
halt
djnz $-1

ld b,89
ld c,172

Draw89:
  dec c
  call ClearPixel
  ld a,c
  cp 127
  jr nz,Draw89

ld b,5
halt
djnz $-1

ld b,88
ld c,173

Draw88:
  dec c
  call ClearPixel
  ld a,c
  cp 127
  jr nz,Draw88

ld b,5
halt
djnz $-1

ld b,87
ld c,174

Draw87:
  dec c
  call ClearPixel
  ld a,c
  cp 126
  jr nz,Draw87

ld b,5
halt
djnz $-1

ld b,86
ld c,175

Draw86a:
  dec c
  call ClearPixel
  ld a,c
  cp 145
  jr nz,Draw86a

ld c,140

Draw86b:
  dec c
  call ClearPixel
  ld a,c
  cp 126
  jr nz,Draw86b

ld b,5
halt
djnz $-1

ld b,85
ld c,176

Draw85a:
  dec c
  call ClearPixel
  ld a,c
  cp 146
  jr nz,Draw85a

ld c,139

Draw85b:
  dec c
  call ClearPixel
  ld a,c
  cp 126
  jr nz,Draw85b

ld b,5
halt
djnz $-1

ld b,84
ld c,177

Draw84a:
  dec c
  call ClearPixel
  ld a,c
  cp 148
  jr nz,Draw84a

ld c,138

Draw84b:
  dec c
  call ClearPixel
  ld a,c
  cp 125
  jr nz,Draw84b

ld b,5
halt
djnz $-1

ld b,83
ld c,178

Draw83a:
  dec c
  call ClearPixel
  ld a,c
  cp 149
  jr nz,Draw83a

ld c,138

Draw83b:
  dec c
  call ClearPixel
  ld a,c
  cp 125
  jr nz,Draw83b

ld b,5
halt
djnz $-1

ld b,82
ld c,178

Draw82a:
  dec c
  call ClearPixel
  ld a,c
  cp 149
  jr nz,Draw82a

ld c,138

Draw82b:
  dec c
  call ClearPixel
  ld a,c
  cp 125
  jr nz,Draw82b

ld b,5
halt
djnz $-1

ld b,81
ld c,178

Draw81a:
  dec c
  call ClearPixel
  ld a,c
  cp 150
  jr nz,Draw81a

ld c,138

Draw81b:
  dec c
  call ClearPixel
  ld a,c
  cp 124
  jr nz,Draw81b

ld b,5
halt
djnz $-1

ld b,80
ld c,179

Draw80a:
  dec c
  call ClearPixel
  ld a,c
  cp 151
  jr nz,Draw80a

ld c,137

Draw80b:
  dec c
  call ClearPixel
  ld a,c
  cp 124
  jr nz,Draw80b

ld b,5
halt
djnz $-1

ld b,79
ld c,179

Draw79a:
  dec c
  call ClearPixel
  ld a,c
  cp 151
  jr nz,Draw79a

ld c,137

Draw79b:
  dec c
  call ClearPixel
  ld a,c
  cp 124
  jr nz,Draw79b

ld b,5
halt
djnz $-1

ld b,78
ld c,180

Draw78a:
  dec c
  call ClearPixel
  ld a,c
  cp 152
  jr nz,Draw78a

ld c,136

Draw78b:
  dec c
  call ClearPixel
  ld a,c
  cp 124
  jr nz,Draw78b

ld b,5
halt
djnz $-1

ld b,77
ld c,180

Draw77a:
  dec c
  call ClearPixel
  ld a,c
  cp 154
  jr nz,Draw77a

ld c,135

Draw77b:
  dec c
  call ClearPixel
  ld a,c
  cp 124
  jr nz,Draw77b

ld b,6
halt
djnz $-1

ld b,76
ld c,180

Draw76a:
  dec c
  call ClearPixel
  ld a,c
  cp 156
  jr nz,Draw76a

ld c,134

Draw76b:
  dec c
  call ClearPixel
  ld a,c
  cp 125
  jr nz,Draw76b

ld b,7
halt
djnz $-1

ld b,75
ld c,180

Draw75a:
  dec c
  call ClearPixel
  ld a,c
  cp 158
  jr nz,Draw75a

ld c,133

Draw75b:
  dec c
  call ClearPixel
  ld a,c
  cp 125
  jr nz,Draw75b

ld b,8
halt
djnz $-1

ld b,74
ld c,180

Draw74a:
  dec c
  call ClearPixel
  ld a,c
  cp 160
  jr nz,Draw74a

ld c,131

Draw74b:
  dec c
  call ClearPixel
  ld a,c
  cp 126
  jr nz,Draw74b

ld b,9
halt
djnz $-1

ld b,73
ld c,180

Draw73a:
  dec c
  call ClearPixel
  ld a,c
  cp 162
  jr nz,Draw73a

ld c,129

Draw73b:
  dec c
  call ClearPixel
  ld a,c
  cp 126
  jr nz,Draw73b

ld b,1
halt
djnz $-1

ld b,86
ld c,144

Draw86c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw86c

ld b,1
halt
djnz $-1

ld b,85
ld c,144

Draw85c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw85c

ld b,1
halt
djnz $-1

ld b,84
ld c,144

Draw84c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw84c

ld b,1
halt
djnz $-1

ld b,83
ld c,144

Draw83c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw83c

ld b,1
halt
djnz $-1

ld b,82
ld c,144

Draw82c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw82c

ld b,1
halt
djnz $-1

ld b,81
ld c,144

Draw81c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw81c

ld b,1
halt
djnz $-1

ld b,80
ld c,144

Draw80c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw80c

ld b,1
halt
djnz $-1

ld b,79
ld c,144

Draw79c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw79c

ld b,1
halt
djnz $-1

ld b,78
ld c,144

Draw78c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw78c

ld b,1
halt
djnz $-1

ld b,77
ld c,144

Draw77c
  dec c
  call ClearPixel
  ld a,c
  cp 141
  jr nz,Draw77c

ld b,1
halt
djnz $-1

ld b,76
ld c,143

Draw76c
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw76c

ld b,1
halt
djnz $-1

ld b,75
ld c,143

Draw75c
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw75c

ld b,1
halt
djnz $-1

ld b,74
ld c,143

Draw74c
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw74c

ld b,1
halt
djnz $-1

ld b,73
ld c,143

Draw73c
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw73c

ld b,1
halt
djnz $-1

ld b,72
ld c,143

Draw72:
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw72

ld b,1
halt
djnz $-1

ld b,71
ld c,143

Draw71:
  dec c
  call ClearPixel
  ld a,c
  cp 140
  jr nz,Draw71

ld b,1
halt
djnz $-1

ld b,70
ld c,142

Draw70:
  dec c
  call ClearPixel
  ld a,c
  cp 139
  jr nz,Draw70

ld b,1
halt
djnz $-1

ld b,69
ld c,142

Draw69:
  dec c
  call ClearPixel
  ld a,c
  cp 139
  jr nz,Draw69

ld b,1
halt
djnz $-1

ld b,68
ld c,142

Draw68:
  dec c
  call ClearPixel
  ld a,c
  cp 139
  jr nz,Draw68

ld b,1
halt
djnz $-1

ld b,67
ld c,142

Draw67:
  dec c
  call ClearPixel
  ld a,c
  cp 139
  jr nz,Draw67

ld b,1
halt
djnz $-1

ld b,66
ld c,142

Draw66:
  dec c
  call ClearPixel
  ld a,c
  cp 139
  jr nz,Draw66

ld b,1
halt
djnz $-1

ld b,65
ld c,141

Draw65:
  dec c
  call ClearPixel
  ld a,c
  cp 138
  jr nz,Draw65

ld b,1
halt
djnz $-1

ld b,64
ld c,141

Draw64:
  dec c
  call ClearPixel
  ld a,c
  cp 138
  jr nz,Draw64

ld b,3
halt
djnz $-1

ld b,63
ld c,142

Draw63:
  dec c
  call ClearPixel
  ld a,c
  cp 137
  jr nz,Draw63

ld b,6
halt
djnz $-1

ld b,62
ld c,144

Draw62:
  dec c
  call ClearPixel
  ld a,c
  cp 135
  jr nz,Draw62

ld b,9
halt
djnz $-1

ld b,61
ld c,146

Draw61:
  dec c
  call ClearPixel
  ld a,c
  cp 133
  jr nz,Draw61

ld b,9
halt
djnz $-1

ld b,60
ld c,147

Draw60:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw60

ld b,9
halt
djnz $-1

ld b,59
ld c,147

Draw59:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw59

ld b,9
halt
djnz $-1

ld b,58
ld c,147

Draw58:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw58

ld b,9
halt
djnz $-1

ld b,57
ld c,147

Draw57:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw57

ld b,9
halt
djnz $-1

ld b,56
ld c,147

Draw56:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw56

ld b,9
halt
djnz $-1

ld b,55
ld c,147

Draw55:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw55

ld b,9
halt
djnz $-1

ld b,54
ld c,147

Draw54:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw54

ld b,9
halt
djnz $-1

ld b,53
ld c,147

Draw53:
  dec c
  call ClearPixel
  ld a,c
  cp 132
  jr nz,Draw53

ld b,9
halt
djnz $-1

ld b,52

ld c,146
call ClearPixel
ld c,145
call ClearPixel
ld c,144
call ClearPixel
ld c,143
call ClearPixel
ld c,141
call ClearPixel
ld c,140
call ClearPixel
ld c,139
call ClearPixel
ld c,138
call ClearPixel
ld c,137
call ClearPixel
ld c,135
call ClearPixel
ld c,134
call ClearPixel
ld c,133
call ClearPixel
ld c,132
call ClearPixel

ld b,9
halt
djnz $-1

ld b,51

ld c,146
call ClearPixel
ld c,145
call ClearPixel
ld c,144
call ClearPixel
ld c,140
call ClearPixel
ld c,139
call ClearPixel
ld c,138
call ClearPixel
ld c,134
call ClearPixel
ld c,133
call ClearPixel
ld c,132
call ClearPixel

ld b,9
halt
djnz $-1

ld b,50

ld c,146
call ClearPixel
ld c,145
call ClearPixel
ld c,139
call ClearPixel
ld c,133
call ClearPixel
ld c,132
call ClearPixel

ld b,25
halt
djnz $-1

; flower colour red

ld b,6
ld c,16
call FindColor
ld (hl),%00011100
ld b,6
ld c,17
call FindColor
ld (hl),%00011100
ld b,6
ld c,18
call FindColor
ld (hl),%00011100
ld b,7
ld c,16
call FindColor
ld (hl),%00011100
ld b,7
ld c,17
call FindColor
ld (hl),%00011100
ld b,7
ld c,18
call FindColor
ld (hl),%00011100

ld b,25
halt
djnz $-1

; flower colour red

ld b,6
ld c,16
call FindColor
ld (hl),%00001100
ld b,6
ld c,17
call FindColor
ld (hl),%00001100
ld b,6
ld c,18
call FindColor
ld (hl),%00001100
ld b,7
ld c,16
call FindColor
ld (hl),%00001100
ld b,7
ld c,17
call FindColor
ld (hl),%00001100
ld b,7
ld c,18
call FindColor
ld (hl),%00001100

ld b,25
halt
djnz $-1

; flower colour red

ld b,6
ld c,16
call FindColor
ld (hl),%00101100
ld b,6
ld c,17
call FindColor
ld (hl),%00101100
ld b,6
ld c,18
call FindColor
ld (hl),%00101100
ld b,7
ld c,16
call FindColor
ld (hl),%00101100
ld b,7
ld c,17
call FindColor
ld (hl),%00101100
ld b,7
ld c,18
call FindColor
ld (hl),%00101100

ld b,25
halt
djnz $-1

; flower colour red

ld b,6
ld c,16
call FindColor
ld (hl),%00110100
ld b,6
ld c,17
call FindColor
ld (hl),%00110100
ld b,6
ld c,18
call FindColor
ld (hl),%00110100
ld b,7
ld c,16
call FindColor
ld (hl),%00110100
ld b,7
ld c,17
call FindColor
ld (hl),%00110100
ld b,7
ld c,18
call FindColor
ld (hl),%00110100

ld b,25
halt
djnz $-1

; flower colour red

ld b,6
ld c,16
call FindColor
ld (hl),%00010100
ld b,6
ld c,17
call FindColor
ld (hl),%00010100
ld b,6
ld c,18
call FindColor
ld (hl),%00010100
ld b,7
ld c,16
call FindColor
ld (hl),%00010100
ld b,7
ld c,17
call FindColor
ld (hl),%00010100
ld b,7
ld c,18
call FindColor
ld (hl),%00010100

ld b,150
halt
djnz $-1

; flower colour away

ld b,6
ld c,16
call FindColor
ld (hl),%00000100
ld b,6
ld c,17
call FindColor
ld (hl),%00000100
ld b,6
ld c,18
call FindColor
ld (hl),%00000100
ld b,7
ld c,16
call FindColor
ld (hl),%00000100
ld b,7
ld c,17
call FindColor
ld (hl),%00000100
ld b,7
ld c,18
call FindColor
ld (hl),%00000100
