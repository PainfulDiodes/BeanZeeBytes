ra8875_setup                    = $8032 ; addr, local, , beanboard, , main.asm:30
ra8875_cursor_x                 = $8330 ; addr, local, , beanboard, , RA8875.asm:472
ra8875_cursor_y                 = $8347 ; addr, local, , beanboard, , RA8875.asm:488
ra8875_putchar                  = $8366 ; addr, local, , beanboard, , RA8875.asm:511

PUBLIC tft_setup
PUBLIC _tft_setup

tft_setup:
_tft_setup:
    call ra8875_setup
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
