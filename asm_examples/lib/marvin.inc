; Marvin 1.1 definitions

SYSRAM equ 0xf000

; jp

; cold start
RESET equ 0x0000
; warm start
START equ 0x0090
PROMPT equ 0x00A0

; call

; wait for a character from the console and return in A
getchar equ 0x0010
; read a character from the console and return it, or 0 if there is no character
readchar equ 0x0020
; sent character in A to the console 
putchar equ 0x0030
; convert value in A into an ASCII pair and send to console
putchar_hex equ 0x01F0
; print a zero-terminated string pointed to by hl to the console
puts equ 0x0040
; convert an ASCII hex char in A to a number value (lower 4 bits)
hex_val equ 0x01D0
; read 2 ASCII hex chars from memory by HL pointer, return converted value in A and advance HL pointer
hex_byte_val equ 0x01A0
; transmit character in A to the LCD control port
lcd_putcmd equ 0x0240
; transmit character in A to the LCD data port
lcd_putchar equ 0x0260
