#!/bin/bash

cd ../database

PS3="Please enter a number: "

echo "Select database to drop"

array=($(ls -F | grep / | tr / " "))

select choice in ${array[*]}
do
    if [ -z "$REPLY" ] || ! [[ "$REPLY" =~ ^[0-9]+$ ]]; 
        then
        echo "Invalid input. Please enter a valid number."
        continue
    elif [ $REPLY -gt ${#array[*]} ]
        then
        echo "$REPLY do not exist"
        continue
    else
        rm -r "${array[$REPLY-1]}"
        echo "Your ${array[${REPLY}-1]} database deleted successfully."
        break 2
    fi
done        
cd - &>~/../../dev/null
