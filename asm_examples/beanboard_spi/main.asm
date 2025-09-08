
start:
    ; Initialize SPI interface
    call spi_init
    ; HL points to test string
    ld hl,test_string
send_loop:
    ld a,(hl)
    or a
    jr z,done
    ld b,a
    call spi_select
    ld a,b
    call spi_write
    call spi_deselect
    inc hl
    jr send_loop
done:
    jp WARMSTART

test_string:
    db 0b10101010,0
