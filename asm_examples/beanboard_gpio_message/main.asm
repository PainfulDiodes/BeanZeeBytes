start:
    ld hl,start_message
	call puts
    ld hl,gpio_message
loop:
    ld a,(hl)
    or a
    jr z,end
    out (GPIO_OUT),a
    inc hl
    jr loop
end:
    ; jump to the reset address - will jump back to the monitor
    jp WARMSTART

start_message: 
    db "String to GPO\n",0
gpio_message: 
    db "0123456789",0
