; memory map
RAMSTART equ 0x8000

; port map
UM245R_CTRL equ 0               ; serial control port
UM245R_DATA equ 1               ; serial data port
KBD_PORT    equ 2               ; either 2 or 3 will work
LCD_CTRL    equ 4               ; LCD control port
LCD_DATA    equ 5               ; LCD data port
