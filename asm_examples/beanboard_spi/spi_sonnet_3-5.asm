; Copilot Agent - Claude Sonnet 3.5
; SPI Implementation for Write-Only Output / Read-Only Input
; Hardware configuration:
; - Single 8-bit write-only output port
; - Single 8-bit read-only input port
; - No read-back capability on output port

; Pin definitions on output port
; MOSI on bit 0
SPI_MOSI_BIT equ 0
; SCK on bit 1
SPI_SCK_BIT  equ 1
; CS on bit 2
SPI_CS_BIT   equ 2

; Pin definitions on input port
; MISO on bit 0
SPI_MISO_BIT equ 0

; Initialize SPI interface
; Sets initial pin states and saves initial output state
sonnet_spi_init:
  push af
  
  ; Set initial state: CS high, MOSI and SCK low
  ; CS high, others low
  ld a, 1 << SPI_CS_BIT
  ; Save state
  ld (SPI_OUTPUT_STATE), a
  ; Set initial output
  out (GPIO_OUT), a
  
  pop af
  ret

; Helper to update output port while tracking state
; Input:
;   a - bits to set (1) or clear (0)
;   c - mask of bits to modify (1 = modify, 0 = leave alone)
_update_output:
  push bc
  ; Save desired bit values
  ld b, a
  
  ; Get current state
  ld a, (SPI_OUTPUT_STATE)
  
  ; Clear bits that we want to modify
  ; Store mask in b temporarily
  ld b, c
  ; Complement the mask
  ld a, c
  cpl
  ld c, a
  ; Clear bits where mask was 1
  and c
  
  ; Restore original mask and desired values
  ld c, b
  ; Set new bits where mask is 1
  or b
  
  ; Save and output new state
  ld (SPI_OUTPUT_STATE), a
  out (GPIO_OUT), a
  
  pop bc
  ret

; Begin SPI transaction (CS low)
_spi_select:
  push af
  push bc
  
  ; Clear CS bit while preserving others
  ; Mask for CS bit
  ld c, 1 << SPI_CS_BIT
  ; Want to set CS low
  xor a
  call _update_output
  
  pop bc
  pop af
  ret

; End SPI transaction (CS high)
_spi_deselect:
  push af
  push bc
  
  ; Set CS bit while preserving others
  ; Mask for CS bit
  ld c, 1 << SPI_CS_BIT
  ; Want to set CS high
  ld a, c
  call _update_output
  
  pop bc
  pop af
  ret

; Transfer one byte over SPI
; Input:
;   a - byte to send
; Output:
;   a - received byte
sonnet_spi_transfer:
  push bc
  push de
  
  ; Save byte to send
  ld d, a
  ; Initialize received byte
  ld e, 0
  ; 8 bits to transfer
  ld b, 8
  
_transfer_loop:
  ; Setup MOSI
  ; Get send byte
  ld a, d
  ; Move next bit to carry
  rlca
  ; Save remaining bits
  ld d, a
  
  ; Set MOSI state
  ; Mask for MOSI
  ld c, 1 << SPI_MOSI_BIT
  ; Assume MOSI low
  ld a, 0
  ; If carry clear, MOSI is low
  jr nc, _mosi_set
  ; If carry set, MOSI high
  ld a, c
_mosi_set:
  call _update_output
  
  ; Clock high
  ld c, 1 << SPI_SCK_BIT
  ld a, c
  call _update_output
  
  ; Sample MISO
  in a, (GPIO_IN)
  ; Test MISO bit
  bit SPI_MISO_BIT, a
  
  ; Store received bit
  ; Get previous bits
  ld a, e
  ; Shift left
  rlca
  ; If MISO was low, skip setting bit
  jr nc, _skip_bit
  ; Set bit 0 if MISO was high
  inc a
_skip_bit:
  ; Save received bits
  ld e, a
  
  ; Clock low
  ld c, 1 << SPI_SCK_BIT
  ; SCK low
  xor a
  call _update_output
  
  djnz _transfer_loop
  
  ; Return received byte
  ld a, e
  
  pop de
  pop bc
  ret

; Write multiple bytes
; Input:
;   hl - source buffer
;   bc - number of bytes
sonnet_spi_write:
  push af
  push bc
  push hl
  
  call _spi_select
  
_write_loop:
  ; Get byte from buffer
  ld a, (hl)
  call sonnet_spi_transfer
  ; Next byte
  inc hl
  dec bc
  ld a, b
  or c
  jr nz, _write_loop
  
  call _spi_deselect
  
  pop hl
  pop bc
  pop af
  ret

; Read multiple bytes
; Input:
;   hl - destination buffer
;   bc - number of bytes
sonnet_spi_read:
  push af
  push bc
  push hl
  
  call _spi_select
  
_read_loop:
  ; Send zeros while reading
  xor a
  call sonnet_spi_transfer
  ; Store received byte
  ld (hl), a
  ; Next position
  inc hl
  dec bc
  ld a, b
  or c
  jr nz, _read_loop
  
  call _spi_deselect
  
  pop hl
  pop bc
  pop af
  ret

; Variables section for ROM compatibility
; Current state of output port
SPI_OUTPUT_STATE: db 0x00
