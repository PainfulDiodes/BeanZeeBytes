include "marvin.inc"
include "ports.inc"

    ORG ORGDEF

start:
    ld hl,start_message
    call MARVIN_PUTS
loop:
    ; get a character from USB - will wait for a character
    call MARVIN_GETCHAR
    ; escape?
    cp '\e'
    ; yes - end
    jp z,end
    ; echo to console
    call MARVIN_PUTCHAR
    out (GPIO_OUT),a
    in a,(GPIO_IN)
    ; echo to console
    call MARVIN_PUTCHAR
    ; repeat
    jr loop

end:
    ; add a line break
    ld a,'\n'
    ; to the console
    call MARVIN_PUTCHAR
    ; jump back to the monitor
    jp MARVIN_WARMSTART

start_message:
    db "Console to GPO\nGPI to console\n'Esc' to quit\n",0
