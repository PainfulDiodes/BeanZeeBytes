#!/usr/bin/env bash
for dir in ${PWD}/*; do  
    if [ -f "$dir/clean.sh" ]; then
        echo $dir
        cd $dir && ./clean.sh
    fi
done