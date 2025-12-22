; shows all available colors in a row

define maxColors $10
define screenStart $0200

LDY #$00

loop:
TYA
STA screenStart,Y
INY
CPY #maxColors
BNE loop
