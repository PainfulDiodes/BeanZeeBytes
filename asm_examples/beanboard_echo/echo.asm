include "../lib/beanzee.inc"
include "../lib/marvin.inc"
include "../lib/HD44780LCD.inc"

org RAMSTART

start:
	ld a,LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8
	call marvin_lcd_putcmd
	ld a,LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON
	call marvin_lcd_putcmd
	ld a,LCD_CLEAR_DISPLAY
	call marvin_lcd_putcmd
    ld a,0
    call marvin_lcd_putchar
    ; load the message address into HL
    ld hl,start_message         
	call marvin_puts
loop:
    ; get a character from the console - will wait for a character
    call marvin_getchar
    ; escape?
    cp '\e'
    ; yes - end
    jp z,end
    ; no - echo to LCD
    call marvin_lcd_putchar
    ; repeat
    jr loop
    
end:
    ld a,'\n'
    call marvin_lcd_putchar
    jp MARVIN_START

start_message: 
    db "Echoing console\ninput to the LCD\n'Esc' to quit\n",0
