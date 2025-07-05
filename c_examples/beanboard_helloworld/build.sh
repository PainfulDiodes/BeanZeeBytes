# usage: 
# with or without extension
#  ./build.sh beanzee
#  ./build.sh beanzee.asm
# provide an org value
#  ./build.sh beanzee $8000
# defaults to 0x8000

# set -x #echo on

org=0x8000
restart=0x0010
f=${1%.*} #extract base filename
target="../lib/$f.asm"

if [ $# -gt 1 ]
then
    zcc +z80 -clib=classic main.c $target -pragma-define:CRT_ORG_CODE=$2 -pragma-define:CRT_ON_EXIT=$restart -create-app -m -Cz--ihex -o=output/$f.o --list
else
    zcc +z80 -clib=classic main.c $target -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$restart -create-app -m -Cz--ihex -o=output/$f.o --list
fi
