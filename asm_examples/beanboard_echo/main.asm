start:
	ld a,LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8
	call lcd_putcmd
	ld a,LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON
	call lcd_putcmd
	ld a,LCD_CLEAR_DISPLAY
	call lcd_putcmd
    ld a,0
    call lcd_putchar
    ; load the message address into HL
    ld hl,start_message         
	call puts
loop:
    ; get a character from the console - will wait for a character
    call getchar
    ; escape?
    cp '\e'
    ; yes - end
    jp z,end
    ; no - echo to LCD
    call lcd_putchar
    ; repeat
    jr loop
    
end:
    call lcd_init
    jp WARMSTART

start_message: 
    db "Echoing from console\nto the LCD\n'Esc' to quit\n",0
