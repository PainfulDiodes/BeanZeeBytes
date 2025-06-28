# usage: 
# with or without extension
#  ./build.sh beanzee
#  ./build.sh beanzee.asm
# provide an org value
#  ./build.sh beanzee $8000
# defaults to 0x8000

set -x #echo on

org=0x8000
reset=0x0000
f=${1%.*} #extract base filename
target="../lib/$f.asm"

if [ $# -gt 1 ]
then
    zcc +z80 -clib=classic main.c $target -pragma-define:CRT_ORG_CODE=$2 -pragma-define:CRT_ON_EXIT=$reset -create-app -m -Cz--ihex -o=$f.o
else
    zcc +z80 -clib=classic main.c $target -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$reset -create-app -m -Cz--ihex -o=$f.o
fi
