include "../lib/marvin.asm"     ; load all the definitions needed to interact with the monitor program

LCD_CTRL equ 4                  ; LCD control port
LCD_DATA equ 5                  ; LCD data port

; LCD commands
LCD_CLEAR_DISPLAY equ 0x01
LCD_RETURN_HOME equ 0x02
LCD_ENTRY_MODE_SET equ 0x04
LCD_DISPLAY_ON_OFF_CONTROL equ 0x08
LCD_CURSOR_DISPLAY_SHIFT equ 0x10
LCD_FUNCTION_SET equ 0x20
LCD_SET_CGRAM_ADDR equ 0x40
LCD_SET_DDRAM_ADDR equ 0x80

; LCD_ENTRY_MODE_SET options
LCD_ENTRY_INC equ 0x02 ; left
LCD_ENTRY_DEC equ 0x00 ; right
LCD_ENTRY_SHIFT equ 0x01
LCD_ENTRY_NO_SHIFT equ 0x00

; LCD_DISPLAY_ON_OFF_CONTROL options
LCD_DISPLAY_ON equ 0x04
LCD_DISPLAY_OFF equ 0x00
LCD_CURSOR_ON equ 0x02
LCD_CURSOR_OFF equ 0x00
LCD_BLINK_ON equ 0x01
LCD_BLINK_OFF equ 0x00

; LCD_CURSOR_DISPLAY_SHIFT options
LCD_SHIFT_DISPLAY equ 0x08
LCD_SHIFT_CURSOR equ 0x00
LCD_SHIFT_RIGHT equ 0x04
LCD_SHIFT_LEFT equ 0x00

; LCD_FUNCTION_SET options
LCD_DATA_LEN_8 equ 0x10
LCD_DATA_LEN_4 equ 0x00
LCD_DISP_LINES_2 equ 0x08
LCD_DISP_LINES_1 equ 0x00
LCD_FONT_10 equ 0x04
LCD_FONT_8 equ 0x00


org RAMSTART                    ; this is the default location for a BeanZee standalone assembly program 

start:
	ld a,LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8
	call lcd_putcmd
	ld a,LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON
	call lcd_putcmd
	ld a,LCD_CLEAR_DISPLAY
	call lcd_putcmd
    ld hl,start_message         ; load the message address into HL
	call puts
loop:
    call getchar                ; get a character from USB - will wait for a character
    cp '\e'                     ; escape?
    jp z,end                    ; yes - end
    call putchar                ; echo to console
    call lcd_putchar            ; echo to LCD
    jr loop                     ; repeat
    
end:
    ld a,'\n'                   ; add a line break
    call putchar                ; to the console
    jp RESET                    ; jump to the reset address - will jump back to the monitor

start_message: 
    db "Echoing console input to console and LCD - hit 'Esc' to quit\n",0


lcd_putcmd:                     ; transmit character in A to the control port
    push bc
    ld b,a                      ; save the transmit character
lcd_putcmd_loop: 
    in a,(LCD_CTRL)             ; get the LCD status
    bit 7,a                     ; ready ? (active low)
    jr nz,lcd_putcmd_loop       ; no
    ld a,b                      ; yes, restore the transmit character
    out (LCD_CTRL),a            ; transmit the character
    pop bc
    ret

lcd_putchar:                    ; transmit character in A to the data port
    push bc
    ld b,a                      ; save the transmit character
lcd_putchar_loop: 
    in a,(LCD_CTRL)             ; get the LCD status
    bit 7,a                     ; ready ? (active low)
    jr nz,lcd_putchar_loop      ; no
    ld a,b                      ; yes, restore the transmit character
    out (LCD_DATA),a            ; transmit the character
    pop bc
    ret

lcd_puts:                       ; print a zero-terminated string, pointed to by hl
    push hl
lcd_puts_loop:
    ld a,(hl)                   ; get character from string
    cp 0                        ; is it zero?
    jr z, lcd_puts_end          ; yes - return
    call lcd_putchar            ; no - send character
    inc hl                      ; next character position
    jp lcd_puts_loop            ; loop for next character
lcd_puts_end:
    pop hl
    ret
