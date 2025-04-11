include "../lib/marvin.asm"     ; load all the definitions needed to interact with the monitor program

KBD_PORT equ 2                  ; 2 or 3 work

org RAMSTART                    ; this is the default location for a BeanZee standalone assembly program 

start:
    ld hl,console_message_1
    call puts 
    call getchar
    ld hl,console_message_2
    call puts 

keyscanstart:
    ld b,0x01               ; current column bit
    ld hl,key_buffer        ; location of previous value
keyscanloop:
    ld a,b
    call keyscan
    cp 0
    jr z,keyscannext           ; yes - skip print
    add 'a'-1
    call putchar
keyscannext:
    inc hl
    or a                    ; clear carry
    rl b                    ; shift column bit left - will move to carry flag after bit 7
    jr nc,keyscanloop       ; loop if not done all bits

delay:
    ld hl,0x0a00
delayloop:               ; key debounce
    dec hl
    nop
    ld a,h
    cp 0
    jr nz,delayloop
    ld a,l
    cp a
    jr nz,delayloop

    call readchar           ; repeat until receive input from USB
    cp 0
    jr z,keyscanstart

end:
    jp RESET                    ; jump to the reset address - will jump back to the monitor

console_message_1: 
    db "Hit a key to start BeanBoard keyscan\n",0
console_message_2: 
    db "Hit any key to stop BeanBoard keyscan\n",0


keyscan:                    ; A contains column bit, HL contains a pointer to the old value, return value in A
    push bc
    out (KBD_PORT),a        ; output column strobe
    in a,(KBD_PORT)         ; get row values
    ld b,(hl)               ; fetch previous value
    cp b                    ; current value same as previous?
    jr z,keyscansame        ; yes - skip
    ld (hl),a               ; store new value
    pop bc
    ret
keyscansame:
    ld a,0
    pop bc
    ret


; readchar
; get a character from the UM245R console without waiting 
; if there is no data, return 0
; NOTE this needs to be moved into MARVIN

UM245R_CTRL equ 0          ; serial control port
UM245R_DATA equ 1          ; serial data port

readchar:
    in a,(UM245R_CTRL)      ; get the USB status
    bit 1,a                 ; data to read? (active low)
    jr nz,readcharnodata    ; no, the buffer is empty
    in a,(UM245R_DATA)      ; yes, read the received char
    ret 
readcharnodata:
    ld a,0
    ret


; RAM variables

key_buffer: 
    db 0,0,0,0,0,0,0,0
