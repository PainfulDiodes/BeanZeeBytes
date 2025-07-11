# usage: 
# provide an org value
#  ./build.sh $8000
# defaults to 0x8000
#  ./build.sh

# set -x #echo on

if [ $# -gt 0 ]
then
    org=$1
else
    org=0x8000
fi

f=beanboard

z88dk-z80asm -l -b -m -DORGDEF=$org $f.asm -Ooutput
hexdump -C output/$f.bin > output/$f.hex
z88dk-appmake +hex --org $org -b output/$f.bin -o output/$f.ihx
