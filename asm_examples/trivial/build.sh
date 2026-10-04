#!/usr/bin/env bash
z88dk-z80asm -l -b -m main.asm -Ooutput
z88dk-appmake +hex --org 0x8000 -b output/main.bin -o output/main.ihx
z88dk-dis output/main.bin > output/main.dis
