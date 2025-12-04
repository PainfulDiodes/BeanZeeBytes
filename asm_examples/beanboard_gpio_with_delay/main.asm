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

    ld a,40
    call mylongdelay
    
    in a,(GPIO_IN)
    ; echo to console
    call putchar
    ; repeat
    jp loop
    
end:
    ; add a line break
    ld a,'\n'
    ; to the console
    call putchar
    ; jump to the reset address - will jump back to the monitor
    jp WARMSTART


mylongdelay: 
    push bc
    ld b,a
_mylongdelayloop: 
    call mydelay
    djnz _mylongdelayloop
    pop bc
ret
mydelay:
    push bc
    ld b,0xff
_mydelayloop:
    nop
    djnz _mydelayloop
    pop bc
    ret

start_message: 
    db "Console to GPO\nGPI to console\n'Esc' to quit\n",0
