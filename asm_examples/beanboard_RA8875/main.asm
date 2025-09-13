
start:
    ; Initialize SPI interface
    call spi_init
    ld hl,message
    call puts
send_loop:
    call getchar
    cp '\e'
    jp z,done
    call putchar
    ld b,a
    call spi_select
    ld a,b
    call spi_write
    call spi_deselect
    jr send_loop
done:
    ld a,'\n'
    call putchar
    jp WARMSTART

message:
    db "Echo to console and SPI\n",0
