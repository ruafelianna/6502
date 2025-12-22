; show random pixels

; random value address
define randomColor $fe

; screen area start
define screenLB $00
define screenHB $02
; screen area edge
define screenMaxHB $06

; current screen position
define curAddrLB $00
define curAddrHB $01

; init screen start address
LDX #screenLB
STX curAddrLB
LDX #screenHB
STX curAddrHB

loop:
; set current pixel to a random color
LDA randomColor
STA (curAddrLB),Y
; increment position and check overflow
INY
CPY #$00
BNE loop
; position LB is 0, increment HB
INX
STX curAddrHB
; check if we got to the edge
CPX #screenMaxHB
BNE loop
