#!/bin/bash

let max=0

for arg in "$@";do 
    if [ $arg -gt $max ];then
        max=$arg
    fi
done 

echo "largest number is : " $max
