# BeanBoard keyscan
Assembled with z88dk-z80asm  
Tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

Interacting with the BeanBoard keyboard at a low level: send a row bit and then read back column bits. The example code prints both the column and row values to the console in hexadecimal (it will exit the program when the "Esc" is pressed, and so you won't see the hex output for this key).
