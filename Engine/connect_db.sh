#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR"


PS3="Please type a Number: "

echo "Select database to connect"
cd ../database

array=($(ls -F | grep / | tr / " "))

select choice in ${array[*]}
do
    if [ -z "$REPLY" ] || ! [[ "$REPLY" =~ ^[0-9]+$ ]]; 
        then
        echo "Invalid input. Please type a valid number."
        continue
    elif [ $REPLY -gt ${#array[*]} ]
        then
        echo "$REPLY do not exist"
        continue
    else    
        cd ../database/${array[${REPLY}-1]}
        echo "You are connectd to ${array[${REPLY}-1]} database"
        break
    fi
done
    echo
    PS3="Please type a Number: "

select choice in create_table list_table drop_table insert_into_table select_from_table delete_from_table update_from_table
do
    case $choice in
    create_table )
    echo "Creating table, please wait"
    source ../../engine/create_table.sh
    ;;
    list_table )
    echo "Listing tables, please wait"
    source ../../engine/list_table.sh
    ;;
    drop_table )
    echo "Dropping table, please wait"
    source ../../engine/drop_table.sh
    ;;
    insert_into_table )
    echo "Inserting in table, please wait"
    source ../../engine/insert.sh
    ;;
    select_from_table )
    echo "Selecting from table, please wait"
    source ../../engine/select.sh
    ;;
    delete_from_table )
    echo "Selecting from table, please wait"
    source ../../engine/delete.sh
    ;;
    update_from_table )
    echo "Selecting from table, please wait"
    source ../../engine/update.sh
    ;;
    *)
    "Not a choice, please try again"
    ;;
    esac
done

cd - &> ~/../../dev/null