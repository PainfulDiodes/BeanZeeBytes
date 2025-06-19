include "../lib/beanzee.inc"
include "../lib/marvin.inc"

org RAMSTART

start:
    ld hl,start_message
	call marvin_puts
loop:
    ; get a character from USB - will wait for a character
    call marvin_getchar
    ; escape?
    cp '\e'
    ; yes - end
    jp z,end
    ; echo to console
    call marvin_putchar
    out (GPIO),a
    in a,(GPIO)
    ; echo to console
    call marvin_putchar
    ; repeat
    jr loop
    
end:
    ; add a line break
    ld a,'\n'
    ; to the console
    call marvin_putchar
    ; jump to the reset address - will jump back to the monitor
    jp RESET

start_message: 
    db "Console to GPO\nGPI to console\n'Esc' to quit\n",0
