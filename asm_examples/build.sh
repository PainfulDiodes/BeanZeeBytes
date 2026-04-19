#!/usr/bin/env bash
for dir in ${PWD}/*; do  
    if [ -f "$dir/build.sh" ]; then
        echo $dir $@
        cd $dir && ./build.sh $@
    fi
done