; shows vertical lines

; screen area start
define screenLB $00
define screenHB $02
; screen area edge
define screenMaxHB $06

; current screen position
define curAddrLB $00
define curAddrHB $01

; max color
define maxColor $10

; init screen start address
LDX #screenLB
STX curAddrLB
LDX #screenHB
STX curAddrHB

; init counter
LDY #$00

; init first color
LDA #$00

loop:
; set current pixel
STA (curAddrLB),Y
; increment color
CLC
ADC #$01
; check if the color reached max value
CMP #maxColor
BNE next
; reset color
LDA #$00
next:
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
