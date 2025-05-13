; Marvin 1.1.beta definitions

SYSRAM equ 0xf000

; jp addresses
RESET equ 0x0000         ; cold start
START equ 0x0080         ; warm start

; subroutines to call
getchar equ 0x0010       ; get a character from the console and return in A
readchar equ $0020
putchar equ 0x0030       ; send character in A to the console 
putchar_hex equ $0278
puts equ    0x0040       ; print a zero-terminated string pointed to by HL to the console
usb_putchar equ $0060
usb_readchar equ $004F
lcd_getchar equ $02C3
lcd_init equ $029F
lcd_putchar equ $02CC
lcd_putcmd equ $02B6
lcd_putdata equ $0324
lcd_scroll equ $0335
