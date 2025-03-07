include "../lib/marvin.asm"     ; load all the definitions needed to interact with the monitor program

org RAMSTART                    ; this is the default location for a BeanZee standalone assembly program 

start:
    ld hl,message               ; load the message address into HL
print:
    call puts                   ; call the monitor puts routine, which will print the message pointed to by HL
wait:
    call getchar                ; call the monitor getchar to get a character from the console input
                                ; it will wait until a character is received
end:
    jp RESET                    ; jump to the reset address - will jump back to the monitor

message: 
    db "\nHello world!\n\n",0   ; message to be printed - must be terminated by a 0
