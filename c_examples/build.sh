for dir in ${PWD}/*; do  
    if [ -d "$dir/output" ]; then
        echo $dir $@
        cd $dir && ./build.sh $@
    fi
done