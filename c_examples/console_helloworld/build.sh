# usage: 
#  ./build.sh $8000
# defaults to 0x8000
#  ./build.sh

# set -x #echo on
restart=0x0010

if [ $# -gt 0 ]
then
    org=$1
else # target
    org=0x8000
fi

f=beanboard

zcc +z80 -clib=classic main.c ../lib/$f.asm -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$restart -create-app -m -Cz--ihex -o=output/$f.o
z88dk-dis -o $org -x output/$f.map -x ../lib/$f.map output/$f.bin >output/$f.dis

f=beanzee

zcc +z80 -clib=classic main.c ../lib/$f.asm -pragma-define:CRT_ORG_CODE=$org -pragma-define:CRT_ON_EXIT=$restart -create-app -m -Cz--ihex -o=output/$f.o
z88dk-dis -o $org -x output/$f.map -x ../lib/$f.map output/$f.bin >output/$f.dis
