ra8875_adafruit_tft_enable      = $82B8 ; addr, local, , beanboard, , RA8875.asm:368
ra8875_backlight_init           = $82C4 ; addr, local, , beanboard, , RA8875.asm:379
ra8875_clear_window             = $8299 ; addr, local, , beanboard, , RA8875.asm:342
ra8875_controller_error         = $806A ; addr, local, , beanboard, , main.asm:60
ra8875_controller_error_message = $810A ; addr, local, , beanboard, , main.asm:169
ra8875_cursor_blink             = $832A ; addr, local, , beanboard, , RA8875.asm:447
ra8875_cursor_x                 = $8353 ; addr, local, , beanboard, , RA8875.asm:472
ra8875_cursor_y                 = $836A ; addr, local, , beanboard, , RA8875.asm:488
ra8875_deselect                 = $814E ; addr, local, , beanboard, , RA8875.asm:94
ra8875_display_on               = $82AC ; addr, local, , beanboard, , RA8875.asm:357
ra8875_horizontal_active_window_init = $8257 ; addr, local, , beanboard, , RA8875.asm:304
ra8875_horizontal_settings_init = $81F9 ; addr, local, , beanboard, , RA8875.asm:254
ra8875_initialise               = $82D7 ; addr, local, , beanboard, , RA8875.asm:396
ra8875_memory_read_write_command = $8381 ; addr, local, , beanboard, , RA8875.asm:503
ra8875_pcsr_init                = $81EA ; addr, local, , beanboard, , RA8875.asm:243
ra8875_pllc1_init               = $81C0 ; addr, local, , beanboard, , RA8875.asm:211
ra8875_pllc2_init               = $81CF ; addr, local, , beanboard, , RA8875.asm:222
ra8875_putchar                  = $8389 ; addr, local, , beanboard, , RA8875.asm:511
ra8875_puts                     = $8398 ; addr, local, , beanboard, , RA8875.asm:525
ra8875_read_data                = $8196 ; addr, local, , beanboard, , RA8875.asm:167
ra8875_read_reg                 = $81A7 ; addr, local, , beanboard, , RA8875.asm:183
ra8875_reg_0_check              = $81B8 ; addr, local, , beanboard, , RA8875.asm:205
ra8875_reset                    = $8155 ; addr, local, , beanboard, , RA8875.asm:101
ra8875_reset_delay              = $8127 ; addr, local, , beanboard, , RA8875.asm:29
ra8875_select                   = $8147 ; addr, local, , beanboard, , RA8875.asm:87
ra8875_setup                    = $8038 ; addr, local, , beanboard, , main.asm:32
ra8875_sysr_init                = $81DE ; addr, local, , beanboard, , RA8875.asm:233
ra8875_test_print_char          = $8064 ; addr, local, , beanboard, , main.asm:56
ra8875_text_mode                = $830D ; addr, local, , beanboard, , RA8875.asm:428
ra8875_vertical_active_window_init = $8278 ; addr, local, , beanboard, , RA8875.asm:323
ra8875_vertical_settings_init   = $8221 ; addr, local, , beanboard, , RA8875.asm:276
ra8875_write_command            = $816C ; addr, local, , beanboard, , RA8875.asm:135
ra8875_write_data               = $8181 ; addr, local, , beanboard, , RA8875.asm:151
ra8875_write_reg                = $81AE ; addr, local, , beanboard, , RA8875.asm:190

test_cursor_positioning         = $80D2 ; addr, local, , beanboard, , main.asm:137
test_fill_screen                = $80A8 ; addr, local, , beanboard, , main.asm:109
test_fill_screen_fast           = $80BD ; addr, local, , beanboard, , main.asm:123
test_message                    = $8119 ; addr, local, , beanboard, , main.asm:172
test_print_all_chars            = $808B ; addr, local, , beanboard, , main.asm:86
test_print_all_chars_fast       = $8098 ; addr, local, , beanboard, , main.asm:97

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
    ld a,l
    call ra8875_test_print_char ;ra8875_putchar
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
