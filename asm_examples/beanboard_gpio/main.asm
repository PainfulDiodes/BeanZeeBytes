start:
    ld hl,start_message
	call puts
loop:
    ; get a character from USB - will wait for a character
    call getchar
    ; escape?
    cp '\e'
    ; yes - end
    jp z,end
    ; echo to console
    call putchar
    out (GPIO_OUT),a
    in a,(GPIO_IN)
    ; echo to console
    call putchar
    ; repeat
    jr loop
    
end:
    ; add a line break
    ld a,'\n'
    ; to the console
    call putchar
    ; jump to the reset address - will jump back to the monitor
    jp WARMSTART

start_message: 
    db "Console to GPO\nGPI to console\n'Esc' to quit\n",0
