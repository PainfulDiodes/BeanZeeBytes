; MARVIN stdio overrides

PUBLIC fputc_cons_native
PUBLIC _fputc_cons_native

fputc_cons_native:
_fputc_cons_native:
    pop     bc      ;return address
    pop     hl      ;character to print in l
    push    hl
    push    bc
    ld      a,l
    call    putchar
    ret

PUBLIC fgetc_cons
PUBLIC _fgetc_cons

fgetc_cons:
_fgetc_cons:
    call    getchar
    ;Return the result in hl
    ld      l,a
    ld      h,0
    ret


; additional MARVIN functions 

PUBLIC marvin_readchar
PUBLIC _marvin_readchar

; get a character from the console without waiting 
marvin_readchar:
_marvin_readchar:
    call readchar
    ; return the result in hl
    ld h,0                  
    ld l,a
    ret 

PUBLIC marvin_gpio_in
PUBLIC _marvin_gpio_in

marvin_gpio_in:
_marvin_gpio_in:
    in a,(GPIO_IN)
    ld h,0
    ld l, a
    ret

PUBLIC marvin_gpio_out
PUBLIC _marvin_gpio_out

marvin_gpio_out:
_marvin_gpio_out:
    pop     bc      ; return address
    pop     hl      ; arg
    push    hl
    push    bc
    ld      a,l
    out (GPIO_OUT),a
    ret

PUBLIC marvin_keyscan_in
PUBLIC _marvin_keyscan_in

marvin_keyscan_in:
_marvin_keyscan_in:
    in a,(KEYSCAN_IN)
    ld h,0
    ld l, a
    ret

PUBLIC marvin_keyscan_out
PUBLIC _marvin_keyscan_out

marvin_keyscan_out:
_marvin_keyscan_out:
    pop     bc      ; return address
    pop     hl      ; arg
    push    hl
    push    bc
    ld      a,l
    out(KEYSCAN_OUT),a
    ret
