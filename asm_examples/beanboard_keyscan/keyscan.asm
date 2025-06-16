include "../lib/beanzee.inc"
include "../lib/marvin.inc"

org RAMSTART

start:
    ld hl,console_message_1
    call puts 
    call getchar
    ld hl,console_message_2
    call puts 

keyscanstart:
    ; initial column bit - only 1 bit is ever set at a time - it is shifted from bit 0 to bit 7
    ld b,0x01
    ; location of previous values
    ld hl,key_buffer
keyscanloop:
    ; get the current column bit
    ld a,b
    call keyscan
    ; no value?
    cp 0
    ; yes - skip printing the value
    jr z,keyscannext
    ; offset the value to be an ASCII range starting with "a"
    add 'a'-1
    ; print the ASCII character
    call putchar
keyscannext:
     ; move the pointer of pervious values to the next column slot
     inc hl
    ; clear the carry flag
    or a
    ; shift column bit left - when we've done all 8, it will move to the carry flag
    rl b
    ; loop if not done all columns
    jr nc,keyscanloop
    ; key debounce                         
delay: 
    ; set hl to the length of the delay
    ld hl,0x0a00                
delayloop:                      
    ; count down the time
    dec hl
    ; wait a few cycles
    nop                         
    ; copy the high part of the count down
    ld a,h
    ; is it zero?
    cp 0
    ; no - loop again
    jr nz,delayloop
    ; yes - what about the low part of the value?
    ld a,l
    ; is it zero?
    cp 0
    ; no - loop again
    jr nz,delayloop             
    ; yes - continue                                
    ; looking for input from USB
    call readchar
    ; is there any data?
    cp 0                        
    ; no - loop again
    jr z,keyscanstart
    ; yes - continue
end:
    ; add a line break to the output
    ld a,'\n'
    call putchar                
    ; jump to the reset address - will drop back to the monitor
    jp RESET

; A contains column bit, HL contains a pointer to the old value, return value in A
keyscan:
    ; preserve bc
    push bc
    ; output column strobe
    out (KBD_PORT),a
    ; get row values
    in a,(KBD_PORT)
    ; fetch previous value for comparison
    ld b,(hl)
    ; is the value unchanged?
    cp b
    ; yes - value hasn't changed
    jr z,keyscansame
    ; no - store the new value
    ld (hl),a
    ; restore bc
    pop bc
    ret
keyscansame:                    
    ; when data hasn't changed we will return 0
    ld a,0
    ; restore bc
    pop bc                      
    ret

console_message_1: 
    db "Hit a key to start BeanBoard keyscan\n",0
console_message_2: 
    db "Hit any key to stop BeanBoard keyscan\n",0

; variables
key_buffer: 
    db 0,0,0,0,0,0,0,0
