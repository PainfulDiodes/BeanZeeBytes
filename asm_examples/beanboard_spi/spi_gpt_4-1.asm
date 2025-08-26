; Copilot Agent - GPI 4.1 
; spi
; Send and receive one byte over SPI using bit-banging.
; Input:
;   a - byte to send
; Output:
;   a - received byte
; Uses:
;   GPIO_OUT - port for MOSI, SCK
;   GPIO_IN  - port for MISO
;   mosi_bit, miso_bit, sck_bit - bit masks for respective lines

spi:
  push bc
  push de
  ; 8 bits to send
  ld b, 8
  ; d = byte to send
  ld d, a
  ; e = received byte
  ld e, 0

spi_loop:
  ; set MOSI line
  ld a, d
  ; shift left, msb in carry
  rlca
  ; update d
  ld d, a
  jr nc, _mosi_low
  ; set MOSI high
  in a, (GPIO_OUT)    ; ISSUE : assumption that GPIOs are bi-directional, which they are not
  or MOSI_BIT
  out (GPIO_OUT), a
  jr _mosi_done
_mosi_low:
  in a, (GPIO_OUT)
  and ~MOSI_BIT
  out (GPIO_OUT), a
_mosi_done:

  ; set SCK high
  in a, (GPIO_OUT)
  or SCK_BIT
  out (GPIO_OUT), a

  ; read MISO
  in a, (GPIO_IN)
  and MISO_BIT
  jr z, _miso_low
  ; set bit in e
  ld a, e
  or 1
  ld e, a
  jr _miso_done
_miso_low:
  ; leave bit as 0
_miso_done:
  ; shift e left for next bit unless last
  ld a, b
  cp 1
  jr z, _skip_shift_e
  ld a, e
  sla a
  ld e, a
_skip_shift_e:

  ; set SCK low
  in a, (GPIO_OUT)
  and ~SCK_BIT
  out (GPIO_OUT), a

  djnz spi_loop

  ; return received byte in a
  ld a, e
  pop de
  pop bc
  ret

; Helper bitmask definitions as constants
MOSI_BIT equ 0x01
MISO_BIT equ 0x02
SCK_BIT  equ 0x04