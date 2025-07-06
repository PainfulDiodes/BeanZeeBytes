include "beanboard.map"
include "marvin.asm"

PUBLIC marvin_lcd_putchar
PUBLIC _marvin_lcd_putchar

marvin_lcd_putchar:
_marvin_lcd_putchar:
    pop     bc      ;return address
    pop     hl      ;argument
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
    pop     hl      ;argument
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

PUBLIC marvin_lcd_puts
PUBLIC _marvin_lcd_puts

marvin_lcd_puts:
_marvin_lcd_puts:
    pop     bc      ;return address
    pop     hl      ;argument
    push    hl
    push    bc
    call    lcd_puts ;print a zero-terminated string pointed to by hl to the LCD
    ret