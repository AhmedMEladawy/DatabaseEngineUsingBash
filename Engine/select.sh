#!/bin/bash
source ../../engine/helper.sh

table_name=$(select_table "${tables[@]}")
read -p "Please enter the number of records you would like to select: " number_of_records
# table_data=$(head -n $number_of_records $table_name)
table_data=$(cat $table_name)

column_names=($(get_column_names "${table_name}"))
column_types=($(get_column_types "${table_name}"))

selected_column=($(select_column "${column_names[@]}"))
filter_column=${selected_column[0]}
filter_index=${selected_column[1]}
read -p "Please enter value for ${filter_column} to filter_by: " filter_value


IFS=$'\n'
for record in ${table_data[@]}
do
    IFS=','
    read -r -a fields <<< "$record"
    if [[ "${fields[$filter_index]}" == "$filter_value" ]]; then
    echo $record
    ((number_of_records-=1))
    fi
    if [[ $number_of_records -le 0 ]]; then
        break
    fi
done
