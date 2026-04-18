include "marvin.inc"

    ORG ORGDEF

start:
    call MARVIN_LCD_INIT

; print message using MARVIN_LCD_PUTCHAR
    ld hl,message
_charloop:
    ld a,(hl)
    ; is it zero?
    cp 0
    ; yes
    jr z,_endloop
    ; no - send character
    call MARVIN_LCD_PUTCHAR
    ; next character position
    inc hl
    ; loop for next character
    jr _charloop
_endloop:

    ; wait
    call MARVIN_GETCHAR

; print message using MARVIN_LCD_PUTS
    ld hl,message2
    call MARVIN_LCD_PUTS

    ; wait
    call MARVIN_GETCHAR

; end
    call MARVIN_LCD_INIT
    jp MARVIN_WARMSTART

message:
    db "Hello world!\n"
    db "(hit any key)\n",0
message2:
    db "Another message!\n"
    db "(hit any key)\n",0
