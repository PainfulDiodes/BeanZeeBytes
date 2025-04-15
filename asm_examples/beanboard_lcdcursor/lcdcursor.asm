; load definitions
include "../lib/beanzee.def"    ; BeanZee board
include "../lib/marvin.def"     ; monitor program
include "../lib/HD44780LCD.def" ; LCD

; LCD_SET_DDRAM_ADDR options
LCD_LINE_0_ADDR equ 0x00
LCD_LINE_1_ADDR equ 0x40
LCD_LINE_2_ADDR equ 0x00+0x14
LCD_LINE_3_ADDR equ 0x40+0x14

org RAMSTART                    ; this is the default location for a BeanZee standalone assembly program 

start:
	ld a,LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8
	call lcd_putcmd
	ld a,LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON
	call lcd_putcmd
	ld a,LCD_CLEAR_DISPLAY
	call lcd_putcmd

    ld hl,message
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_1_ADDR+2
	call lcd_putcmd

    ld hl,message
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_2_ADDR+4
	call lcd_putcmd

    ld hl,message
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_3_ADDR+6
	call lcd_putcmd

    ld hl,message
    call lcd_puts

    jp RESET                    ; jump to the reset address - will jump back to the monitor

message: 
    db "Hello, world!",0

include "../lib/HD44780LCD.asm" ; load all the LCD subroutines
