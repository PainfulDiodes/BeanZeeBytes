IFNDEF _PORTS_INC
DEFINE _PORTS_INC

; BeanBoard port assignments
; Hardware constants - consistent across all Bean family targets

; USB (UM245R)
UM245R_CTRL                 EQU 0x00
UM245R_DATA                 EQU 0x01

; Keyboard matrix
KEYSCAN_OUT                 EQU 0x02
KEYSCAN_IN                  EQU 0x03

; LCD (HD44780)
LCD_CTRL                    EQU 0x04
LCD_DATA                    EQU 0x05

; GPIO
GPIO_OUT                    EQU 0x06
GPIO_IN                     EQU 0x07

ENDIF ; _PORTS_INC
