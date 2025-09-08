; SPI controller library for BeanZeeBytes
; Pin definitions for SPI on GPIO port

; Serial Clock (output)
SPI_SCK     equ 0
; Master Out Slave In (output)
SPI_MOSI    equ 1
; Master In Slave Out (input)
SPI_MISO    equ 2
; Chip Select (output)
SPI_CS      equ 3

; Initialize SPI
; Sets up GPIO pins for SPI operation
; Destroys: AF
spi_init:
    ; Set initial pin states (CS high, CLK low, MOSI low)
    ld a,1 << SPI_CS
    out (GPIO_OUT),a
    call _spi_delay
    ret

; Select SPI device (CS low)
; Destroys: AF
spi_select:
    ; CS low
    ld a,0
    out (GPIO_OUT),a
    call _spi_delay
    ret

; Deselect SPI device (CS high)
; Destroys: AF
spi_deselect:
    ; CS high
    ld a,1 << SPI_CS
    out (GPIO_OUT),a
    call _spi_delay
    ret


; Write a byte over SPI (no readback)
; Input: A = byte to send
; Destroys: AF, B
spi_write:
    ld b,8
spi_write_bit:
    rlca
    ld d,a
    ld a,0
    jr nc,spi_write_mosi_low
    or 1 << SPI_MOSI
spi_write_mosi_low:
    out (GPIO_OUT),a
    or 1 << SPI_SCK
    out (GPIO_OUT),a
    call _spi_delay
    and ~(1 << SPI_SCK)
    out (GPIO_OUT),a
    call _spi_delay
    ld a,d
    djnz spi_write_bit
    ret
; Simple delay routine for SPI clock
; Uses E register, destroys E
SPI_DELAY_COUNT  EQU 200
_spi_delay:
    ld e,SPI_DELAY_COUNT
_spi_delay_loop:
    nop
    dec e
    jr nz,_spi_delay_loop
    ret
