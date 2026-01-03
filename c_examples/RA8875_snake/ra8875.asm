ra8875_adafruit_tft_enable      = $829B ; addr, local, , beanboard, , RA8875.asm:368
ra8875_backlight_init           = $82A7 ; addr, local, , beanboard, , RA8875.asm:379
ra8875_clear_window             = $827C ; addr, local, , beanboard, , RA8875.asm:342
ra8875_controller_error         = $804D ; addr, local, , beanboard, , main.asm:47
ra8875_controller_error_message = $80ED ; addr, local, , beanboard, , main.asm:156
ra8875_cursor_blink             = $830D ; addr, local, , beanboard, , RA8875.asm:447
ra8875_cursor_x                 = $8336 ; addr, local, , beanboard, , RA8875.asm:472
ra8875_cursor_y                 = $834D ; addr, local, , beanboard, , RA8875.asm:488
ra8875_deselect                 = $8131 ; addr, local, , beanboard, , RA8875.asm:94
ra8875_display_on               = $828F ; addr, local, , beanboard, , RA8875.asm:357
ra8875_horizontal_active_window_init = $823A ; addr, local, , beanboard, , RA8875.asm:304
ra8875_horizontal_settings_init = $81DC ; addr, local, , beanboard, , RA8875.asm:254
ra8875_initialise               = $82BA ; addr, local, , beanboard, , RA8875.asm:396
ra8875_memory_read_write_command = $8364 ; addr, local, , beanboard, , RA8875.asm:503
ra8875_pcsr_init                = $81CD ; addr, local, , beanboard, , RA8875.asm:243
ra8875_pllc1_init               = $81A3 ; addr, local, , beanboard, , RA8875.asm:211
ra8875_pllc2_init               = $81B2 ; addr, local, , beanboard, , RA8875.asm:222
ra8875_putchar                  = $836C ; addr, local, , beanboard, , RA8875.asm:511
ra8875_puts                     = $837B ; addr, local, , beanboard, , RA8875.asm:525
ra8875_read_data                = $8179 ; addr, local, , beanboard, , RA8875.asm:167
ra8875_read_reg                 = $818A ; addr, local, , beanboard, , RA8875.asm:183
ra8875_reg_0_check              = $819B ; addr, local, , beanboard, , RA8875.asm:205
ra8875_reset                    = $8138 ; addr, local, , beanboard, , RA8875.asm:101
ra8875_reset_delay              = $810A ; addr, local, , beanboard, , RA8875.asm:29
ra8875_select                   = $812A ; addr, local, , beanboard, , RA8875.asm:87
ra8875_setup                    = $8032 ; addr, local, , beanboard, , main.asm:30
ra8875_sysr_init                = $81C1 ; addr, local, , beanboard, , RA8875.asm:233
ra8875_test_print_char          = $8047 ; addr, local, , beanboard, , main.asm:43
ra8875_text_mode                = $82F0 ; addr, local, , beanboard, , RA8875.asm:428
ra8875_vertical_active_window_init = $825B ; addr, local, , beanboard, , RA8875.asm:323
ra8875_vertical_settings_init   = $8204 ; addr, local, , beanboard, , RA8875.asm:276
ra8875_write_command            = $814F ; addr, local, , beanboard, , RA8875.asm:135
ra8875_write_data               = $8164 ; addr, local, , beanboard, , RA8875.asm:151
ra8875_write_reg                = $8191 ; addr, local, , beanboard, , RA8875.asm:190

test_cursor_positioning         = $80B5 ; addr, local, , beanboard, , main.asm:124
test_fill_screen                = $808B ; addr, local, , beanboard, , main.asm:96
test_fill_screen_fast           = $80A0 ; addr, local, , beanboard, , main.asm:110
test_message                    = $80FC ; addr, local, , beanboard, , main.asm:159
test_print_all_chars            = $806E ; addr, local, , beanboard, , main.asm:73
test_print_all_chars_fast       = $807B ; addr, local, , beanboard, , main.asm:84

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
