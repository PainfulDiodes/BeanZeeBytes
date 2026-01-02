ra8875_cursor_x                 = $8336 ; addr, local, , beanboard, , RA8875.asm:472
ra8875_cursor_y                 = $834D ; addr, local, , beanboard, , RA8875.asm:488
ra8875_putchar                  = $836C ; addr, local, , beanboard, , RA8875.asm:511
ra8875_setup                    = $8032 ; addr, local, , beanboard, , main.asm:30
ra8875_test_print_char          = $8047 ; addr, local, , beanboard, , main.asm:43

PUBLIC tft_setup
PUBLIC _tft_setup

tft_setup:
_tft_setup:
    call ra8875_setup
    ret

PUBLIC tft_cursor_x
PUBLIC _tft_cursor_x

tft_cursor_x:
_tft_cursor_x:
    pop     bc      ; return address
    pop     hl      ; arg
    push    hl
    push    bc
    call ra8875_cursor_x ; expects hl to have x position
    ret

PUBLIC tft_cursor_y
PUBLIC _tft_cursor_y

tft_cursor_y:
_tft_cursor_y:
    pop     bc      ; return address
    pop     hl      ; arg
    push    hl
    push    bc
    call ra8875_cursor_y ; expects hl to have y position
    ret

PUBLIC tft_putchar
PUBLIC _tft_putchar

tft_putchar:
_tft_putchar:
    pop     bc      ; return address
    pop     hl      ; arg
    push    hl
    push    bc
    call ra8875_test_print_char
    ld a,5
    call ra8875_putchar
    ret


; PUBLIC marvin_gpio_in
; PUBLIC _marvin_gpio_in

; marvin_gpio_in:
; _marvin_gpio_in:
;     in a,(GPIO_IN)
;     ld h,0
;     ld l, a
;     ret

; PUBLIC marvin_gpio_out
; PUBLIC _marvin_gpio_out

; marvin_gpio_out:
; _marvin_gpio_out:
;     pop     bc      ; return address
;     pop     hl      ; arg
;     push    hl
;     push    bc
;     ld      a,l
;     out (GPIO_OUT),a
;     ret
