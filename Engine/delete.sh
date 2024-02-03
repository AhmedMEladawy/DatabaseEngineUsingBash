#!/bin/bash
source ../../engine/helper.sh



table_name=$(select_table "${tables[@]}")
read -p "Enter the number of records to delete: " number_records

if [[ ! "$number_records" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Please enter a valid positive integer."
fi

# '' for MacOS, it's optional on Linux
sed -i '' "1,${number_records}d" ${table_name}
echo "Deleted $number_records records from $table_name."
