include "../lib/beanzee.inc"
include "../lib/marvin.inc"
include "../lib/HD44780LCD.inc"

org RAMSTART

; LCD_SET_DDRAM_ADDR options
LCD_LINE_0_ADDR equ 0x00
LCD_LINE_1_ADDR equ 0x40
LCD_LINE_2_ADDR equ 0x00+0x14
LCD_LINE_3_ADDR equ 0x40+0x14

start:
    ld hl,INSTRUCTIONS_MSG
    call marvin_puts

	ld a,LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8
	call marvin_lcd_putcmd
	ld a,LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON
	call marvin_lcd_putcmd
	ld a,LCD_CLEAR_DISPLAY
	call marvin_lcd_putcmd

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_0_ADDR+0
	call marvin_lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_1_ADDR+2
	call marvin_lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_2_ADDR+4
	call marvin_lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_3_ADDR+6
	call marvin_lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ; wait
    call marvin_getchar

    jp RESET


; subroutines

lcd_puts:
    ; get message character
    ld a,(hl)
    ; is it zero?
    cp 0
    ; yes
    ret z
    ; no - send character
    call marvin_lcd_putchar
    ; next character position
    inc hl
    ; loop for next character
    jr lcd_puts

; messages

MESSAGE: 
    db "Hello, world!",0

INSTRUCTIONS_MSG:
    db "Press any key to exit",0
