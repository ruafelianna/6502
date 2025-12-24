; screen height
define height $20
; screen width
define width $20

; pixel color
define color $01

; screen start memory address
define p_screenStartLB $00
define p_screenStartHB $02

; set position args
define p_posX $00
define p_posY $01
; set position result
define p_posRetLB $02
define p_posRetHB $03

; multiplication args
define p_mulArg1 $04
define p_mulArg2 $05
; multipllication result
define p_mulRetLB $06
define p_mulRetHB $07

JSR drawDiagonal
JMP quit

; ---------------
; draw a diagonal
; ---------------
drawDiagonal:
; init start coord (0, 0)
LDX #$00
drawDiagonal_loop:
; check if coord is max
CPX #width
BEQ drawDiagonal_ret
; calculate pixel position
STX p_posX
STX p_posY
TXA
PHA
JSR setPos
PLA
TAX
; draw a pixel
LDA #color
LDY #$00
STA (p_posRetLB),Y
; coords++
INX
JMP drawDiagonal_loop
drawDiagonal_ret:
RTS

; --------------
; multiplication
; --------------
mul:
; reset accumulator
LDA #$00
; reset carry
LDY #$00
; load arg2 (x times)
LDX p_mulArg2
mul_loop:
; while x > 0
CPX #$00
BEQ mul_ret
; x--
DEX
; acc += arg1
CLC
ADC p_mulArg1
; check for carry
BCC mul_loop
INY
JMP mul_loop
mul_ret:
; set result
STA p_mulRetLB
STY p_mulRetHB
RTS

; -----------------------------------------------
; translate cartesian coords into memory position
; p = p0 + x + w * y
; -----------------------------------------------
setPos:
; init pos LB with p0 LB
LDA #p_screenStartLB
; init pos HB with p0 HB
LDX #p_screenStartHB
; add x coord
CLC
ADC p_posX
; check for carry
BCC setPos_addY
INX
setPos_addY:
; mul w * y
LDY #width
STY p_mulArg1
LDY p_posY
STY p_mulArg2
PHA
TXA
PHA
JSR mul
PLA
TAX
PLA
; add w * y LB
CLC
ADC p_mulRetLB
; check for carry
BCC setPos_addY_HB
INX
setPos_addY_HB:
; add w * y HB
PHA
TXA
CLC
ADC p_mulRetHB
TAX
PLA
setPos_ret:
; set result
STA p_posRetLB
STX p_posRetHB
RTS

quit:
