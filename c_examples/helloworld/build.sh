#!/usr/bin/env bash
org=${1:-0x8000}

zcc +z80 -clib=classic main.c marvin.asm \
    -pragma-define:CRT_ORG_CODE=$org \
    -pragma-define:CRT_ON_EXIT=0x0040 \
    -create-app -m -Cz--ihex -o=output/main.bin
z88dk-dis -o $org -x output/main.map -x ../../lib/marvin.inc \
    output/main.bin > output/main.dis
