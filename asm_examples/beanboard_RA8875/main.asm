start:
    ; reset needs to be held for a short time, hence getchar before moving on
    ; in reality we may want a delay - or the RESET is tied to the Z80 RESET
    call ra8875_start_reset
    ld hl,start_message
    call puts
    call getchar
    call ra8875_end_reset

    ld a,0x00 ; register number
    call ra8875_read_reg

    call putchar_hex

    cp 0x75 ; TODO: replace magic number
    jp nz,error_0

    ld hl,init_success_message
    call puts

    jp done

error_0:
    ld hl,init_error_message
    call puts

done:
    jp WARMSTART

start_message:
    db "RA8875 test\nHit any key to continue...\n",0
init_error_message:
    db "\nRA8875 init fail - expected 0x75\n",0

init_success_message:
    db "\nRA8875 init success\n",0