ra8875_adafruit_tft_enable      = $82B0 ; addr, local, , beanboard, , RA8875.asm:376
ra8875_backlight_init           = $82BC ; addr, local, , beanboard, , RA8875.asm:387
ra8875_clear_window             = $8291 ; addr, local, , beanboard, , RA8875.asm:350
ra8875_controller_error         = $8050 ; addr, local, , beanboard, , main.asm:46
ra8875_controller_error_message = $80F0 ; addr, local, , beanboard, , main.asm:155
ra8875_cursor_blink             = $8322 ; addr, local, , beanboard, , RA8875.asm:455
ra8875_cursor_x                 = $834B ; addr, local, , beanboard, , RA8875.asm:480
ra8875_cursor_y                 = $8362 ; addr, local, , beanboard, , RA8875.asm:496
ra8875_delay                    = $810D ; addr, local, , beanboard, , RA8875.asm:30
ra8875_deselect                 = $8146 ; addr, local, , beanboard, , RA8875.asm:102
ra8875_display_on               = $82A4 ; addr, local, , beanboard, , RA8875.asm:365
ra8875_hardware_spi_end         = $8035 ; addr, local, , beanboard, , main.asm:29
ra8875_hardware_spi_start       = $8000 ; addr, local, , beanboard, , main.asm:1
ra8875_horizontal_active_window_init = $824F ; addr, local, , beanboard, , RA8875.asm:312
ra8875_horizontal_settings_init = $81F1 ; addr, local, , beanboard, , RA8875.asm:262
ra8875_initialise               = $82CF ; addr, local, , beanboard, , RA8875.asm:404
ra8875_long_delay               = $8135 ; addr, local, , beanboard, , RA8875.asm:81
ra8875_memory_read_write_command = $8379 ; addr, local, , beanboard, , RA8875.asm:511
ra8875_pcsr_init                = $81E2 ; addr, local, , beanboard, , RA8875.asm:251
ra8875_pllc1_init               = $81B8 ; addr, local, , beanboard, , RA8875.asm:219
ra8875_pllc2_init               = $81C7 ; addr, local, , beanboard, , RA8875.asm:230
ra8875_putchar                  = $8381 ; addr, local, , beanboard, , RA8875.asm:519
ra8875_puts                     = $8390 ; addr, local, , beanboard, , RA8875.asm:533
ra8875_read_data                = $818E ; addr, local, , beanboard, , RA8875.asm:175
ra8875_read_reg                 = $819F ; addr, local, , beanboard, , RA8875.asm:191
ra8875_reg_0_check              = $81B0 ; addr, local, , beanboard, , RA8875.asm:213
ra8875_reset                    = $814D ; addr, local, , beanboard, , RA8875.asm:109
ra8875_reset_delay              = $8115 ; addr, local, , beanboard, , RA8875.asm:37
ra8875_select                   = $813F ; addr, local, , beanboard, , RA8875.asm:95
ra8875_setup                    = $8038 ; addr, local, , beanboard, , main.asm:32
ra8875_sysr_init                = $81D6 ; addr, local, , beanboard, , RA8875.asm:241
ra8875_text_mode                = $8305 ; addr, local, , beanboard, , RA8875.asm:436
ra8875_vertical_active_window_init = $8270 ; addr, local, , beanboard, , RA8875.asm:331
ra8875_vertical_settings_init   = $8219 ; addr, local, , beanboard, , RA8875.asm:284
ra8875_write_command            = $8164 ; addr, local, , beanboard, , RA8875.asm:143
ra8875_write_data               = $8179 ; addr, local, , beanboard, , RA8875.asm:159
ra8875_write_reg                = $81A6 ; addr, local, , beanboard, , RA8875.asm:198
test_cursor_positioning         = $80B8 ; addr, local, , beanboard, , main.asm:123
test_fill_screen                = $808E ; addr, local, , beanboard, , main.asm:95
test_fill_screen_fast           = $80A3 ; addr, local, , beanboard, , main.asm:109
test_message                    = $80FF ; addr, local, , beanboard, , main.asm:158
test_print_all_chars            = $8071 ; addr, local, , beanboard, , main.asm:72
test_print_all_chars_fast       = $807E ; addr, local, , beanboard, , main.asm:83


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
