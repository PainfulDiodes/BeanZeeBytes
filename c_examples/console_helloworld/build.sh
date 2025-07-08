# usage: 
# with or without extension
#  ./build.sh beanzee
#  ./build.sh beanzee.asm
# provide an org value
#  ./build.sh beanzee $8000
# defaults to 0x8000

# set -x #echo on
restart=0x0010
f=${1%.*} #extract base filename

if [ $# -gt 1 ]
then # target,org
    org=$2
else # target
    org=0x8000
fi

zcc +z80 -clib=classic main.c ../lib/$f.asm -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$restart -create-app -m -Cz--ihex -o=output/$f.o
z88dk-dis -o $org -x output/$f.map -x ../lib/$f.map output/$f.bin >output/$f.dis