; SPI controller library for BeanZeeBytes
; Pin definitions for SPI on GPIO port
SPI_SCK     equ 0       ; Serial Clock (output)
SPI_MOSI    equ 1       ; Master Out Slave In (output)
SPI_MISO    equ 2       ; Master In Slave Out (input)
SPI_CS      equ 3       ; Chip Select (output)

; Initialize SPI
; Sets up GPIO pins for SPI operation
; Destroys: AF
spi_init:
    ; Set initial pin states (CS high, CLK low, MOSI low)
    ld a, 1 << SPI_CS  ; CS bit set, others clear
    out (GPIO_OUT), a
    ret

; Select SPI device (CS low)
; Destroys: AF
spi_select:
    ld a,0             ; CS low
    out (GPIO_OUT),a
    ret

; Deselect SPI device (CS high)
; Destroys: AF
spi_deselect:
    ld a,1 << SPI_CS   ; CS high
    out (GPIO_OUT),a
    ret

; Write and read a byte over SPI
; Input: A = byte to send
; Output: A = byte received
; Destroys: BC
spi_transfer:
    ld b, 8            ; 8 bits to transfer
    ld c, a            ; Save byte to send
_spi_transfer_bit_loop:
    ; Put MSB on MOSI
    rlc c              ; Rotate left through carry
    ld a,0             ; Start with all pins low
    jr nc,_spi_transfer_mosi_low
    or 1 << SPI_MOSI   ; Set MOSI if carry was set
_spi_transfer_mosi_low:
    out (GPIO_OUT),a   ; Output MOSI

    ; Generate clock pulse (rising edge)
    or 1 << SPI_SCK    ; Set clock high
    out (GPIO_OUT),a
    
    ; Read MISO
    in a,(GPIO_IN)     ; Read GPIO input
    rlc a              ; Move MISO bit to carry
    rr c               ; Store received bit

    ; Generate clock pulse (falling edge)
    and ~(1 << SPI_SCK) ; Clear clock 
    out (GPIO_OUT), a

    ; Next bit
    djnz _spi_transfer_bit_loop  ; Decrement counter and loop if not zero
    
    ld a, c            ; Return received byte in A
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
    ld a, 0xFF         ; Send all 1's while reading
    call spi_transfer
    ret

; Variables
SPI_TEMP:  db 0         ; Temporary storage
