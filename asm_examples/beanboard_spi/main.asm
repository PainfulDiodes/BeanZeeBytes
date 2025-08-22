start:
    ld hl,start_message
	call puts
loop:
    ; first char
    call getchar
    call putchar
    ; escape?
    cp '\e'
    jr z,end
    ld b,a
    ; second char
    call getchar
    call putchar
    ; escape?
    cp '\e'
    jr z,end
    call ConvertAsciiHexToBin
    out (GPIO_OUT),a
    call putchar
    ; add a line break at the console
    ld a,'\n'
    call putchar
    ; repeat
    jr loop
end:
    ; add a line break at the console
    ld a,'\n'
    call putchar
    ; jump to the reset address - will jump back to the monitor
    jp WARMSTART

start_message: 
    db "Take ASCII hex pairs from console and sent binary to GPIO\n",0

; Converts two ASCII hex chars: B (high nibble), A (low nibble) to a single byte in A
; Input:  B = ASCII hex (high nibble), A = ASCII hex (low nibble)
; Output: A = combined binary byte

ConvertAsciiHexToBin:
    push bc             ; Save BC
    ld c, a             ; Save low nibble (A) in C

    ; Convert high nibble in B
    ld a, b
    call ConvertNibble  ; Result in A
    rlca                ; Shift left 4 bits
    rlca
    rlca
    rlca
    ld b, a             ; Store high nibble in B

    ; Convert low nibble in C
    ld a, c
    call ConvertNibble  ; Result in A

    ; Combine nibbles
    or b                ; A = (high << 4) | low

    pop bc              ; Restore BC
    ret

; --- Helper: Convert ASCII hex in A to binary nibble (0-15) ---
ConvertNibble:
    cp '0'
    jr c, InvalidNibble
    cp '9'+1
    jr c, IsDigit
    cp 'A'
    jr c, InvalidNibble
    cp 'F'+1
    jr c, IsUpper
    cp 'a'
    jr c, InvalidNibble
    cp 'f'+1
    jr nc, InvalidNibble
    sub 'a'-10
    ret
IsDigit:
    sub '0'
    ret
IsUpper:
    sub 'A'-10
    ret
InvalidNibble:
    xor a
    ret


