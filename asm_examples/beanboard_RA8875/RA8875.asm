;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ra8875 commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RA8875_DATAWRITE equ 0x00 
RA8875_DATAREAD equ 0x40
RA8875_CMDWRITE equ 0x80
RA8875_CMDREAD equ 0xC0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RA8875 registers and their values
; based on RA8875 datasheet and Adafruit RA8875 library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; REG[01h] Power and Display Control Register (PWRR)
RA8875_PWRR equ 0x01
RA8875_PWRR_DISPON equ 0x80
RA8875_PWRR_DISPOFF equ 0x00
RA8875_PWRR_SLEEP equ 0x02
RA8875_PWRR_NORMAL equ 0x00
RA8875_PWRR_SOFTRESET equ 0x01

; REG[02h] Memory Read/Write Command (MRWC)
; Write Function : Memory Write Data
; Data to write in memory corresponding to the setting of MWCR1[3:2]. 
; Continuous data write cycle can be accepted in bulk data write case.
; Read Function : Memory Read Data
; Data to read from memory corresponding to the setting of MWCR1[3:2]. 
; Continuous data read cycle can be accepted in bulk data read case. 
; Note that the first data read cycle is dummy read and need to be ignored.
RA8875_MRWC equ 0x02

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
; Horizontal Display Width Setting Bit[6:0]
; The register specifies the LCD panel horizontal display width in the unit of 8 pixels resolution.
; Horizontal display width(pixels) = (HDWR + 1)x8
RA8875_HDWR equ 0x14
RA8875_HDWR_800x480 equ (800 / 8) - 1
RA8875_HDWR_VAL equ RA8875_HDWR_800x480

; REG[15h] Horizontal Non-Display Period Fine Tuning Option Register (HNDFTR)
; Horizontal Non-Display Period Fine Tuning(HNDFT) [3:0]
; This register specifies the fine tuning for horizontal non-display period; 
; it is used to support the SYNC mode panel. Each level of this modulation is 2-pixel.
RA8875_HNDFTR equ 0x15
RA8875_HNDFTR_DE_HIGH equ 0x00
RA8875_HNDFTR_DE_LOW equ 0x80
RA8875_HNDFTR_800x480 equ RA8875_HNDFTR_DE_HIGH + 0 ; polarity + fine tuning value
RA8875_HNDFTR_VAL equ RA8875_HNDFTR_800x480

; REG[16h] LCD Horizontal Non-Display Period Register (HNDR)
; Horizontal Non-Display Period(HNDP) Bit[4:0]
; This register specifies the horizontal non-display period. 
; Horizontal Non-Display Period (pixels) =(HNDR + 1)x8+(HNDFTR/2+1)x2 + 2
RA8875_HNDR equ 0x16
; (hsync_nondisp - hsync_finetune - 2) /8)
RA8875_HNDR_800x480 equ (26-0-2)/8 ; =3
RA8875_HNDR_VAL equ RA8875_HNDR_800x480

; REG[17h] HSYNC Start Position Register (HSTR)
; HSYNC Start Position[4:0]
; The starting position from the end of display area to the beginning of HSYNC. 
; Each level of this modulation is 8-pixel. HSYNC Start Position(pixels) = (HSTR + 1)x8
RA8875_HSTR equ 0x17
; hsync_start / 8 - 1
RA8875_HSTR_800x480 equ 32 / 8 - 1 ; =3
RA8875_HSTR_VAL equ RA8875_HSTR_800x480 

; REG[18h] HSYNC Pulse Width Register (HPWR)
RA8875_HPWR equ 0x18
RA8875_HPWR_LOW equ 0x00
RA8875_HPWR_HIGH equ 0x80
; HSYNC Pulse Width(HPW) [4:0]
; The period width of HSYNC.
; HSYNC Pulse Width(pixels) = (HPW + 1)x8
; hsync_pw / 8 - 1
RA8875_HPWR_800x480 equ RA8875_HPWR_LOW + 96 / 8 - 1 ; =11 =0x0b
RA8875_HPWR_VAL equ RA8875_HPWR_800x480

; REG[19h] LCD Vertical Display Height Register (VDHR0)
; Vertical Display Height Bit[7:0] 
; Vertical Display Height(Line) = VDHR + 1
; lower byte of line_height-1
RA8875_VDHR0 equ 0x19
RA8875_VDHR0_800x480 equ 0x00ff & (480 - 1)
RA8875_VDHR0_VAL equ RA8875_VDHR0_800x480

