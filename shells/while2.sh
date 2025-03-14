#!/bin/bash

a=1

while [ $a != "0" ]; do
    echo -n "Input(0:Exit) : "
    read a
    if [ $a -eq 0 ]; then
    elif [ $a -ge 2 -a $a -le 9 ]; then
        if [ $a != "0" ]; then
            for ((k=1;k<=9;k++))
            do
                echo "$a * $k = `expr $a \* $k `"
            done
        fi
    else
        echo "The number of inputs must be between 2 to 9."
    fi
done
echo Exit
