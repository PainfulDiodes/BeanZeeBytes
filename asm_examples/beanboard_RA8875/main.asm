start:
    call ra8875_reset

    call ra8875_reg_0_check
    jp nz,error_0

    call dump_registers

    call ra8875_pllc1_init
    call ra8875_reg_0_check
    jp nz,error_0

    call ra8875_pllc2_init
    call ra8875_reg_0_check
    jp nz,error_0

    call ra8875_sysr_init

    call ra8875_pcsr_init
    call ra8875_reg_0_check
    jp nz,error_0

    call ra8875_horizontal_settings_init

    call ra8875_vertical_settings_init

    call ra8875_horizontal_active_window_init
    call ra8875_vertical_active_window_init

    call dump_registers

    call ra8875_clear_window

    call dump_registers

    ; call ra8875_display_on

    jp done

error_0:
    ld hl,ra8875_controller_error_message
    call puts

done:
    jp WARMSTART

start_message:
    db "RA8875 test\nHit any key to continue...\n",0
ra8875_controller_error_message:
    db "\nRA8875 error: did not get 0x75 from reg 0\n",0


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