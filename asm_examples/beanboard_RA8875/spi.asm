; RA8875 SPI
; Pin definitions for SPI on GPIO port

; GPO
; Serial Clock
SPI_SCK        equ 0
; Master Out Slave In
SPI_MOSI       equ 1
; RA8875 RESET - active LOW
RA8875_RESET   equ 2
; Chip Select - active LOW
SPI_CS         equ 3

; GPI
; WAIT
RA8875_WAIT    equ 0
; Master In Slave Out
SPI_MISO       equ 1

; Initialize SPI
; Sets up GPIO pins for SPI operation
; Destroys: AF
spi_init:
    ; Set initial pin states (CS high, CLK low, MOSI low)
    ld a,1 << SPI_CS
    out (GPIO_OUT),a
    ret

; Select SPI device (CS low)
; Destroys: AF
spi_select:
    ; CS low
    ld a,0
    out (GPIO_OUT),a
    ret

; Deselect SPI device (CS high)
; Destroys: AF
spi_deselect:
    ; CS high
    ld a,1 << SPI_CS
    out (GPIO_OUT),a
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
    and ~(1 << SPI_SCK)
    out (GPIO_OUT),a
    ld a,d
    djnz spi_write_bit
    ret
