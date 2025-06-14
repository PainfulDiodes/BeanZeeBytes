; Marvin 1.1 definitions

SYSRAM equ 0xf000

; jp
RESET equ 0x0000
START equ 0x0090

; call
getchar equ 0x0010
hex_byte_val equ 0x01A0
hex_val equ 0x01D0
keyscan equ 0x0340
keyscan_init equ 0x0330
lcd_getchar equ 0x0250
lcd_init equ 0x0220
lcd_putchar equ 0x0260
lcd_putcmd equ 0x0240
lcd_putdata equ 0x02C0
lcd_scroll equ 0x02E0
prompt equ 0x00A0
putcharequ 0x0030
putchar_hex equ 0x01F0
puts equ 0x0040
readchar equ 0x0020
usb_putchar equ 0x0070
usb_readchar equ 0x0050
