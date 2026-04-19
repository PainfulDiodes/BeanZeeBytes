#!/usr/bin/env bash
org=${1:-0x8000}
z88dk-z80asm -l -b -m -DORGDEF=$org main.asm -Ooutput
z88dk-appmake +hex --org $org -b output/main.bin -o output/main.ihx
