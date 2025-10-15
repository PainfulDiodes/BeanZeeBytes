; RA8875registers and their values
; based on RA8875 datasheet and Adafruit RA8875 library

; REG[01h] Power and Display Control Register (PWRR)
RA8875_PWRR equ 0x01
RA8875_PWRR_DISPON equ 0x80
RA8875_PWRR_DISPOFF equ 0x00
RA8875_PWRR_SLEEP equ 0x02
RA8875_PWRR_NORMAL equ 0x00
RA8875_PWRR_SOFTRESET equ 0x01

; REG[04h] Pixel Clock Setting Register (PCSR)
RA8875_PCSR equ 0x04
RA8875_PCSR_PDATR equ 0x00
RA8875_PCSR_PDATL equ 0x80
RA8875_PCSR_CLK equ 0x00
RA8875_PCSR_2CLK equ 0x01
RA8875_PCSR_4CLK equ 0x02
RA8875_PCSR_8CLK equ 0x03
RA8875_PCSR_800x480 equ RA8875_PCSR_PDATL | RA8875_PCSR_2CLK
RA8875_PCSR_VAL equ RA8875_PCSR_800x480

; REG[10h] System Configuration Register (SYSR)
RA8875_SYSR equ 0x10
RA8875_SYSR_8BPP equ 0x00  ; 8-bpp generic TFT, i.e. 256 colors.
RA8875_SYSR_16BPP equ 0x0C ; 16-bpp generic TFT, i.e. 65K colors.
RA8875_SYSR_MCU8 equ 0x00  ; 8-bit MCU Interface
RA8875_SYSR_MCU16 equ 0x03 ; 16-bit MCU Interface

; REG[14h] LCD Horizontal Display Width Register (HDWR)
RA8875_HDWR equ 0x14
; LCD panel display width in 8 pixel units
; width(pixels) = (HDWR+1)x8
RA8875_HDWR_800x480 equ (800 / 8) - 1
RA8875_HDWR_VAL equ RA8875_HDWR_800x480

; REG[15h] Horizontal Non-Display Period Fine Tuning Option Register (HNDFTR)
RA8875_HNDFTR equ 0x15
RA8875_HNDFTR_DE_HIGH equ 0x00
RA8875_HNDFTR_DE_LOW equ 0x80
RA8875_HNDFTR_800x480 equ RA8875_HNDFTR_DE_HIGH + 0 ; polarity + fine tuning value
RA8875_HNDFTR_VAL equ RA8875_HNDFTR_800x480

; REG[16h] LCD Horizontal Non-Display Period Register (HNDR)
RA8875_HNDR equ 0x16
; Horizontal Non-Display Period(HNDP) Bit[4:0] (pixels) = (HNDR + 1)x8+(HNDFTR/2+1)x2 + 2
; (hsync_nondisp - hsync_finetune - 2) /8)
RA8875_HNDR_800x480 equ (26-0-2)/8 ; =3
RA8875_HNDR_VAL equ RA8875_HNDR_800x480

; REG[17h] HSYNC Start Position Register (HSTR)
RA8875_HSTR equ 0x17
; HSYNC Start Position[4:0]
; The starting position from the end of display area to the beginning of HSYNC. 
; Each level of this modulation is 8-pixel. HSYNC Start Position(pixels) = (HSTR + 1)x8
; hsync_start / 8 - 1
RA8875_HSTR_800x480 equ 32 / 8 - 1 ; =3
RA8875_HSTR_VAL equ RA8875_HSTR_800x480 


RA8875_HPWR equ 0x18
RA8875_HPWR_LOW equ 0x00
RA8875_HPWR_HIGH equ 0x80


; REG[88h] PLL Control Register 1 (PLLC1)
RA8875_PLLC1 equ 0x88 
RA8875_PLLC1_PLLDIV1 equ 0x00
RA8875_PLLC1_PLLDIV2 equ 0x80
RA8875_PLLC1_800x480 equ RA8875_PLLC1_PLLDIV1 + 11
RA8875_PLLC1_VAL equ RA8875_PLLC1_800x480

; REG[89h] PLL Control Register 2 (PLLC2)
RA8875_PLLC2 equ 0x89
RA8875_PLLC2_DIV1 equ 0x00
RA8875_PLLC2_DIV2 equ 0x01
RA8875_PLLC2_DIV4 equ 0x02
RA8875_PLLC2_DIV8 equ 0x03
RA8875_PLLC2_DIV16 equ 0x04
RA8875_PLLC2_DIV32 equ 0x05
RA8875_PLLC2_DIV64 equ 0x06
RA8875_PLLC2_DIV128 equ 0x07
RA8875_PLLC2_800x480 equ RA8875_PLLC2_DIV4
RA8875_PLLC2_VAL equ RA8875_PLLC2_800x480

; expected value in register 0 - validates presence of RA8875
RA8875_REG_0_VAL equ 0x75

; commands
RA8875_DATAWRITE equ 0x00
RA8875_DATAREAD equ 0x40
RA8875_CMDWRITE equ 0x80
RA8875_CMDREAD equ 0xC0

; delays 
; 0x0e was the minimum needed for PLLC1/2 init with a 10MHz Z80 clock
RA8875_DELAY_VAL equ 0xff

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


; low level utilities
ra8875_delay:
    push bc
    ld b,RA8875_DELAY_VAL
_ra8875_delay_loop:
    nop
    djnz _ra8875_delay_loop
    pop bc
    ret


; hardware reset of RA8875
ra8875_reset:
    push af
    ld a,GPO_RESET_STATE
    out (GPIO_OUT),a
    call ra8875_delay
    ld a,GPO_INACTIVE_STATE
    out (GPIO_OUT),a
    pop af
    ret


; low level RA8875 SPI routines

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


; basic RA8875 routines

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


; register access routines

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

; higher level RA8875 routines

; Check RA8875 register 0 for expected value
; Z flag set if matched, reset if not  
; destroys A
ra8875_reg_0_check:
    ld a,0x00 ; register number
    call ra8875_read_reg
    cp RA8875_REG_0_VAL ; sets Z flag if matched
    ret

ra8875_pllc1_init:
    push af
    push bc
    ld a,RA8875_PLLC1
    ld b,RA8875_PLLC1_VAL
    call ra8875_write_reg
    call ra8875_delay
    pop bc
    pop af
    ret

ra8875_pllc2_init:
    push af
    push bc
    ld a,RA8875_PLLC2
    ld b,RA8875_PLLC2_VAL
    call ra8875_write_reg
    call ra8875_delay
    pop bc
    pop af
    ret

ra8875_sysr_init:
    push af
    push bc
    ld a,RA8875_SYSR
    ld b,RA8875_SYSR_16BPP | RA8875_SYSR_MCU8
    call ra8875_write_reg
    pop bc
    pop af
    ret

ra8875_pcsr_init:
    push af
    push bc
    ld a,RA8875_PCSR
    ld b,RA8875_PCSR_VAL
    call ra8875_write_reg
    call ra8875_delay
    pop bc
    pop af
    ret

ra8875_horizontal_settings_init:
    push af
    push bc
    ld a,RA8875_HDWR
    ld b,RA8875_HDWR_VAL
    call ra8875_write_reg
    ld a,RA8875_HNDFTR
    ld b,RA8875_HNDFTR_VAL
    call ra8875_write_reg
    ld a,RA8875_HNDR
    ld b,RA8875_HNDR_VAL
    call ra8875_write_reg
    ld a,RA8875_HSTR
    ld b,RA8875_HSTR_VAL
    call ra8875_write_reg
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

