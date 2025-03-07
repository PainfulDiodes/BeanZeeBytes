# usage: 
# with or without extension
#  ./build.sh myprogram
#  ./build.sh myprogram.asm
# optionally provide a loading address (defaults to 0x8000)
#  ./build.sh myprogram 0x9000

set -x #echo on

f=${1%.*} #extract base filename
z88dk-z80asm -l -b $f.asm
hexdump -C $f.bin > $f.hex
if [ $# -gt 1 ]
then
    org=$2
else
    org=0x8000
fi
z88dk-appmake +hex --org $org -b $f.bin -o $f.ihx