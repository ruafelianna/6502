; shows horizontal lines

; screen area start
define screenLB $00
define screenHB $02
; screen area edge
define screenMaxHB $06
; screen width
define screenWidth $20

; current screen position
define curAddrLB $00
define curAddrHB $01

; current color address
define curColor $02

; max color
define maxColor $10

; init screen start address
LDX #screenLB
STX curAddrLB
LDX #screenHB
STX curAddrHB

; init counter
LDY #$00

; init first color and save it
LDA #$00
STA curColor

loop:
; load color from memory and draw a pixel
LDA curColor
STA (curAddrLB),Y
; increment counter
INY
; check if the line is finished
CPY #screenWidth
BNE loop
; line is finished, increment the color and save it
CLC
ADC #$01
STA curColor
; check if color > max
CMP maxColor
BNE next
; color is max, reset it and save
LDA #$00
STA curColor
next:
; reset line counter
LDY #$00
; update position LB
LDA curAddrLB
CLC
ADC #screenWidth
STA curAddrLB
; check for overflow
CMP #$00
BNE loop
; increment position HB
INX
STX curAddrHB
; check if we got to the edge
CPX #screenMaxHB
BNE loop
