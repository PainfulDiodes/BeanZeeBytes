RA8875_DATAWRITE equ 0x00
RA8875_DATAREAD equ 0x40
RA8875_CMDWRITE equ 0x80
RA8875_CMDREAD equ 0xC0

; RA8875 SPI
; Pin definitions for SPI on GPIO port

; GPO
; Serial Clock
RA8875_SCK        equ 0
; Master Out Slave In
RA8875_MOSI       equ 1
; RA8875 RESET - active LOW
RA8875_RESET   equ 2
; Chip Select - active LOW
RA8875_CS         equ 3

; GPI
; WAIT
RA8875_WAIT    equ 0
; Master In Slave Out
RA8875_MISO      equ 1

GPO_RESET_STATE equ 1 << RA8875_CS
GPO_INIT_STATE equ 1 << RA8875_CS | 1 << RA8875_RESET
GPO_SELECT_STATE equ 1 << RA8875_RESET
GPO_LOW_STATE equ 1 << RA8875_RESET
GPO_HIGH_STATE equ 1 << RA8875_MOSI | 1 << RA8875_RESET

; Reset state
; Destroys: AF
ra8875_reset:
    ; Set initial pin states (RESET high, CS high, CLK low, MOSI low)
    ld a,GPO_RESET_STATE
    out (GPIO_OUT),a
    ret

; Initial state
; Prepare GPIO pins for SPI operation
; Destroys: AF
ra8875_init:
    ; Set initial pin states (RESET high, CS high, CLK low, MOSI low)
    ld a,GPO_INIT_STATE
    out (GPIO_OUT),a
    ret

; Select SPI device (CS low)
; Destroys: AF
ra8875_select:
    ; CS low
    ld a,GPO_SELECT_STATE
    out (GPIO_OUT),a
    ret

; Deselect SPI device (CS high)
; Destroys: AF
ra8875_deselect:
    ; CS high
    ld a,GPO_INIT_STATE
    out (GPIO_OUT),a
    ret

; Write a byte over SPI (no readback)
; Input: A = byte to send
; Destroys: AF, B
ra8875_write:
    ld b,8
ra8875_write_bit:
    ; MSB into carry flag
    rlca
    ; stash A
    ld d,a
    ; default to MOSI low
    ld a,GPO_LOW_STATE
    jr nc,ra8875_write_mosi
    ld a,GPO_HIGH_STATE
ra8875_write_mosi:
    out (GPIO_OUT),a
    ; clock high
    or 1 << RA8875_SCK
    out (GPIO_OUT),a
    ; clock low
    and ~(1 << RA8875_SCK)
    out (GPIO_OUT),a
    ; restore A
    ld a,d
    djnz ra8875_write_bit
    ret

; Read a byte over SPI (receive from MISO)
; Sends a dummy byte (0x00) during the read
; Output: A = byte received
; Destroys: AF, B
ra8875_read:
    ; Initialize bit counter and received byte
    ld b,8
    ld a,0
ra8875_read_bit:
    ; Shift received bits left
    sla a
    ; stash A
    ld d,a
    ; Set initial low state
    ld a,GPO_LOW_STATE
    out (GPIO_OUT),a
    ; Set clock high
    or 1 << RA8875_SCK
    out (GPIO_OUT),a
    ; Read MISO bit
    in a,(GPIO_IN)
    bit RA8875_MISO,a
    jr z,ra8875_read_miso_low
    ; MISO high - set LSB
    ld a,d
    or 1
    jr ra8875_read_clock_low
ra8875_read_miso_low:
    ; MISO low - keep LSB clear
    ld a,d
ra8875_read_clock_low:
    ; Set clock low
    ld d,a
    ld a,GPO_LOW_STATE
    out (GPIO_OUT),a
    ; Restore received byte
    ld a,d
    djnz ra8875_read_bit
    ret
