; Marvin 1.0.2-> definitions

; monitor subroutines to call

getchar equ $0010       ; get a character from the console and return in A
putchar equ $0020       ; send character in A to the console 
puts equ    $0040       ; print a zero-terminated string pointed to by HL to the console


; c stdio overrides

PUBLIC fputc_cons_native
PUBLIC _fputc_cons_native

PUBLIC fgetc_cons
PUBLIC _fgetc_cons

fputc_cons_native:
_fputc_cons_native:
    pop     bc      ;return address
    pop     hl      ;character to print in l
    push    hl
    push    bc
    ld      a,l
    call    putchar ;marvin putchar
    ret

fgetc_cons:
_fgetc_cons:
    call    getchar ;marvin getchar
    ld      l,a     ;Return the result in hl
    ld      h,0
    ret
