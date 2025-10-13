start:
    ; reset needs to be held for a short time, hence getchar before moving on
    ; in reality we may want a delay - or the RESET is tied to the Z80 RESET
    call ra8875_start_reset
    ld hl,start_message
    call puts
    call getchar
    call ra8875_end_reset

    ; check status
    ld a,0x00 ; register number
    call ra8875_read_reg
    cp RA8875_REG_0_VAL
    ; error: not expected value
    jp nz,error_0
    ld hl,init_success_message
    call puts

    call dump_registers

    call ra8875_pllc1_init
    call ra8875_wait

    call dump_registers

    call ra8875_pllc2_init
    call ra8875_wait

    call dump_registers

    call ra8875_display_on

    call dump_registers

    jp done

error_0:
    ld hl,init_error_message
    call puts

done:
    jp WARMSTART

start_message:
    db "RA8875 test\nHit any key to continue...\n",0
init_error_message:
    db "\nRA8875 init fail - expected status 0x75\n",0

init_success_message:
    db "\nRA8875 init success\n",0


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