; REG[1Ah] LCD Vertical Display Height Register0 (VDHR1)
; Vertical Display Height Bit[8]
; Vertical Display Height(Line) = VDHR + 1
; (only bit 0 is used)
; upper byte of line_height-1
RA8875_VDHR1 equ 0x1A
RA8875_VDHR1_800x480 equ (0xff00 & (480 - 1)) / 0x100
RA8875_VDHR1_VAL equ RA8875_VDHR1_800x480

; REG[1Bh] LCD Vertical Non-Display Period Register (VNDR0)
; Vertical Non-Display Period Bit[7:0]
; Vertical Non-Display Period(Line) = (VNDR + 1)
; lower byte of val-1
RA8875_VNDR0 equ 0x1B
RA8875_VNDR0_800x480 equ 32-1
RA8875_VNDR0_VAL equ RA8875_VNDR0_800x480

; REG[1Ch] LCD Vertical Non-Display Period Register (VNDR1)
; Vertical Non-Display Period Bit[8]
; Vertical Non-Display Period(Line) = (VNDR + 1)
; upper byte of val-1
RA8875_VNDR1 equ 0x1C
RA8875_VNDR1_800x480 equ 0
RA8875_VNDR1_VAL equ RA8875_VNDR1_800x480

; REG[1Dh] VSYNC Start Position Register (VSTR0)
; VSYNC Start Position[7:0]
; The starting position from the end of display area to the beginning of VSYNC.
; VSYNC Start Position(Line) = (VSTR + 1)
; lower byte of val-1
RA8875_VSTR0 equ 0x1D
RA8875_VSTR0_800x480 equ 23-1
RA8875_VSTR0_VAL equ RA8875_VSTR0_800x480

; REG[1Eh] VSYNC Start Position Register (VSTR1)
; VSYNC Start Position[8]
; The starting from the end of display area to the beginning of VSYNC.
; VSYNC Start Position(Line) = (VSTR + 1)
; upper byte of val-1
RA8875_VSTR1 equ 0x1E
RA8875_VSTR1_800x480 equ 0
RA8875_VSTR1_VAL equ RA8875_VSTR1_800x480

; REG[1Fh] VSYNC Pulse Width Register (VPWR)
; VSYNC Polarity [7]
; 0 : Low active. 1 : High active.
; VSYNC Pulse Width[6:0]
; The pulse width of VSYNC in lines. VSYNC Pulse Width(Line) = (VPWR + 1)
RA8875_VPWR equ 0x1F
RA8875_VPWR_LOW equ 0x00
RA8875_VPWR_HIGH equ 0x80
RA8875_VPWR_800x480 equ RA8875_VPWR_LOW + (2 - 1) ; polarity + pulse_width_val-1
RA8875_VPWR_VAL equ RA8875_VPWR_800x480

; REG[21h] Font Control Register 0 (FNCR0)
RA8875_FNCR0 equ 0x21
; Bit 7 - CGRAM/CGROM Font Selection Bit in Text Mode
; 0 : CGROM font is selected.
; 1 : CGRAM font is selected.
; Note:
; 1. The bit is used to select the bit-map source when text-mode is active
; (REG[40h] bit 7 is 1), when CGRAM is writing (REG[41h] bit 3-2 =01b), 
; the bit must be set as “0”. 
; 2. When CGRAM font is select, REG[21h] bit 5 must be set as 1.
; Bit 5 - External/Internal CGROM Selection Bit
; 0 : Internal CGROM is selected.(REG[2Fh] must be set 00h )
; 1 : External CGROM is selected. (REG[2Eh] bit6 &bit7 must be set 0)
; Bit 1-0 - Font Selection for internal CGROM
; When FNCR0 B7 = 0 and B5 = 0, Internal CGROM supports the 8x16 character sets 
; with the standard coding of ISO/IEC 8859- 1~4, which supports English 
; and most of European country languages.
; 00b : ISO/IEC 8859-1. 
; 01b : ISO/IEC 8859-2. 
; 10b : ISO/IEC 8859-3. 
; 11b : ISO/IEC 8859-4.

