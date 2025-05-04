; Marvin 1.0.2 definitions

SYSRAM equ 0xf000

; jp addresses
RESET equ 0x0000         ; cold start
START equ 0x0050         ; warm start

; subroutines to call
getchar equ 0x0010       ; get a character from the console and return in A
putchar equ 0x0020       ; send character in A to the console 
putc equ    0x0030 
puts equ    0x0040       ; print a zero-terminated string pointed to by HL to the console
