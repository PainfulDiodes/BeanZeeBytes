; RA8875 (SPI)

RA8875_DATAWRITE equ 0x00
RA8875_DATAREAD equ 0x40
RA8875_CMDWRITE equ 0x80
RA8875_CMDREAD equ 0xC0

; Pin definitions for RA8875 SPI on GPIO port

; GPO
; Serial Clock
RA8875_SCK        equ 0
; Master Out Slave In
RA8875_MOSI       equ 1
; RA8875 RESET - active LOW
RA8875_RESET      equ 2
; Chip Select - active LOW
RA8875_CS         equ 3

; GPI
RA8875_MISO       equ 1

; RESET active/low, CS inactive/high
GPO_RESET_STATE  equ 1 << RA8875_CS
; RESET inactive/high, CS inactive/high
GPO_INACTIVE_STATE   equ 1 << RA8875_CS | 1 << RA8875_RESET
; RESET inactive/high, CS active/low
GPO_ACTIVE_STATE equ 1 << RA8875_RESET
; RESET inactive/high, CS active/low, MOSI low
GPO_LOW_STATE    equ 1 << RA8875_RESET
; RESET inactive/high, CS active/low, MOSI high
GPO_HIGH_STATE   equ 1 << RA8875_MOSI | 1 << RA8875_RESET

; Reset active
ra8875_start_reset:
    push af
    ld a,GPO_RESET_STATE
    out (GPIO_OUT),a
    pop af
    ret

; Reset inactive
ra8875_end_reset:
    push af
    ld a,GPO_INACTIVE_STATE
    out (GPIO_OUT),a
    pop af
    ret

; Write a byte over SPI without readback
; Input: A = byte to send
; Destroys: AF, B
ra8875_write:
    ; bit counter
    ld b,8
_ra8875_write_loop:
    ; rotate msb into carry flag
    rlca
    ; stash a
    ld d,a
    ; default to MOSI low
    ld a,GPO_LOW_STATE
    jr nc,_ra8875_write_bit
    ld a,GPO_HIGH_STATE
_ra8875_write_bit:
    out (GPIO_OUT),a
    ; clock high
    or 1 << RA8875_SCK
    out (GPIO_OUT),a
    ; clock low
    and ~(1 << RA8875_SCK)
    out (GPIO_OUT),a
    ; restore A
    ld a,d
    djnz _ra8875_write_loop
    ret

; Read a byte over SPI (receive from MISO)
; Sends a dummy byte (0x00) during the read
; Output: A = byte received
; Destroys: AF, B
ra8875_read:
    ; bit counter
    ld b,8
    ; Initialize received byte
    ld a,0
_ra8875_read_loop:
    ; Shift received bits left
    sla a
    ; stash a
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
    jr z,_ra8875_read_low
    ; MISO high - set LSB
    ld a,d
    or 1
    jr _ra8875_read_bit_done
_ra8875_read_low:
    ; MISO low - keep LSB clear
    ld a,d
_ra8875_read_bit_done:
    ; Set clock low
    ld d,a
    ld a,GPO_LOW_STATE
    out (GPIO_OUT),a
    ; Restore received byte
    ld a,d
    djnz _ra8875_read_loop
    ret

; Write a command to RA8875
; A = command parameter
ra8875_write_command:
    push af
    push bc
    ld c,a ; stash the data
    ld a,GPO_ACTIVE_STATE
    out (GPIO_OUT),a
    ld a,RA8875_CMDWRITE
    call ra8875_write
    ld a,c ; recover the data to send
    call ra8875_write
    ld a,GPO_INACTIVE_STATE
    out (GPIO_OUT),a
    pop bc
    pop af
    ret

; read data from RA8875
; returns data in A
ra8875_read_data:
    push bc
    ld a,GPO_ACTIVE_STATE
    out (GPIO_OUT),a
    ld a,RA8875_DATAREAD
    call ra8875_write
    call ra8875_read
    ld b,a ; stash data
    ld a,GPO_INACTIVE_STATE
    out (GPIO_OUT),a
    ld a,b ; restore data
    pop bc
    ret

; read from RA8875 register
; A = register number to read
ra8875_read_reg:
    call ra8875_write_command
    call ra8875_read_data
    ret
