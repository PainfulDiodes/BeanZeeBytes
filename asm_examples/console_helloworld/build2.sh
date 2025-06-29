# experimental build script using zcc rather than calling the tools directly

# usage: 
# with or without extension
#  ./build.sh beanzee
#  ./build.sh beanzee.asm
# provide an org value
#  ./build.sh beanzee $8000
# defaults to 0x8000

set -x #echo on

org=0x8000
f=${1%.*} #extract base filename

if [ $# -gt 1 ]
then
    # z88dk-z80asm -l -b -m -DORGDEF=$2 $f.asm -Ooutput
    # z88dk-appmake +hex --org $2 -b output/$f.bin -o output/$f.ihx
    zcc +z80 $f.asm --no-crt -create-app -m --list -Ca-DORGDEF=$2 -Cz--org=$2 -Cz--ihex -o=output/$f.bin
    hexdump -C output/$f.bin > output/$f.hex
else
    # z88dk-z80asm -l -b -m -DORGDEF=$org $f.asm -Ooutput
    # z88dk-appmake +hex --org $org -b output/$f.bin -o output/$f.ihx
    zcc +z80 $f.asm --no-crt -create-app -m --list -Ca-DORGDEF=$org -Cz--org=$org -Cz--ihex -o=output/$f.bin
    hexdump -C output/$f.bin > output/$f.hex
fi
