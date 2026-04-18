#!/usr/bin/env bash
org=${1:-0x8000}

zcc +z80 -clib=classic main.c ../lib/beanboard.asm \
    -pragma-define:CRT_ORG_CODE=$org \
    -pragma-define:CRT_ON_EXIT=0x0040 \
    -create-app -m -Cz--ihex -o=output/beanboard.bin
z88dk-dis -o $org -x output/beanboard.map -x ../../lib/marvin.inc \
    output/beanboard.bin > output/beanboard.dis

zcc +z80 -clib=classic main.c ../lib/beanzee.asm \
    -pragma-define:CRT_ORG_CODE=$org \
    -pragma-define:CRT_ON_EXIT=0x0040 \
    -create-app -m -Cz--ihex -o=output/beanzee.bin
z88dk-dis -o $org -x output/beanzee.map -x ../../lib/marvin.inc \
    output/beanzee.bin > output/beanzee.dis
