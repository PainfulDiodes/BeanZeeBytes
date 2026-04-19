# BeanZeeBytes

Example programs for the [BeanZee](https://github.com/PainfulDiodes/BeanZee) Z80 development board, running [Marvin](https://github.com/PainfulDiodes/marvin) monitor.

Written for Marvin v1.3 with BeanZee v1, BeanBoard v1, BeanBoardSPI v1.

Marvin can interpret Intel HEX format inputs to load machine code programs into RAM, making it possible to load an machine code program via a console emulator over the BeanZee USB interface.

BeanZeeBytes example programs have been prepared using the [Z88DK](https://github.com/z88dk/z88dk):

> Z88DK is a collection of software development tools that targets the 8080 and z80 family of machines. It allows development of programs in C, assembly language or any mixture of the two. What makes z88dk unique is its ease of use, built-in support for many z80 machines and its extensive set of assembly language library subroutines implementing the C standard and extensions.

Examples are provided in C and Z80 assembly.

## Building

Install the Z88DK toolchain, then:

```bash
./build.sh          # build all examples
./clean.sh          # remove build outputs
```

Or build a single example:

```bash
cd asm_examples/console_helloworld
./build.sh
```

## Assembly examples

Each assembly example is self-contained. It includes `marvin.inc` (Marvin ABI — fixed ROM addresses for I/O functions) and `ports.inc` (hardware port assignments). The example builds a single binary that runs on all hardware targets.

```text
asm_examples/console_helloworld/
├── build.sh        # build script
├── clean.sh        # clean script - removes build output files
├── main.asm        # the example program
├── marvin.inc      # Marvin ABI constants
├── ports.inc       # Hardware port constants
└── output/
    ├── main.ihx    # Intel HEX — load and run on BeanZee
    └── ...
```

To use an example independently, copy the directory contents to your desired directory and run `./build.sh`

## C examples

Each C example is self-contained. It includes the same `marvin.inc` and `ports.inc` as the assembly examples, but also a `marvin.asm` file which patches the monitor into the z88dk C environment, and an accompanying `marvin.h` header.

Again, to use an example independently, copy the directory contents to your desired directory and run `./build.sh`

## Running on hardware

Use your terminal emulator to copy and paste the `.ihx` file content to BeanZee, then run the program using the Marvin eXecute command:

```text
x8000
```

`x` without an address executes from RAMSTART (0x8000), which is the default load address.
