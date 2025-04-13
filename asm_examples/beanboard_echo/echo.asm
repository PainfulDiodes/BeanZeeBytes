; load definitions
include "../def/beanzee.asm"    ; BeanZee board
include "../def/marvin.asm"     ; monitor program
include "../def/HD44780LCD.asm" ; LCD

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

include "../lib/HD44780LCD.asm" ; load all the LCD subroutines