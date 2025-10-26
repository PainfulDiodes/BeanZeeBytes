# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BeanZeeBytes contains example programs for the BeanZee Z80 development board running the Marvin monitor. Programs are written in Z80 assembly and C, compiled using the Z88DK toolchain to Intel HEX format (.ihx files) that can be loaded into RAM and executed on the BeanZee hardware.

**Hardware targets:**
- BeanZee v1 (base board with USB console)
- BeanBoard v1 (expansion board with LCD, GPIO, keymatrix)
- Marvin v1.2.1 monitor (beanboard and beanzee builds)

## Build System

### Building All Examples

```bash
# Build all examples (both assembly and C)
./build.sh

# Build only assembly examples
cd asm_examples && ./build.sh

# Build only C examples
cd c_examples && ./build.sh

# Clean all build outputs
./clean.sh
```

### Building Individual Examples

Each example directory contains its own `build.sh` script that builds for both hardware targets:

```bash
# From any example directory (e.g., c_examples/console_helloworld)
./build.sh              # Build for both beanboard and beanzee
./build.sh beanboard    # Build only for beanboard target
./build.sh beanzee      # Build only for beanzee target

# Optionally specify org address (defaults to 0x8000)
./build.sh beanboard 0x8000
```

Build scripts are nested hierarchically:
- Root `build.sh` → calls both `asm_examples/build.sh` and `c_examples/build.sh`
- Language-level `build.sh` → iterates through each example directory
- Example-level `build.sh` → calls `lib/build.sh` for each target

### Build Output

Each example generates output in its `output/` directory:
- `.ihx` - Intel HEX format, ready to load on hardware
- `.bin` - Raw binary
- `.map` - Symbol map
- `.dis` - Disassembly (C examples only)
- `.hex` - Hexdump (assembly examples only)

## Architecture

### Library Structure

**`lib/`** (shared by both C and assembly examples):
- `beanboard.map` - Symbol map for BeanBoard hardware (LCD, GPIO, keymatrix)
- `beanzee.map` - Symbol map for BeanZee base hardware (USB console only)
- `extra.map` - Additional definitions not in the Marvin map files

**`c_examples/lib/`**:
- `marvin.h` / `marvin.asm` - C interface to Marvin monitor functions (stdio overrides, console I/O)
- `beanboard.h` / `beanboard.asm` - C interface to BeanBoard hardware (LCD, GPIO, keymatrix)
- `beanzee.asm` - Includes marvin.asm with beanzee.map symbols
- `build.sh` - Core build script for C programs using Z88DK

**`asm_examples/lib/`**:
- `build.sh` - Core build script for assembly programs using z88dk-z80asm

### Hardware Abstraction

Programs target specific hardware builds:
- **beanzee**: Base BeanZee board with USB console only (uses `beanzee.map`)
- **beanboard**: BeanBoard expansion with LCD, GPIO, and keymatrix (uses `beanboard.map`)

Each example builds separate binaries for each target, located in `output/<target>.ihx`.

### Marvin Monitor Integration

Programs interface with the Marvin monitor ROM routines:
- **Console I/O**: `getchar`, `putchar`, `puts`, `readchar` (non-blocking)
- **Return to monitor**: Jump to `WARMSTART` (0x0010) when done
- **Load address**: Default is `RAMSTART` (0x8000)
- **CRT settings** (C programs): `CRT_ORG_CODE` sets load address, `CRT_ON_EXIT` jumps to monitor

### C Program Structure

C programs override Z88DK's default console functions to use Marvin's I/O routines:
1. Include `marvin.h` for stdio overrides
2. Include `beanboard.h` for LCD/GPIO access (BeanBoard targets)
3. Compiled with `zcc +z80 -clib=classic` and custom CRT pragmas
4. Linked with target-specific `.asm` file (`beanboard.asm` or `beanzee.asm`)

### Assembly Program Structure

Assembly programs follow this pattern:
1. Include target-specific `.asm` file (`beanboard.asm` or `beanzee.asm`) to pull in symbol maps
2. Call Marvin monitor routines directly (symbols from `.map` files)
3. Jump to `WARMSTART` to return to monitor
4. Compiled with `z88dk-z80asm` using `ORGDEF` to set load address

## Development Workflow

### Adding a New Example

1. Create directory in `asm_examples/` or `c_examples/` with descriptive name
2. Create `output/` subdirectory (required for build scripts to detect the example)
3. Copy `build.sh` from existing example
4. For assembly: Create `.asm` source files (see `console_helloworld/main.asm`)
5. For C: Create `.c` source files and include appropriate headers (see `console_helloworld/main.c`)
6. Build from example directory or root

### BeanBoard-Specific Examples

BeanBoard examples use LCD, GPIO, or keymatrix hardware:
- Call `marvin_lcd_init()` before using LCD
- Call `marvin_lcd_init()` again before returning to monitor to reset LCD
- Use constants from `beanboard.h` for LCD commands
- GPIO and keymatrix accessed via `marvin_gpio_*` and `marvin_keyscan_*` functions

## Z88DK Toolchain Commands

The build system relies on these Z88DK commands:
- `zcc` - C compiler driver
- `z88dk-z80asm` - Z80 assembler
- `z88dk-appmake` - Generate Intel HEX from binary
- `z88dk-dis` - Disassembler

## Testing on Hardware

1. Use terminal emulator to send `.ihx` file to BeanZee
2. Execute with Marvin's eXecute command: `x8000` (or just `x` for default load address)
3. Program runs and returns to Marvin prompt when done
