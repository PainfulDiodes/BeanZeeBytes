;include "../lib/beanzee.inc"
include "../lib/marvin.inc"
;include "../lib/HD44780LCD.inc"

org RAMSTART

start:
	ld a,LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8
	call lcd_putcmd
	ld a,LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON
	call lcd_putcmd
	ld a,LCD_CLEAR_DISPLAY
	call lcd_putcmd
    ld a,0
    call lcd_putchar
    ld hl,message
_loop:
    ld a,(hl)
    ; is it zero?
    cp 0
    ; yes
    jr z, end
    ; no - send character
    call lcd_putchar
    ; next character position
    inc hl
    ; loop for next character
    jr _loop
end:
    ; wait
    call getchar
    call lcd_init
    jp START

message: 
    db "Hello world!\n"     
    db "(hit any key)\n",0
