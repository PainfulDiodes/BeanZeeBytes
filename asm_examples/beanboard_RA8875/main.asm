start:
    call ra8875_set_reset_state
    ld hl,message
    call puts
    call getchar
    call ra8875_set_init_state

    ; set CS low
    call ra8875_set_selected_state
    ; send RA8875_CMDWRITE (0x80)
    ld a,RA8875_CMDWRITE
    call ra8875_write
    ; send 0x00 (register number)
    ld a,0x00
    call ra8875_write
    ; end SPI
    ; set CS high
    call ra8875_set_deselected_state

    ; set CS low
    call ra8875_set_selected_state
    ; send RA8875_DATAREAD (0x40)
    ld a,RA8875_DATAREAD
    call ra8875_write
    ; receive value (sending 0x00)
    call ra8875_read
    ; preserve returned value
    push af
    ; set CS high
    call ra8875_set_deselected_state

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