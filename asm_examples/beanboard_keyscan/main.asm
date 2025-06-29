start:
    ld hl,CONSOLE_MESSAGE
    call puts 

keyscanstart:
    ; initial row bit - only 1 bit is ever set at a time - it is shifted iteratively from bit 0 to bit 7
    ld b,0b00000001
    ; location of previous values
    ld hl,KEY_BUFFER
keyscanloop:
    ; get the current row bit
    ld a,b
    call keyscan
    cp 0
    ; no value - skip printing the value
    jr z,keyscannext

    ; print the row and column as hex
    ; stash the column value in C
    ld c,a
    ; get the row value
    ld a,b
    ; print the row value
    call putchar_hex
    ; restore the column value
    ld a,c
    ; print the column value
    call putchar_hex
    ; add a newline
    ld a,'\n'
    call putchar

keyscannext:
    ; move the pointer of previous values to the next row slot
    inc hl
    ; clear the carry flag
    or a
    ; shift column bit left - when we've done all 8, the bit will move into the carry flag
    rl b
    ; loop if not done all columns (carry flag means we've already done all 8 bits)
    jr nc,keyscanloop
    ; key debounce                         
    call mydelay
    ; check if user wants to quit - looking for input from USB
    call readchar
    ; escape?
    cp '\e'
    ; no - loop again
    jr nz,keyscanstart
    ; yes - quit
end:
    ; add a line break to the output
    ld a,'\n'
    call putchar                
    ; jump to the reset address - will drop back to the monitor
    jp WARMSTART


; subroutines

; A contains column bit, HL contains a pointer to the old value, return value in A
keyscan:
    ; preserve bc
    push bc
    ; output column strobe
    out (KEYSCAN_OUT),a
    ; get row values
    in a,(KEYSCAN_IN)
    ; fetch previous value for comparison
    ld b,(hl)
    ; is the value unchanged?
    cp b
    ; yes - value hasn't changed
    jr z,_keyscansame
    ; no - store the new value
    ld (hl),a
    ; restore bc
    pop bc
    ret
_keyscansame:                    
    ; when data hasn't changed we will return 0
    ld a,0
    ; restore bc
    pop bc                      
    ret

; TODO - use the monitor delay ?

mydelay: 
    ; preserve hl
    push hl
    ; set hl to the length of the delay
    ld hl,0x0a00                
_mydelayloop:                      
    ; count down the time
    dec hl
    ; wait a few cycles
    nop                         
    ; copy the high part of the count down
    ld a,h
    ; is it zero?
    cp 0
    ; no - loop again
    jr nz,_mydelayloop
    ; yes - what about the low part of the value?
    ld a,l
    ; is it zero?
    cp 0
    ; no - loop again
    jr nz,_mydelayloop
    ; yes - return
    ; restore hl
    pop hl
    ret        


; messages

CONSOLE_MESSAGE: 
    db "Hit Esc to stop keyscan\n",0


; variables

KEY_BUFFER: 
    db 0,0,0,0,0,0,0,0
