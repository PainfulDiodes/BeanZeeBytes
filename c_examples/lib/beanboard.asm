include "beanboard.map"
include "marvin.asm"

PUBLIC marvin_lcd_putchar
PUBLIC _marvin_lcd_putchar

marvin_lcd_putchar:
_marvin_lcd_putchar:
    pop     bc      ;return address
    pop     hl      ;character to print in l
    push    hl
    push    bc
    ld      a,l
    call    lcd_putchar
    ret

PUBLIC marvin_lcd_putcmd
PUBLIC _marvin_lcd_putcmd

marvin_lcd_putcmd:
_marvin_lcd_putcmd:
    pop     bc      ;return address
    pop     hl      ;character to print in l
    push    hl
    push    bc
    ld      a,l
    call    lcd_putcmd
    ret

PUBLIC marvin_lcd_init
PUBLIC _marvin_lcd_init

marvin_lcd_init:
_marvin_lcd_init:
    call lcd_init
    ret