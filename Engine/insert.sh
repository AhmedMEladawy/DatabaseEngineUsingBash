#!/bin/bash
source ../../engine/helper.sh

table_name=$(select_table "${tables[@]}")

echo $table_name
column_names=($(get_column_names "${table_name}"))
column_types=($(get_column_types "${table_name}"))
insert_value=($(insert_value_with_validation "${column_names}" "${column_types}"))

echo ${insert_value%,} >> $table_name
echo "Row inserted sucessfully:" ${insert_value%,}
