start:
    call gpio_echo
    ; call ra8875_test;

end:
    jp PROMPT

ra8875_test:
    ld a,0x00 ; register number
    call ra8875_read_reg
    call putchar_hex
    ld a,'\n'
    call putchar
    ret

gpio_echo:
    ; get a character from USB - will wait for a character
    call getchar
    ; escape?
    cp '\e'
    ; yes - end
    ret z
    ; echo to console
    call putchar
    out (GPIO_OUT),a

    ; call ra8875_long_delay    
    ; in a,(GPIO_IN)
    ; echo to console
    ; call putchar

    ; repeat
    jr gpio_echo

ra8875_controller_error:
    ld hl,ra8875_controller_error_message
    call puts
    jp WARMSTART

; diagnostic functions

dump_registers:
    push af
    push bc
    ld b,0x00
    ld c,0x00
_dump_registers_loop:
    ld a,c ; register number
    call ra8875_read_reg
    call putchar_hex
    inc c
    djnz _dump_registers_loop    
    ld a,'\n'
    call putchar
    pop bc
    pop af 
    ret

; test functions

test_print_all_chars:
    push af
    ld a,0
_print_all_chars_loop:
    call ra8875_putchar
    inc a
    cp 0
    jr nz,_print_all_chars_loop
    pop af
    ret

test_print_all_chars_fast:
    push af
    call ra8875_memory_read_write_command
    ld a,0
_test_print_all_chars_fast_loop:
    call ra8875_write_data
    inc a
    cp 0
    jr nz,_test_print_all_chars_fast_loop
    pop af
    ret

test_fill_screen:
    push hl
    push bc
    ld hl,0
    call ra8875_cursor_x
    call ra8875_cursor_y
    ld b,12
_test_fill_screen_loop:
    call test_print_all_chars
    djnz _test_fill_screen_loop
    pop bc
    pop hl
    ret

test_fill_screen_fast:
    push hl
    push bc
    ld hl,0
    call ra8875_cursor_x
    call ra8875_cursor_y
    ld b,12
_test_fill_screen_fast_loop:
    call test_print_all_chars_fast
    djnz _test_fill_screen_fast_loop
    pop bc
    pop hl
    ret

test_cursor_positioning:
    push af
    push hl

    ; bottom-right corner
    ld hl,800-8
    call ra8875_cursor_x
    ld hl,480-16
    call ra8875_cursor_y
    ld a,'X'
    call ra8875_putchar

    ld hl,10*8
    call ra8875_cursor_x
    ld hl,10*16
    call ra8875_cursor_y
    ld a,'X'
    call ra8875_putchar

    ld hl,10*8+4
    call ra8875_cursor_x
    ld hl,10*16
    call ra8875_cursor_y
    ld a,'X'
    call ra8875_putchar
    
    pop hl
    pop af
    ret

; strings

ra8875_controller_error_message:
    db "\nRA8875 error\n",0

test_message:
    db "Hello, world!",0
