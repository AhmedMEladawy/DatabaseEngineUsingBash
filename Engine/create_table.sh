#!/bin/bash

echo "----------Already Existing Tables----------"

ls -p | grep -v /

# Let the user create a valid table name that does not exist in the list of tables
while true; do
    # Read the input
    read -p "Enter your table name to create it: " table_name

    case $table_name in
        # Name cannot be empty
        '' )
            echo "The name can not be empty"
            continue;;
        *[[:space:]] | *[[:space:]]* | [[:space:]]* )
            echo "The name of the table can not include spaces"
            continue;;
        [0-9]* )
            echo "The name can not start with numbers"
            continue;;
        *[a-zA-z_]*[a-zA-z_] | [a-zA-z_] )
            if [ -e "$table_name" ]; then
                echo "Error: Table '$table_name' already exists."
                continue
            else
                touch "$table_name"
            fi
            echo "Table was created successfully"
            break;;
        * )
            echo "Please type a valid name"
            continue;;
    esac
done


# Read the number of fields
while true; do
    read -p "Insert number of fields for $table_name table: " fields_num

    case $fields_num in
        *[0] )
            echo "Number of table fields can't be $fields_num"
            continue;;
        *[1-9] | *[1-9]*[0-9] )
            echo "Number of table fields is $fields_num"
            break;;
        * )
            echo "Write a valid number"
            continue;;
    esac
done

# Insert Column Names
let fields_num=fields_num
echo "Insert your metadata for $table_name"
echo "Insert your column names"
echo "Field number 1 is the Primary Key"

column_names="id"

for ((i=2; i<=$fields_num; i++)); do
    # Read Input
    read -p "Enter column number $i name: " input_column_name

    case $input_column_name in
        '' )
            echo "Name can't be empty"
            continue;;
        *[[:space:]]* )
            echo "The name of the column can not include spaces"
            continue;;
        [0-9]* )
            echo "The name can not start with numbers"
            continue;;
        *[a-zA-z_]*[a-zA-z_] | [a-zA-z_] )
            if [ -e "$input_column_name" ]; then
                echo "Error: Column '$input_column_name' already exists."
                continue
            else
                column_names+=","$input_column_name
            fi
            ;;
        * )
            echo "Please type a valid name, it can't have any special characters"
            continue;;
    esac
done


# Insert data type
echo "Insert column types"
echo "Field num 1 is Integer"

column_types="integer"

for ((i=2; i<=$fields_num; i++)); do
    echo "Type your choice for field $i: "

    # Only string and integer support
    select choice in string integer; do
        case $choice in 
            string )
                echo "string"
                    column_types+=",string"
                break;;
            integer )
                echo "integer"
                    column_types+=",integer"
                break;;
            * ) 
                echo "Only 1 and 2 are available"
                continue;;
        esac
    done
done

mkdir -p ./metadata
echo "$column_names" >> "./metadata/$table_name"
echo "$column_types" >> "./metadata/$table_name"
echo "Your table metadata is:"
echo "$column_names"
echo "$column_types"
