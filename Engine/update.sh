#!/bin/bash
source ../../engine/helper.sh

table_name=$(select_table "${tables[@]}")
table_data=$(cat $table_name)

column_names=($(get_column_names "${table_name}"))
column_types=($(get_column_types "${table_name}"))

selected_column=($(select_column "${column_names[@]}"))
filter_column=${selected_column[0]}
filter_index=${selected_column[1]}
read -p "Please enter value for ${filter_column} to filter_by: " filter_value

insert_value=($(insert_value_with_validation "${column_names}" "${column_types}"))

tmp_file=$(mktemp)

IFS=$'\n'
for record in ${table_data[@]}
do
    IFS=','
    read -r -a fields <<< "$record"
    if [[ "${fields[$filter_index]}" == "$filter_value" ]]; then
        echo "${insert_value%,}" >> $tmp_file
    else
        echo "$record" >> $tmp_file

    fi
done

mv "$tmp_file" "$table_name"
echo "Table updated sucessfully"
