; readchar
; get a character from the UM245R console without waiting 
; if there is no data, return 0
; NOTE this needs to be moved into MARVIN

UM245R_CTRL equ 0          ; serial control port
UM245R_DATA equ 1          ; serial data port


PUBLIC readchar
PUBLIC _readchar

readchar:
_readchar:
    in a,(UM245R_CTRL)      ; get the USB status
    bit 1,a                 ; data to read? (active low)
    jr nz,readcharnodata    ; no, the buffer is empty
    in a,(UM245R_DATA)      ; yes, read the received char
    ld h,0                  ; return the result in hl
    ld l,a
    ret 
readcharnodata:
    ld hl,0
    ret
