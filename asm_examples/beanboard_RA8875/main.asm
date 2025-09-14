start:
    call ra8875_reset
    ld hl,message
    call puts
    call getchar
    call ra8875_init


    ; set CS low
    call ra8875_select
    ; start SPI
    ; send RA8875_CMDWRITE (0x80)
    ld a,RA8875_CMDWRITE
    call ra8875_write
    ; send 0x00 (register number)
    ld a,0x00
    call ra8875_write
    ; end SPI
    ; set CS high
    call ra8875_deselect

    ; set CS low
    call ra8875_select
    ; start SPI
    ; send RA8875_DATAREAD (0x40)
    ld a,RA8875_DATAREAD
    call ra8875_write
    ; receive value (sending 0x00)
    call ra8875_read
    push af
    ; end SPI
    ; set CS high
    call ra8875_deselect

    pop af
    ; print returned value to console
    call putchar_hex

    ld a,'\n'
    call putchar

done:
    jp WARMSTART

message:
    db "RA8875 test\nHit any key to continue...\n",0
