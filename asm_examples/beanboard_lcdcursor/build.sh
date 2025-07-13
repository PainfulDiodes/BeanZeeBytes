#!/usr/bin/env bash

# usage: ./build.sh org
# e.g.:  ./build.sh 0x8000
# org is optional

if [[ $# -gt 0 ]]
then
    org=$1
fi

../lib/build.sh beanboard $org
