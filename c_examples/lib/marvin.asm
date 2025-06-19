; Marvin 1.1 definitions

; wait for a character from the console and return in A
marvin_getchar equ 0x0010
; read a character from the console and return it in A, or 0 if there is no character
marvin_readchar equ 0x0020
; sent character in A to the console 
marvin_putchar equ 0x0030
; convert value in A into an ASCII pair and send to console
marvin_putchar_hex equ 0x01F0
; print a zero-terminated string pointed to by hl to the console
marvin_puts equ 0x0040
; convert an ASCII hex char in A to a number value (lower 4 bits)
marvin_hex_val equ 0x01D0
; read 2 ASCII hex chars from memory by HL pointer, return converted value in A and advance HL pointer
marvin_hex_byte_val equ 0x01A0
; transmit character in A to the LCD control port
marvin_lcd_putcmd equ 0x0240
; transmit character in A to the LCD data port
marvin_lcd_putchar equ 0x0260


; stdio overrides

PUBLIC fputc_cons_native
PUBLIC _fputc_cons_native

fputc_cons_native:
_fputc_cons_native:
    pop     bc      ;return address
    pop     hl      ;character to print in l
    push    hl
    push    bc
    ld      a,l
    call    marvin_putchar
    ret

PUBLIC fgetc_cons
PUBLIC _fgetc_cons

fgetc_cons:
_fgetc_cons:
    call    marvin_getchar
    ;Return the result in hl
    ld      l,a
    ld      h,0
    ret


; additional Marvin functions 

PUBLIC readchar
PUBLIC _readchar

; get a character from the UM245R console without waiting 
readchar:
_readchar:
    call marvin_readchar
    ; return the result in hl
    ld h,0                  
    ld l,a
    ret 
