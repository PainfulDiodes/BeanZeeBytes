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
    ; CS bit set, others clear
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

; Write and read a byte over SPI
; Input: A = byte to send
; Output: A = byte received
; Destroys: BC
spi_transfer:
    ; Initialize bit counter
    ld b,8
    ; Save input byte
    ld c,a
_spi_transfer_bit_loop:
    ; Put MSB on MOSI
    ; Rotate left through carry
    rlc c
    ; Start with all pins low
    ld a,0
    jr nc,_spi_transfer_output_bit
    ; Set MOSI if carry was set
    or 1 << SPI_MOSI
_spi_transfer_output_bit:
    ; Output MOSI
    out (GPIO_OUT),a

    ; Generate clock pulse (rising edge)
    ; Set clock high
    or 1 << SPI_SCK
    out (GPIO_OUT),a
    
    ; Read MISO
    ; Read GPIO input
    in a,(GPIO_IN)
    ; Isolate MISO bit
    and 1 << SPI_MISO
    jr z,_spi_transfer_miso_low
    ; Set carry if MISO was high
    scf
    jr _spi_transfer_store_bit
_spi_transfer_miso_low:
    ; Set carry
    scf
    ; Complement carry to clear it
    ccf
_spi_transfer_store_bit:
    ; Store received bit
    rr c

    ; Generate clock pulse (falling edge)
    ; Clear clock 
    and ~(1 << SPI_SCK)
    out (GPIO_OUT),a

    ; Next bit
    ; Decrement counter and loop if not zero
    djnz _spi_transfer_bit_loop
    
    ; Return received byte in A
    ld a,c
    ret

; Write a byte over SPI (no read)
; Input: A = byte to send
; Destroys: AF, BC
spi_write:
    call spi_transfer
    ret

; Read a byte over SPI (sending 0xFF)
; Output: A = byte received
; Destroys: AF, BC
spi_read:
    ; Send all 1's while reading
    ld a,0xFF
    call spi_transfer
    ret
