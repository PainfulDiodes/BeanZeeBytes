test_fill_screen_fast           = $8085 ; addr, local, , beanboard, , main.asm:93


PUBLIC ra8875_test
PUBLIC _ra8875_test

ra8875_test:
_ra8875_test:
    call test_fill_screen_fast
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
