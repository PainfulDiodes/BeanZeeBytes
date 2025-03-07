# BeanZeeBytes
Example programs for the [BeanZee](https://github.com/PainfulDiodes/BeanZee) Z80 development board, running [Marvin](https://github.com/PainfulDiodes/marvin) monitor.

Written for BeanZee 1.0 and Marvin 1.0.1

Marvin can interpret Intel HEX format inputs to load programs into RAM. Programs can be built from Z80 assembly language, or a higher-level language like C.

BeanZeeBytes example programs have been prepared using the [Z88DK](https://github.com/z88dk/z88dk) development kit in Z80 assembly and C:

> Z88DK is a collection of software development tools that targets the 8080 and z80 family of machines. It allows development of programs in C, assembly language or any mixture of the two. What makes z88dk unique is its ease of use, built-in support for many z80 machines and its extensive set of assembly language library subroutines implementing the C standard and extensions.

The easiest way to **build** these programs is to install an use the Z88DK tool chain and generate Intel HEX files. Shell scripts are provided to build the programs using Z88DK. 

However, Intel HEX files (with an .ihx extension) are also provided so that you can load and run them "as is" without needing to build them.

Use your terminal emulator to send the ihx file to BeanZee, and then run the program using the Marvin eXecute command, providing the load address (which defaults to 0x8000), e.g. 

    x8000

