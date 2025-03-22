include "../lib/marvin.asm"     ; load all the definitions needed to interact with the monitor program

KBD_PORT equ 2

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
    ld hl,message               ; load the message address into HL
print:
	call lcd_puts
wait:
    call getchar
	ld a,LCD_SET_CLEAR
	call lcd_putcmd

keyscan:
    ld a,0xff
    out (KBD_PORT),a
    in a,(KBD_PORT)
    and 0x0F                ; clear top 4 bits
    add '0'
    call lcd_putchar

    call readchar           ; repeat until receive input from USB
    cp 0
    jr z,keyscan

end:
	ld a,LCD_SET_CLEAR
	call lcd_putcmd
    jp RESET                    ; jump to the reset address - will jump back to the monitor

message: 
    db "Hello world!",0     ; message to be printed, terminated by a 0


lcd_putcmd:                 ; transmit character in A
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

lcd_putchar:                ; transmit character in A
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
