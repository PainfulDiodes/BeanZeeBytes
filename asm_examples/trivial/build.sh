#!/usr/bin/env bash
z88dk-z80asm -l -b -m main.asm -Ooutput
z88dk-dis -x output/main.map -o 0x8000 output/main.bin > output/main.dis
