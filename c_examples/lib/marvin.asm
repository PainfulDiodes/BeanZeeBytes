; Marvin 1.0.2-> definitions
; additional subroutine: readchar


; monitor subroutines to call

getchar equ 0x0010       ; get a character from the console and return in A
putchar equ 0x0020       ; send character in A to the console 
puts equ    0x0040       ; print a zero-terminated string pointed to by HL to the console


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



; additional Marvin functions 

;NONE


; additional asm functions 

; readchar
; get a character from the UM245R console without waiting 
; if there is no data, return 0
; NOTE this needs to be moved into MARVIN

UM245R_CTRL equ 0          ; serial control port
UM245R_DATA equ 1          ; serial data port

PUBLIC readchar
PUBLIC _readchar

readchar:
_readchar:
    in a,(UM245R_CTRL)      ; get the USB status
    bit 1,a                 ; data to read? (active low)
    jr nz,readcharnodata    ; no, the buffer is empty
    in a,(UM245R_DATA)      ; yes, read the received char
    ld h,0                  ; return the result in hl
    ld l,a
    ret 
readcharnodata:
    ld hl,0
    ret
