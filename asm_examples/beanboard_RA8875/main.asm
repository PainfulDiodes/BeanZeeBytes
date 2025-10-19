start:

    call ra8875_initialise
    jp nz,ra8875_controller_error

    call ra8875_text_mode
    ld a,RA8875_CURSOR_BLINK_RATE
    call ra8875_cursor_blink

    call dump_registers

    call print_all_chars

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

ra8875_controller_error_message:
    db "\nRA8875 error\n",0

test_message:
    db "Hello, world!",0
