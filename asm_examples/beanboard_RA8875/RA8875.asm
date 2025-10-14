RA8875_REG_0_VAL equ 0x75

RA8875_RESET_DELAY_VAL equ 0xff
RA8875_PLLC_DELAY_VAL equ 0x0e*4 ; 0x0e was the minimum needed for PLLC1/2 init with a 10MHz Z80 clock

; commands
RA8875_DATAWRITE equ 0x00
RA8875_DATAREAD equ 0x40
RA8875_CMDWRITE equ 0x80
RA8875_CMDREAD equ 0xC0

; registers
RA8875_PLLC1 equ 0x88
RA8875_PLLC2 equ 0x89
RA8875_PWRR equ 0x01

; config data
RA8875_PLLC1_PLLDIV1 equ 0x00
RA8875_PLLC1_PLLDIV2 equ 0x80
RA8875_PLLC2_DIV1 equ 0x00
RA8875_PLLC2_DIV2 equ 0x01
RA8875_PLLC2_DIV4 equ 0x02
RA8875_PLLC2_DIV8 equ 0x03
RA8875_PLLC2_DIV16 equ 0x04
RA8875_PLLC2_DIV32 equ 0x05
RA8875_PLLC2_DIV64 equ 0x06
RA8875_PLLC2_DIV128 equ 0x07

RA8875_PLLC1_800x480 equ RA8875_PLLC1_PLLDIV1 + 11
RA8875_PLLC2_800x480 equ RA8875_PLLC2_DIV4

RA8875_PLLC1_VAL equ RA8875_PLLC1_800x480
RA8875_PLLC2_VAL equ RA8875_PLLC2_800x480

RA8875_PWRR_DISPON equ 0x80
RA8875_PWRR_DISPOFF equ 0x00
RA8875_PWRR_SLEEP equ 0x02
RA8875_PWRR_NORMAL equ 0x00
RA8875_PWRR_SOFTRESET equ 0x01

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

; Write data to RA8875
; A = data
ra8875_write_data:
    push af
    push bc
    ld c,a ; stash the data
    ld a,GPO_ACTIVE_STATE
    out (GPIO_OUT),a
    ld a,RA8875_DATAWRITE
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

; A = register number
; B = data
ra8875_write_reg:
    push af
    call ra8875_write_command ; A = register number
    ld a,b
    call ra8875_write_data
    pop af
    ret

ra8875_pllc1_init:
    push af
    push bc
    ld a,RA8875_PLLC1
    ld b,RA8875_PLLC1_VAL
    call ra8875_write_reg
    call ra8875_plcc_delay
    pop bc
    pop af
    ret

ra8875_pllc2_init:
    push af
    push bc
    ld a,RA8875_PLLC2
    ld b,RA8875_PLLC2_VAL
    call ra8875_write_reg
    call ra8875_plcc_delay
    pop bc
    pop af
    ret

ra8875_display_on:
    push af
    push bc
    ld a,RA8875_PWRR
    ld b,RA8875_PWRR_NORMAL | RA8875_PWRR_DISPON
    call ra8875_write_reg
    pop bc
    pop af
    ret

; Check RA8875 register 0 for expected value
; Z flag set if matched, reset if not  
; destroys A
ra8875_reg_0_check:
    ld a,0x00 ; register number
    call ra8875_read_reg
    cp RA8875_REG_0_VAL ; sets Z flag if matched
    ret

ra8875_plcc_delay:
    push bc
    ld b,RA8875_PLLC_DELAY_VAL
_ra8875_plcc_delay_loop:
    nop
    djnz _ra8875_plcc_delay_loop
    pop bc
    ret

ra8875_reset_delay:
    push bc
    ld b,RA8875_RESET_DELAY_VAL
_ra8875_reset_delay_loop:
    nop
    djnz _ra8875_reset_delay_loop
    pop bc
    ret

ra8875_reset:
    push af
    ld a,GPO_RESET_STATE
    out (GPIO_OUT),a
    call ra8875_reset_delay
    ld a,GPO_INACTIVE_STATE
    out (GPIO_OUT),a
    pop af
    ret
