start:
    ; reset needs to be held for a short time, hence getchar before moving on
    ; in reality we may want a delay
    call ra8875_setstate_reset
    ld hl,message
    call puts
    call getchar
    call ra8875_setstate_inactive

    call ra8875_setstate_active
    ld a,RA8875_CMDWRITE
    call ra8875_write
    ; send 0x00 (register number)
    ld a,0x00
    call ra8875_write
    call ra8875_setstate_inactive

    call ra8875_setstate_active
    ld a,RA8875_DATAREAD
    call ra8875_write
    call ra8875_read
    push af
    call ra8875_setstate_inactive
    pop af

    call putchar_hex

    cp 0x75
    jp nz,error_0

    ; do some more stuff

    ld hl,success_message
    call puts
    jp done

error_0:
    ld hl,error_message_0
    call puts

done:
    jp WARMSTART

message:
    db "RA8875 test\nHit any key to continue...\n",0
error_message_0:
    db "\nRA8875 init fail\n",0

success_message:
    db "\nRA8875 success\n",0