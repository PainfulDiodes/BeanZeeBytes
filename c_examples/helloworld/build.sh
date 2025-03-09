set -x #echo on

f="helloworld"
marvin="../lib/marvin.asm"
org=0x8000
reset=0x0000

zcc +z80 -clib=classic $f.c $marvin -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$reset -create-app -m -Cz--ihex -o=$f.o
