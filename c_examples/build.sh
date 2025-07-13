if [[ $# -gt 0 ]]
then
    org=$1
else
    org=0x8000
fi

for dir in ${PWD}/*; do  
    if [ -d "$dir/output" ]; then
        echo $dir
        cd $dir && ./build.sh $org
    fi
done