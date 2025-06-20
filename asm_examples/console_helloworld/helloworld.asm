; load all the definitions needed to interact with the monitor program
include "../lib/marvin.inc"     
include "../lib/beanzee.inc"

; this is the default location for a BeanZee standalone assembly program 
org RAMSTART

start:
    ; load the message address into HL
    ld hl,message
print:
    ; call the monitor puts routine, which will print the message pointed to by HL
    call marvin_puts
wait:
    ; call the monitor getchar to get a character from the console input
    ; it will wait until a character is received
    call marvin_getchar
end:
    ; jump to the reset address - will jump back to the monitor
    jp MARVIN_START

message: 
    ; message to be printed 
    ; must be terminated by a 0
    db "Hello world!\n"     
    db "(hit any key)\n",0
