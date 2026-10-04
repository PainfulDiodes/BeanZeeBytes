#!/usr/bin/env bash
z88dk-z80asm -l -b -m main.asm -Ooutput
z88dk-dis output/main.bin > output/main.dis