; REG[2Ah] Font Write Cursor Horizontal Position Register 0 (F_CURXL)
; Font Write Cursor Horizontal Position[7:0]
; The setting of the horizontal cursor position for font writing.
RA8875_F_CURXL equ 0x2a

; REG[2Bh] Font Write Cursor Horizontal Position Register 1 (F_CURXH)
; Font Write Cursor Horizontal Position[9:8]
; The setting of the horizontal cursor position for font writing.
RA8875_F_CURXH equ 0x2b

; REG[2Ch] Font Write Cursor Vertical Position Register 0 (F_CURYL)
; Font Write Cursor Vertical Position[7:0]
; The setting of the vertical cursor position for font writing.
RA8875_F_CURYL equ 0x2c

; REG[2Dh] Font Write Cursor Vertical Position Register 1 (F_CURYH)
; Font Write Cursor Vertical Position[8]
; The setting of the vertical cursor position for font writing.
RA8875_F_CURYH equ 0x2d

; REG[30h] Horizontal Start Point 0 of Active Window (HSAW0)
; Horizontal Start Point of Active Window [7:0] 
; (lower byte)
RA8875_HSAW0 equ 0x30
RA8875_HSAW0_800x480 equ 0
RA8875_HSAW0_VAL equ RA8875_HSAW0_800x480

; REG[31h] Horizontal Start Point 1 of Active Window (HSAW1)
; Horizontal Start Point of Active Window [9:8] 
; (upper byte, only 2 bits are significant)
RA8875_HSAW1 equ 0x31
RA8875_HSAW1_800x480 equ 0
RA8875_HSAW1_VAL equ RA8875_HSAW1_800x480


; REG[32h] Vertical Start Point 0 of Active Window (VSAW0)
; Vertical Start Point of Active Window [7:0]
; (lower byte)
RA8875_VSAW0 equ 0x32
RA8875_VSAW0_800x480 equ 0
RA8875_VSAW0_VAL equ RA8875_VSAW0_800x480


; REG[33h] Vertical Start Point 1 of Active Window (VSAW1)
; Vertical Start Point of Active Window [8]
; (upper byte, only 1 bit is significant)
RA8875_VSAW1 equ 0x33
RA8875_VSAW1_800x480 equ 0
RA8875_VSAW1_VAL equ RA8875_VSAW1_800x480

; REG[34h] Horizontal End Point 0 of Active Window (HEAW0)
; Horizontal End Point of Active Window [7:0]
; (lower byte)
; NOTE: datasheet does not mention an offset of 1
RA8875_HEAW0 equ 0x34
RA8875_HEAW0_800x480 equ 0x00ff & (800 - 1)
RA8875_HEAW0_VAL equ RA8875_HEAW0_800x480

; REG[35h] Horizontal End Point 1 of Active Window (HEAW1)
; Horizontal End Point of Active Window [9:8]
; (upper byte, only 2 bits are significant)
; NOTE: datasheet does not mention an offset of 1
RA8875_HEAW1 equ 0x35
RA8875_HEAW1_800x480 equ (0xff00 & (800 - 1)) / 0x100
RA8875_HEAW1_VAL equ RA8875_HEAW1_800x480

; REG[36h] Vertical End Point of Active Window 0 (VEAW0)
; Vertical End Point of Active Window [7:0]
; (lower byte)
RA8875_VEAW0 equ 0x36
RA8875_VEAW0_800x480 equ 0x00ff & (480 - 1)
RA8875_VEAW0_VAL equ RA8875_VEAW0_800x480

; REG[37h] Vertical End Point of Active Window 1 (VEAW1)
; Vertical End Point of Active Window [8]
; (upper byte, only 1 bit is significant)
RA8875_VEAW1 equ 0x37
RA8875_VEAW1_800x480 equ  (0xff00 & (480 - 1)) / 0x100
RA8875_VEAW1_VAL equ RA8875_VEAW1_800x480

