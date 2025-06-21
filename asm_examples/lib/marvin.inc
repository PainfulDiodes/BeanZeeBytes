; Marvin 1.1.1 WIP definitions

SYSRAM equ 0xf000

; jp

; cold start
RESET equ 0x0000
; warm start
MARVIN_START equ 0x00D0
MARVIN_PROMPT equ 0x00E0

; call

; wait for a character from the console and return in A
marvin_getchar equ 0x0010
; read a character from the console and return it in A, or 0 if there is no character
marvin_readchar equ 0x0020
; sent character in A to the console 
marvin_putchar equ 0x0040
; convert value in A into an ASCII pair and send to console
marvin_putchar_hex equ 0x0230
; print a zero-terminated string pointed to by hl to the console
marvin_puts equ 0x0060
; convert an ASCII hex char in A to a number value (lower 4 bits)
marvin_hex_val equ 0x0210
; read 2 ASCII hex chars from memory by HL pointer, return converted value in A and advance HL pointer
marvin_hex_byte_val equ 0x01E0
; transmit character in A to the LCD control port
marvin_lcd_putcmd equ 0x0280
; transmit character in A to the LCD data port
marvin_lcd_putchar equ 0x02A0
