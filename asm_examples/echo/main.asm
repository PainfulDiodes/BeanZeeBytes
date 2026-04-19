include "marvin.inc"

    ORG ORGDEF

start:
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
    call MARVIN_PUTCHAR
    ; repeat
    jr loop

end:
    ld a, '\n'
    call MARVIN_PUTCHAR
    jp MARVIN_WARMSTART

start_message:
    db "Echoing from console input to console output. 'Esc' to quit\n",0
