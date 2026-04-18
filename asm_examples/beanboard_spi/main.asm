include "marvin.inc"
include "ports.inc"

    ORG ORGDEF

RA8875_DATAWRITE equ 0x00
RA8875_DATAREAD equ 0x40
RA8875_CMDWRITE equ 0x80
RA8875_CMDREAD equ 0xC0

start:
    call spi_reset
    ld hl,message
    call MARVIN_PUTS
    call MARVIN_GETCHAR
    call spi_init

send_loop:
    call MARVIN_GETCHAR
    cp '\e'
    jp z,done
    call MARVIN_PUTCHAR
    push af
    ld a, ' '
    call MARVIN_PUTCHAR
    call spi_select
    pop af
    call spi_write
    call spi_deselect
    call spi_select
    call spi_read
    call MARVIN_PUTCHAR_HEX
    call spi_deselect
    ld a,'\n'
    call MARVIN_PUTCHAR
    jr send_loop
done:
    jp MARVIN_WARMSTART

message:
    db "SPI test\nHit any key to continue...\n",0

include "spi.asm"
