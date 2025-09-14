start:
    call spi_reset
    ld hl,message
    call puts
    call getchar
    call spi_init


    ; set CS low
    call spi_select
    ; start SPI
    ; send RA8875_CMDWRITE (0x80)
    ld a,RA8875_CMDWRITE
    call spi_write
    ; send 0x00 (register number)
    ld a,0x00
    call spi_write
    ; end SPI
    ; set CS high
    call spi_deselect

    ; set CS low
    call spi_select
    ; start SPI
    ; send RA8875_DATAREAD (0x40)
    ld a,RA8875_DATAREAD
    call spi_write
    ; receive value (sending 0x00)
    call spi_read
    push af
    ; end SPI
    ; set CS high
    call spi_deselect

    pop af
    ; print returned value to console
    call putchar_hex

    ld a,'\n'
    call putchar

done:
    jp WARMSTART

message:
    db "RA8875 test\nHit any key to continue...\n",0
