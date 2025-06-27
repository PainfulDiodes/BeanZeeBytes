start:
    ld hl,INSTRUCTIONS_MSG
    call puts

	ld a,LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8
	call lcd_putcmd
	ld a,LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON
	call lcd_putcmd
	ld a,LCD_CLEAR_DISPLAY
	call lcd_putcmd

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_0_ADDR+0
	call lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_1_ADDR+2
	call lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_2_ADDR+4
	call lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ld a,LCD_SET_DDRAM_ADDR+LCD_LINE_3_ADDR+6
	call lcd_putcmd

    ld hl,MESSAGE
    call lcd_puts

    ; wait
    call getchar

	ld a,LCD_CLEAR_DISPLAY
	call lcd_putcmd
    ld a,0
    call lcd_putchar

    jp START

; messages

MESSAGE: 
    db "Hello, world!",0

INSTRUCTIONS_MSG:
    db "Press any key to exit",0