; REG[40h] Memory Write Control Register 0 (MWCR0)
; Bit 7 - Text Mode Enable
; 0 : Graphic mode. 
; 1 : Text mode.
; Bit 6 - Font Write Cursor/ Memory Write Cursor Enable
; 0 : Font write cursor/ Memory Write Cursor is not visible.
; 1 : Font write cursor/ Memory Write Cursor is visible.
; Bit 5 - Font Write Cursor/ Memory Write Cursor Blink Enable
; 0 : Normal display.
; 1 : Blink display.
; Bit 3-2 - Memory Write Direction (Only for Graphic Mode)
; 00b : Left>Right then Top>Down.
; 01b : Right>Left then Top>Down.
; 10b : Top>Down then Left>Right.
; 11b : Down>Top then Left>Right.
; Bit 1 - Memory Write Cursor Auto-Increase Disable
; 0 : Cursor auto-increases when memory write.
; 1 : Cursor doesn’t auto-increases when memory write.
; Bit 0 - Memory Read Cursor Auto-Increase Disable
; 0 : Cursor auto-increases when memory read.
; 1 : Cursor doesn’t auto-increases when memory read.
RA8875_MWCR0 equ 0x40
RA8875_MWCR0_GFXMODE equ 0x00
RA8875_MWCR0_TXTMODE equ 0x80
RA8875_MWCR0_CURSOR equ 0x40
RA8875_MWCR0_BLINK equ 0x20

; REG[44h] Blink Time Control Register (BTCR)
; Text Blink Time Setting (Unit: Frame)
RA8875_BTCR equ 0x44

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

; REG[8Ah] PWM1 Control Register (P1CR)
; Bit 7
; PWM1 Enable 
; 0 : Disable, PWM1_OUT level depends on P1CR bit6. 
; 1 : Enable.
; Bit 6
; PWM1 Disable Level
; 0 : PWM1_OUT is Normal L when PWM disable or Sleep mode. 1 : PWM1_OUT is Normal H when PWM disable or Sleep mode
; The bit is only usable when P1CR bit 4 is 0
; Bit 4
; PWM1 Function Selection
; 0 : PWM1 function
; 1 : PWM1 output a fixed frequency signal and it is equal to 1 /16 oscillator clock. PWM1 = FOSC / 16
; Bit 0-3
; PWM1 Clock Source Divide Ratio:
; 1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768
RA8875_P1CR equ 0x8A
RA8875_P1CR_ENABLE equ 0x80
RA8875_P1CR_DISABLE equ 0x00
RA8875_P1CR_CLKOUT equ 0x10
RA8875_P1CR_PWMOUT equ 0x00
RA8875_PWM_CLK_DIV1 equ 0x00
RA8875_PWM_CLK_DIV2 equ 0x01
RA8875_PWM_CLK_DIV4 equ 0x02
RA8875_PWM_CLK_DIV8 equ 0x03
RA8875_PWM_CLK_DIV16 equ 0x04
RA8875_PWM_CLK_DIV32 equ 0x05
RA8875_PWM_CLK_DIV64 equ 0x06
RA8875_PWM_CLK_DIV128 equ 0x07
RA8875_PWM_CLK_DIV256 equ 0x08
RA8875_PWM_CLK_DIV512 equ 0x09
RA8875_PWM_CLK_DIV1024 equ 0x0A
RA8875_PWM_CLK_DIV2048 equ 0x0B
RA8875_PWM_CLK_DIV4096 equ 0x0C
RA8875_PWM_CLK_DIV8192 equ 0x0D
RA8875_PWM_CLK_DIV16384 equ 0x0E
RA8875_PWM_CLK_DIV32768 equ 0x0F
RA8875_P1CR_VAL equ RA8875_P1CR_ENABLE | RA8875_P1CR_PWMOUT | RA8875_PWM_CLK_DIV1024

; REG[8Bh] PWM1 Duty Cycle Register (P1DCR)
; PWM Cycle Duty Selection Bits[7:0]
; 0x00 = 1/256, 0xff = 256/256
RA8875_P1DCR equ 0x8B

; REG[8Eh] Memory Clear Control Register (MCLR)
; Bit 7
; Memory Clear Function
; 0 : End or Stop. When write 0 to this bit RA8875 will stop the Memory clear function. 
; Or if read back this bit is 0, it indicates that Memory clear function is complete.
; 1 : Start the memory clear function.
; Bit 6
; Memory Clear Area Setting
; 0 : Clear the full window. (Please refer to the setting of REG[14h], [19h], [1Ah])
; 1 : Clear the active window(Please refer to the setting of REG[30h~37h]). 
; The layer to be cleared is according to the setting REG[41h] Bit0.
RA8875_MCLR equ 0x8E
RA8875_MCLR_START equ 0x80
RA8875_MCLR_STOP equ 0x00
RA8875_MCLR_READSTATUS equ 0x80
RA8875_MCLR_FULL equ 0x00
RA8875_MCLR_ACTIVE equ 0x40

