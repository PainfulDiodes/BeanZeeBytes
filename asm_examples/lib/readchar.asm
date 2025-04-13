; readchar
; get a character from the UM245R console without waiting 
; if there is no data, return 0
; NOTE this needs to be moved into MARVIN

readchar:
    in a,(UM245R_CTRL)          ; get the USB status
    bit 1,a                     ; data to read? (active low)
    jr nz,readcharnodata        ; no, the buffer is empty
    in a,(UM245R_DATA)          ; yes, read the received char
    ret 
readcharnodata:
    ld a,0                      ; if there's no data, return 0
    ret

