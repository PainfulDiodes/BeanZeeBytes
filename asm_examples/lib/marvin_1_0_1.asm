; Marvin 1.0.1 definitions

; memory map
RAMSTART equ $8000
RAMTOP equ   $efff

; jp addresses
RESET equ $0000

; subroutines to call
getchar equ $0006       ; get a character from the console and return in A
putchar equ $000f       ; send character in A to the console 
puts equ    $001c       ; print a zero-terminated string pointed to by HL to the console
