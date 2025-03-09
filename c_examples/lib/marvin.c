// Marvin 1.0.2->

#include <stdio.h>

// override low-level console functions as per:
// https://github.com/z88dk/z88dk/wiki/Classic--Homebrew
// these bubble up to higher level functions: putchar(), printf() etc.

int fputc_cons_native(char c) __naked
{
__asm
    pop     bc    ;return address
    pop     hl    ;character to print in l
    push    hl
    push    bc
    ld      a,l
    call    $0020 ; marvin putchar
    ret
__endasm;
} 

int fgetc_cons() __naked
{
__asm
    call    $0010   ; marvin getchar
    ld      l,a     ;Return the result in hl
    ld      h,0
    ret
__endasm;
}