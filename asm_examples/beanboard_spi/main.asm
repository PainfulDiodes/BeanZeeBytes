start:
    ; Initialize SPI interface
    call spi_init
    
    ld hl,start_message
    call puts
loop:
    ; Print menu
    ld hl,menu_message
    call puts
    
    ; Get command
    call getchar
    call putchar
    
    ; Check command
    cp 'w'            ; Write command
    jr z,write_spi
    cp 'r'            ; Read command
    jr z,read_spi
    cp '\e'           ; Escape
    jr z,end
    
    ; Invalid command, show error
    ld hl,error_message
    call puts
    jr loop

write_spi:
    ; Get hex byte to write
    ld hl,write_prompt
    call puts
    
    ; first hex char
    call getchar
    call putchar
    cp '\e'
    jr z,end
    ld b,a
    
    ; second hex char
    call getchar
    call putchar
    cp '\e'
    jr z,end
    
    ; Convert ASCII hex to binary
    call convert_ascii_hex_to_bin
    
    ; Write to SPI
    call spi_select
    call spi_write
    call spi_deselect
    
    ; Show confirmation
    ld hl,write_done
    call puts
    jr loop

read_spi:
    ; Read from SPI
    call spi_select
    call spi_read
    call spi_deselect
    
    ; Save read value
    ld b,a
    
    ; Show read value
    ld hl,read_result
    call puts
    
    ; Convert to hex and display
    ld a,b
    call print_hex_byte
    
    ; New line
    ld a,'\n'
    call putchar
    jr loop

end:
    ; add a line break at the console
    ld a,'\n'
    call putchar
    ; jump to the reset address - will jump back to the monitor
    jp WARMSTART

; Print a byte as two hex characters
; Input: A = byte to print
print_hex_byte:
    push af
    srl a
    srl a
    srl a
    srl a
    call print_hex_digit
    pop af
    and $0F
    call print_hex_digit
    ret

; Print a single hex digit
; Input: A = value 0-15
print_hex_digit:
    cp 10
    jr nc,_print_hex_digit_letter
    add '0'
    jr _print_hex_digit_print
_print_hex_digit_letter:
    add 'A'-10
_print_hex_digit_print:
    jp putchar

start_message: 
    db "SPI Interface Test Program\n",0
menu_message:
    db "\nCommands: w=Write, r=Read, ESC=Exit\n",0
error_message:
    db "Invalid command\n",0
write_prompt:
    db "Enter byte to write (hex): ",0
write_done:
    db "\nByte written to SPI\n",0
read_result:
    db "Byte read from SPI: ",0

; Converts two ASCII hex chars: B (high nibble), A (low nibble) to a single byte in A
; Input:  B = ASCII hex (high nibble), A = ASCII hex (low nibble)
; Output: A = combined binary byte

convert_ascii_hex_to_bin:
    push bc             ; Save BC
    ld c, a             ; Save low nibble (A) in C

    ; Convert high nibble in B
    ld a, b
    call convert_nibble  ; Result in A
    rlca                ; Shift left 4 bits
    rlca
    rlca
    rlca
    ld b, a             ; Store high nibble in B

    ; Convert low nibble in C
    ld a, c
    call convert_nibble  ; Result in A

    ; Combine nibbles
    or b                ; A = (high << 4) | low

    pop bc              ; Restore BC
    ret

; --- Helper: Convert ASCII hex in A to binary nibble (0-15) ---
convert_nibble:
    cp '0'
    jr c, invalid_nibble
    cp '9'+1
    jr c, is_digit
    cp 'A'
    jr c, invalid_nibble
    cp 'F'+1
    jr c, is_upper
    cp 'a'
    jr c, invalid_nibble
    cp 'f'+1
    jr nc, invalid_nibble
    sub 'a'-10
    ret
is_digit:
    sub '0'
    ret
is_upper:
    sub 'A'-10
    ret
invalid_nibble:
    xor a
    ret


