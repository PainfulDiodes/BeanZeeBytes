set -x #echo on

f="snake"
marvin="../lib/marvin.asm"
org=0x8000
reset=0x0000

zcc +z80 -clib=classic $f.c $marvin -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$reset -pragma-define:REGISTER_SP=0x0000 -create-app -m -Cz--ihex -o=$f.o
