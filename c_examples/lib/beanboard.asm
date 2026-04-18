include "../../lib/ports.inc"
include "marvin.asm"

; MARVIN ABI addresses for LCD and keyboard
MARVIN_LCD_INIT     EQU 0x005B
MARVIN_LCD_PUTCHAR  EQU 0x005E
MARVIN_LCD_PUTS     EQU 0x0061
MARVIN_KEY_READCHAR EQU 0x0064

PUBLIC marvin_lcd_putchar
PUBLIC _marvin_lcd_putchar

marvin_lcd_putchar:
_marvin_lcd_putchar:
    pop     bc      ;return address
    pop     hl      ;argument
    push    hl
    push    bc
    ld      a,l
    call    MARVIN_LCD_PUTCHAR
    ret

PUBLIC marvin_lcd_init
PUBLIC _marvin_lcd_init

marvin_lcd_init:
_marvin_lcd_init:
    call    MARVIN_LCD_INIT
    ret

PUBLIC marvin_lcd_puts
PUBLIC _marvin_lcd_puts

marvin_lcd_puts:
_marvin_lcd_puts:
    pop     bc      ;return address
    pop     hl      ;argument
    push    hl
    push    bc
    call    MARVIN_LCD_PUTS
    ret

PUBLIC marvin_gpio_in
PUBLIC _marvin_gpio_in

marvin_gpio_in:
_marvin_gpio_in:
    in      a,(GPIO_IN)
    ld      h,0
    ld      l,a
    ret

PUBLIC marvin_gpio_out
PUBLIC _marvin_gpio_out

marvin_gpio_out:
_marvin_gpio_out:
    pop     bc      ; return address
    pop     hl      ; arg
    push    hl
    push    bc
    ld      a,l
    out     (GPIO_OUT),a
    ret

PUBLIC marvin_keyscan_in
PUBLIC _marvin_keyscan_in

marvin_keyscan_in:
_marvin_keyscan_in:
    in      a,(KEYSCAN_IN)
    ld      h,0
    ld      l,a
    ret

PUBLIC marvin_keyscan_out
PUBLIC _marvin_keyscan_out

marvin_keyscan_out:
_marvin_keyscan_out:
    pop     bc      ; return address
    pop     hl      ; arg
    push    hl
    push    bc
    ld      a,l
    out     (KEYSCAN_OUT),a
    ret
