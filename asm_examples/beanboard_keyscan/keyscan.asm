; load definitions
include "../lib/beanzee.inc"    ; BeanZee board
include "../lib/marvin.inc"     ; monitor program

org RAMSTART                    ; this is the default location for a BeanZee standalone assembly program 

start:
    ld hl,console_message_1
    call puts 
    call getchar
    ld hl,console_message_2
    call puts 

keyscanstart:
    ld b,0x01                   ; initial column bit - only 1 bit is ever set at a time - it is shifted from bit 0 to bit 7
    ld hl,key_buffer            ; location of previous values
keyscanloop:
    ld a,b                      ; get the current column bit
    call keyscan
    cp 0                        ; no value?
    jr z,keyscannext            ; yes - skip printing the value
    add 'a'-1                   ; offset the value to be an ASCII range starting with "a"
    call putchar                ; print the ASCII character
keyscannext:
    inc hl                      ; move the pointer of pervious values to the next column slot
    or a                        ; clear the carry flag
    rl b                        ; shift column bit left - when we've done all 8, it will move to the carry flag
    jr nc,keyscanloop           ; loop if not done all columns

delay:                          ; key debounce
    ld hl,0x0a00                ; set hl to the length of the delay
delayloop:                      
    dec hl                      ; count down the time
    nop                         ; wait a few cycles
    ld a,h                      ; copy the high part of the count down
    cp 0                        ; is it zero?
    jr nz,delayloop             ; no - loop again
    ld a,l                      ; yes - what about the low part of the value?
    cp 0                        ; is it zero?                        
    jr nz,delayloop             ; no - loop again
                                ; yes - continue

    call readchar               ; looking for input from USB
    cp 0                        ; is there any data?
    jr z,keyscanstart           ; no - loop again
                                ; yes - continue

end:
    ld a,'\n'
    call putchar                ; add a line break to the output
    jp RESET                    ; jump to the reset address - will drop back to the monitor


keyscan:                        ; A contains column bit, HL contains a pointer to the old value, return value in A
    push bc                     ; preserve bc
    out (KBD_PORT),a            ; output column strobe
    in a,(KBD_PORT)             ; get row values
    ld b,(hl)                   ; fetch previous valuefor comparison
    cp b                        ; is the value unchanged?
    jr z,keyscansame            ; yes - value hasn't changed
    ld (hl),a                   ; no - store the new value
    pop bc                      ; restore bc
    ret
keyscansame:                    ; when data hasn't changed
    ld a,0                      ; we will return 0
    pop bc                      ; restore bc
    ret


include "../lib/readchar.asm"

console_message_1: 
    db "Hit a key to start BeanBoard keyscan\n",0
console_message_2: 
    db "Hit any key to stop BeanBoard keyscan\n",0

; variables
key_buffer: 
    db 0,0,0,0,0,0,0,0
