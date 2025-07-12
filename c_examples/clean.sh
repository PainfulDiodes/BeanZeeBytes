for dir in ${PWD}/*; do  
    if [ -d "$dir/output" ]; then
        echo $dir
        rm -f $dir/output/*
    fi
done