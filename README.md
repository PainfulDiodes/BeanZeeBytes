# BeanZeeBytes

Example programs for the [BeanZee](https://github.com/PainfulDiodes/BeanZee) Z80 development board, running [Marvin](https://github.com/PainfulDiodes/marvin) monitor.

Written for BeanZee v1, BeanBoard v1, BeanBoardSPI v1 and Marvin v1.3.

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

Each assembly example is self-contained. It includes `marvin.inc` (Marvin ABI — fixed ROM addresses for I/O functions) and optionally `ports.inc` (BeanBoard port assignments). The example builds a single binary that runs on all hardware targets.

```text
lib
├── marvin.inc      # Marvin ABI constants
asm_examples/console_helloworld/
├── main.asm        # the example program
├── build.sh        # build script
└── output/
    ├── main.ihx    # Intel HEX — load and run on BeanZee
    └── ...
```

To use an example independently, copy its directory anywhere, copy in marvin.inc from the lib directory and run `./build.sh`

## C examples

C examples use a shared library in `c_examples/lib/` for the z88dk interface to Marvin I/O. Each example's `build.sh` is self-contained.

## Running on hardware

Use your terminal emulator to send the `.ihx` file to BeanZee, then run the program using the Marvin eXecute command:

```text
x8000
```

`x` without an address executes from RAMSTART (0x8000), which is the default load address.
