#!/usr/bin/env bash
org=${1:-0x8000}
marvin_warmstart=0x0040

zcc +z80 -clib=classic main.c marvin.asm \
    -pragma-define:CRT_ORG_CODE=$org \
    -pragma-define:CRT_ON_EXIT=$marvin_warmstart \
    -create-app -m -Cz--ihex -o=output/main.bin
z88dk-dis -o $org -x output/main.map -x marvin.inc \
    output/main.bin > output/main.dis
