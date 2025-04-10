include "../lib/marvin.asm"     ; load all the definitions needed to interact with the monitor program

KBD_PORT equ 2                  ; 2 or 3 work

LCD_CTRL equ 4                  ; LCD control port
LCD_DATA equ 5                  ; LCD data port

LCD_SET_8BIT_2LINE equ $3f
LCD_SET_CURSOR_ON equ $0f
LCD_SET_CLEAR equ $01

org RAMSTART                    ; this is the default location for a BeanZee standalone assembly program 

start:
	ld a,LCD_SET_8BIT_2LINE
	call lcd_putcmd
	ld a,LCD_SET_CURSOR_ON
	call lcd_putcmd
	ld a,LCD_SET_CLEAR
	call lcd_putcmd
    ld hl,lcd_message               ; load the message address into HL
print:
	call lcd_puts
wait:
    ld hl,console_message_1
    call puts 
    call getchar
    ld hl,console_message_2
    call puts 
	ld a,LCD_SET_CLEAR
	call lcd_putcmd

keyscanstart:
    ld b,0x01               ; current column bit
    ld hl,key_buffer        ; location of previous value
keyscanloop:
    ld a,b
    call keyscan
    cp 0
    jr z,keyscannext           ; yes - skip echo
    add '0'
    call lcd_putchar
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
	ld a,LCD_SET_CLEAR
	call lcd_putcmd
    jp RESET                    ; jump to the reset address - will jump back to the monitor

lcd_message: 
    db "Echo",0                 ; message to be printed, terminated by a 0
console_message_1: 
    db "Hit a key to start BeanBoard echo\n",0
console_message_2: 
    db "Hit any key to stop BeanBoard echo\n",0


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

lcd_putcmd:                 ; transmit character in A to the control port
    push bc
    ld b,a                  ; save the transmit character
lcd_putcmd_loop: 
    in a,(LCD_CTRL)         ; get the LCD status
    bit 7,a                 ; ready ? (active low)
    jr nz,lcd_putcmd_loop   ; no
    ld a,b                  ; yes, restore the transmit character
    out (LCD_CTRL),a        ; transmit the character
    pop bc
    ret

lcd_putchar:                ; transmit character in A to the data port
    push bc
    ld b,a                  ; save the transmit character
lcd_putchar_loop: 
    in a,(LCD_CTRL)         ; get the LCD status
    bit 7,a                 ; ready ? (active low)
    jr nz,lcd_putchar_loop  ; no
    ld a,b                  ; yes, restore the transmit character
    out (LCD_DATA),a        ; transmit the character
    pop bc
    ret

lcd_puts:                       ; print a zero-terminated string, pointed to by hl
    push hl
lcd_puts_loop:
    ld a,(hl)               ; get character from string
    cp 0                    ; is it zero?
    jr z, lcd_puts_end      ; yes - return
    call lcd_putchar        ; no - send character
    inc hl                  ; next character position
    jp lcd_puts_loop        ; loop for next character
lcd_puts_end:
    pop hl
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
