start:
    call ra8875_setstate_reset
    ld hl,message
    call puts
    call getchar
    call ra8875_setstate_init

    call ra8875_setstate_selected
    ld a,RA8875_CMDWRITE
    call ra8875_write
    ; send 0x00 (register number)
    ld a,0x00
    call ra8875_write
    call ra8875_setstate_deselected

    call ra8875_setstate_selected
    ld a,RA8875_DATAREAD
    call ra8875_write
    call ra8875_read
    push af
    call ra8875_setstate_deselected
    pop af

    cp 0x75
    jp nz,error_0

    ; do some more stuff

    ld hl,success_message
    call puts
    jp done

error_0:
    ld hl,error_message_0
    call puts
    call putchar_hex
    ld a,'\n'
    call putchar

done:
    jp WARMSTART

message:
    db "RA8875 test\nHit any key to continue...\n",0
error_message_0:
    db "RA8875 init fail ",0

success_message:
    db "RA8875 success \n",0