; REG[C7h] Extra General Purpose IO Register (GPIOX)
; Bit 0
; The GPIX/GPOX Data Bit
; Read: Input data from GPIX pin. Write: Output data to GPOX pin.
; On the Adafruit board, TFT display enable is tied to GPIOX
RA8875_GPIOX equ 0xC7

; expected value in register 0 - validates presence of RA8875
RA8875_REG_0_VAL equ 0x75

; default cursor blink rate
RA8875_CURSOR_BLINK_RATE equ 0x20


; delay
; 0x0e was the minimum needed for PLLC1/2 init with a 10MHz Z80 clock
RA8875_DELAY_VAL equ 0xff

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GPIO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; low level utilities
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; low level RA8875 SPI routines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Write a byte over SPI without readback
; Input: A = byte to send
; Destroys: AF, B, D
_ra8875_write:
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
; Destroys: AF, B, D
_ra8875_read:
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; basic RA8875 routines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Write a command to RA8875
; A = command parameter
ra8875_write_command:
    push af
    push bc
    ld c,a ; stash the data
    ld a,GPO_ACTIVE_STATE
    out (GPIO_OUT),a
    ld a,RA8875_CMDWRITE
    call _ra8875_write
    ld a,c ; recover the data to send
    call _ra8875_write
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
    call _ra8875_write
    ld a,c ; recover the data to send
    call _ra8875_write
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
    call _ra8875_write
    call _ra8875_read
    ld b,a ; stash data
    ld a,GPO_INACTIVE_STATE
    out (GPIO_OUT),a
    ld a,b ; restore data
    pop bc
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ra8875 register access routines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; higher level RA8875 routines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    ld a,RA8875_HPWR
    ld b,RA8875_HPWR_VAL
    call ra8875_write_reg
    pop bc
    pop af
    ret

ra8875_vertical_settings_init:
    push af
    push bc
    ld a,RA8875_VDHR0
    ld b,RA8875_VDHR0_VAL
    call ra8875_write_reg
    ld a,RA8875_VDHR1
    ld b,RA8875_VDHR1_VAL
    call ra8875_write_reg
    ld a,RA8875_VNDR0
    ld b,RA8875_VNDR0_VAL
    call ra8875_write_reg   
    ld a,RA8875_VNDR1
    ld b,RA8875_VNDR1_VAL
    call ra8875_write_reg
    ld a,RA8875_VSTR0
    ld b,RA8875_VSTR0_VAL
    call ra8875_write_reg
    ld a,RA8875_VSTR1
    ld b,RA8875_VSTR1_VAL
    call ra8875_write_reg
    ld a,RA8875_VPWR
    ld b,RA8875_VPWR_VAL
    call ra8875_write_reg
    pop bc
    pop af
    ret

ra8875_horizontal_active_window_init:
    push af
    push bc
    ld a,RA8875_HSAW0
    ld b,RA8875_HSAW0_VAL
    call ra8875_write_reg
    ld a,RA8875_HSAW1
    ld b,RA8875_HSAW1_VAL
    call ra8875_write_reg
    ld a,RA8875_HEAW0
    ld b,RA8875_HEAW0_VAL
    call ra8875_write_reg
    ld a,RA8875_HEAW1
    ld b,RA8875_HEAW1_VAL
    call ra8875_write_reg
    pop bc
    pop af
    ret

ra8875_vertical_active_window_init:
    push af
    push bc
    ld a,RA8875_VSAW0
    ld b,RA8875_VSAW0_VAL
    call ra8875_write_reg
    ld a,RA8875_VSAW1
    ld b,RA8875_VSAW1_VAL
    call ra8875_write_reg
    ld a,RA8875_VEAW0
    ld b,RA8875_VEAW0_VAL
    call ra8875_write_reg
    ld a,RA8875_VEAW1
    ld b,RA8875_VEAW1_VAL
    call ra8875_write_reg
    pop bc
    pop af
    ret

ra8875_clear_window:
    push af
    push bc
    ld a,RA8875_MCLR
    ld b,RA8875_MCLR_START | RA8875_MCLR_FULL
    call ra8875_write_reg
    ; wait for clear to complete
