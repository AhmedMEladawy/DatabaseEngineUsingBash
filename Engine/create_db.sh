#!/bin/bash

cd ../database


while true
do 
# Read Input
echo "Write your database name"
read db_name

#Validate Input
case $db_name in
# Name is Empty
' ' )
echo "The name can't be empty"
    continue ;;


# If the name includes Spaces, it won't be allowed
*[[:spaces:]] | *[[:space:]]* | [[:space:]]** )
    echo "Name can't have spaces"
    continue ;;
    [0-9]* )
    echo "The name can't begin with a number"
    continue ;;
    
    *[a-zA-z_]*[a-zA-z_] | [a-zA-z_] )
    if (
        find $db_name `ls -F | grep /` &> ~/../../dev/null
        )
        then 
        echo "Sorry, a database with the same name already exists"
        continue
    else
    mkdir $db_name
    break
    fi;;
    * )
    echo "Write a valid name"
    continue;;
esac
done


cd &> ~/../../dev/null
