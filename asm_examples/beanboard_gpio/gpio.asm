; load definitions
; BeanZee board
include "../lib/beanzee.inc"
; monitor program
include "../lib/marvin_1.1.beta.inc"

; this is the default location for a BeanZee standalone assembly program 
org RAMSTART

start:
    ld hl,start_message         ; load the message address into HL
	call puts
loop:
    call getchar                ; get a character from USB - will wait for a character
    cp '\e'                     ; escape?
    jp z,end                    ; yes - end
    call putchar                ; echo to console
    out (GPIO),a
    in a,(GPIO)
    call putchar                ; echo to console
    jr loop                     ; repeat
    
end:
    ld a,'\n'                   ; add a line break
    call putchar                ; to the console
    jp RESET                    ; jump to the reset address - will jump back to the monitor

start_message: 
    db "Console to GPO\nGPI to console\n'Esc' to quit\n",0