_ra8875_clear_wait:
    call ra8875_delay
    call ra8875_read_reg
    cp RA8875_MCLR_READSTATUS
    jr z,_ra8875_clear_wait
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

; GPIOX wired to enable TFT display
ra8875_adafruit_tft_enable:
    push af
    push bc
    ld a,RA8875_GPIOX
    ld b,0x01
    call ra8875_write_reg
    pop bc
    pop af
    ret

; PWM1 wired for backlight control
ra8875_backlight_init:
    push af
    push bc
    ld a,RA8875_P1CR
    ld b,RA8875_P1CR_VAL
    call ra8875_write_reg
    ld a,RA8875_P1DCR
    ld b,0xff
    call ra8875_write_reg
    pop bc
    pop af
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; top level RA8875 routines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ra8875_initialise:
    call ra8875_reset
    call ra8875_reg_0_check
    ret nz ; error

    call ra8875_pllc1_init
    call ra8875_reg_0_check
    ret nz ; error

    call ra8875_pllc2_init
    call ra8875_reg_0_check
    ret nz ; error

    call ra8875_sysr_init

    call ra8875_pcsr_init
    call ra8875_reg_0_check
    ret nz ; error

    call ra8875_horizontal_settings_init
    call ra8875_vertical_settings_init
    call ra8875_horizontal_active_window_init
    call ra8875_vertical_active_window_init
    call ra8875_clear_window

    call ra8875_display_on
    call ra8875_adafruit_tft_enable
    call ra8875_backlight_init

    cmp a ; clear error flag
    ret

; TODO this could be simpler if we just need to initialise for text mode
ra8875_text_mode:
    push af
    ; Set text mode
    ld a,RA8875_MWCR0
    call ra8875_write_command
    call ra8875_read_data
    or RA8875_MWCR0_TXTMODE ; set text mode bit
    call ra8875_write_data
    ; Select the internal (ROM) font
    ld a,RA8875_FNCR0
    call ra8875_write_command
    call ra8875_read_data
    and 0b01011111 ; Clear bits 7 and 5
    call ra8875_write_data
    pop af
    ret

; TODO compress/rationalise this function and check it still works!
; A = blink rate (0-255)
ra8875_cursor_blink:
    push af
    push bc
    ld b,a ; stash blink rate in B
    ld a,RA8875_MWCR0
    call ra8875_write_command
    call ra8875_read_data
    or RA8875_MWCR0_CURSOR ; set cursor visible bit
    call ra8875_write_data

    ld a,RA8875_MWCR0
    call ra8875_write_command
    call ra8875_read_data
    or RA8875_MWCR0_BLINK ; set blink bit
    call ra8875_write_data

    ld a,RA8875_BTCR
    call ra8875_write_command
    ld a,b ; restore blink rate
    call ra8875_write_data
    pop bc
    pop af
    ret

; HL = x position
ra8875_cursor_x:
    push af
    push hl
    ld a,RA8875_F_CURXL
    call ra8875_write_command
    ld a,l
    call ra8875_write_data
    ld a,RA8875_F_CURXH
    call ra8875_write_command
    ld a,h
    call ra8875_write_data
    pop hl
    pop af
    ret

; HL = y position
ra8875_cursor_y:
    push af
    push hl
    ld a,RA8875_F_CURYL
    call ra8875_write_command
    ld a,l
    call ra8875_write_data
    ld a,RA8875_F_CURYH
    call ra8875_write_command
    ld a,h
    call ra8875_write_data
    pop hl
    pop af
    ret

ra8875_memory_read_write_command:
    push af
    ld a,RA8875_MRWC
    call ra8875_write_command
    pop af
    ret

; A = character to write
ra8875_putchar:
    push af
    push bc
    ld b,a ; stash char in B
    ld a,RA8875_MRWC
    call ra8875_write_command
    ld a,b ; restore char to A
    call ra8875_write_data
    pop bc
    pop af
    ret

; HL = pointer to null-terminated string
; TODO could be improved by calling ra8875_write_data directly
ra8875_puts:
    push af
    push bc
_ra8875_puts_loop:
    ld a,(hl)
    cp 0
    jr z,_ra8875_puts_done
    call ra8875_putchar
    inc hl
    jr _ra8875_puts_loop
_ra8875_puts_done:
    pop bc
    pop af
    ret