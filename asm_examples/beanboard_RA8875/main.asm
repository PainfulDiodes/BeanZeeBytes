start:

    call ra8875_initialise
    jp nz,ra8875_controller_error

    call ra8875_text_mode
    ld a,RA8875_CURSOR_BLINK_RATE
    call ra8875_cursor_blink

    call dump_registers

    call print_all_chars

    call getchar

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

    call getchar

fill_screen:
    ld hl,0
    call ra8875_cursor_x
    call ra8875_cursor_y
    ld b,12
fill_screen_loop:
    call print_all_chars
    djnz fill_screen_loop

    call getchar

    call ra8875_clear_window

    call getchar
fill_screen_fast:
    ld hl,0
    call ra8875_cursor_x
    call ra8875_cursor_y
    ld b,12
fill_screen_fast_loop:
    call print_all_chars_fast
    djnz fill_screen_fast_loop

    jp WARMSTART

ra8875_controller_error:
    ld hl,ra8875_controller_error_message
    call puts
    jp WARMSTART

dump_registers:
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
    ret

print_all_chars:
    ld a,0
_print_all_chars_loop:
    call ra8875_putchar
    inc a
    cp 0
    ret z
    jr _print_all_chars_loop

print_all_chars_fast:
    call ra8875_memory_read_write_command
    ld a,0
_print_all_chars_fast_loop:
    call ra8875_write_data
    inc a
    cp 0
    ret z
    jr _print_all_chars_fast_loop

ra8875_controller_error_message:
    db "\nRA8875 error\n",0

test_message:
    db "Hello, world!",0
