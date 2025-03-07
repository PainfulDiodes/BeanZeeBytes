#include <stdio.h>

int fputc_cons_native(char c) __naked
{
__asm
    pop     bc  ;return address
    pop     hl  ;character to print in l
    push    hl
    push    bc
    ld      a,l
    call    $000f ; marvin putchar
    ret
__endasm;
} 

int fgetc_cons() __naked
{
__asm
    call    $0006 ; marvin getchar
    ld      l,a     ;Return the result in hl
    ld      h,0
    ret
__endasm;
}