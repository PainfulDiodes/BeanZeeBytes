include "marvin.inc"

    ORG ORGDEF

start:
    call MARVIN_LCD_INIT
    ; print instructions to console
    ld hl,start_message
    call MARVIN_PUTS
loop:
    ; get a character from the console - will wait for a character
    call MARVIN_GETCHAR
    ; escape?
    cp '\e'
    ; yes - end
    jp z,end
    ; no - echo to LCD
    call MARVIN_LCD_PUTCHAR
    ; repeat
    jr loop

end:
    call MARVIN_LCD_INIT
    jp MARVIN_WARMSTART

start_message:
    db "Echoing from console\nto the LCD\n'Esc' to quit\n",0
