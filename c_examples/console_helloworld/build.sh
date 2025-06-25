# usage: ./build.sh target
# e.g.:  ./build.sh beanzee
#        ./build.sh beanboard.asm

set -x #echo on

t=${1%.*} #extract base filename

f="helloworld"
target="../lib/$t.asm"
org=0x8000
reset=0x0000

zcc +z80 -clib=classic $f.c $target -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$reset -create-app -m -Cz--ihex -o=$f.o
