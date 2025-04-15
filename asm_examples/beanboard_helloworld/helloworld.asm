; load definitions
include "../lib/beanzee.def"    ; BeanZee board
include "../lib/marvin.def"     ; monitor program
include "../lib/HD44780LCD.def" ; LCD

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
    jp RESET                    ; jump to the reset address - will jump back to the monitor

message: 
    db "Hello, world!",0

include "../lib/HD44780LCD.asm" ; load all the LCD subroutines
