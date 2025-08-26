; bitbang_spi
; Send and receive one byte over SPI using bit-banging.
; Input:
;   a - byte to send
; Output:
;   a - received byte
; Uses:
;   GPIO_OUT - port for MOSI, SCK
;   GPIO_IN  - port for MISO
;   mosi_bit, miso_bit, sck_bit - bit masks for respective lines

bitbang_spi:
  push bc
  push de
  ld b, 8                ; 8 bits to send
  ld d, a                ; d = byte to send
  ld e, 0                ; e = received byte

bitbang_spi_loop:
  ; set MOSI line
  ld a, d
  rlca                   ; shift left, msb in carry
  ld d, a                ; update d
  jr nc, _mosi_low
  ; set MOSI high
  in a, (GPIO_OUT)
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

  djnz bitbang_spi_loop

  ld a, e                ; return received byte in a
  pop de
  pop bc
  ret

; Helper bitmask definitions as constants
MOSI_BIT equ 0x01
MISO_BIT equ 0x02
SCK_BIT  equ 0x04