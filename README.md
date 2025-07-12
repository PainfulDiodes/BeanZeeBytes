# BeanZeeBytes
Example programs for the [BeanZee](https://github.com/PainfulDiodes/BeanZee) Z80 development board, running [Marvin](https://github.com/PainfulDiodes/marvin) monitor.

Written for BeanZee v1, BeanBoard v1 and Marvin v1.2.1

Marvin can interpret Intel HEX format inputs to load machine code programs into RAM. 

BeanZeeBytes example programs have been prepared using the [Z88DK](https://github.com/z88dk/z88dk):

> Z88DK is a collection of software development tools that targets the 8080 and z80 family of machines. It allows development of programs in C, assembly language or any mixture of the two. What makes z88dk unique is its ease of use, built-in support for many z80 machines and its extensive set of assembly language library subroutines implementing the C standard and extensions.

Examples are provided in C and Z80 assembly.

The easiest way to build these programs is to install an use the Z88DK toolchain and generate Intel HEX files. MacOS shell scripts are provided to build the programs using Z88DK (but may give some indication of what is needed for other environments).

Intel HEX files (with an .ihx extension) are also provided so that you can load and run them on BeanZee "as is" without needing to build them. These will be different for each hardware target, and  ihx files are provided for the beanzee and beanboard Marvin builds.

Use your terminal emulator to send the ihx file to BeanZee, and then run the program using the Marvin eXecute command, providing the load address (which defaults to 0x8000), e.g. 

    x8000

You may omit the 8000, as eXecute without an address will execute from the beginning of user RAM (RAMSTART) which is 0x8000, the default for loading programs into RAM.