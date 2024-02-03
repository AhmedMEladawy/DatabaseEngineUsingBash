#!/bin/bash
source ../../engine/helper.sh

table_name=$(select_table "${tables[@]}")
rm "$table_name"
rm "./metadata/$table_name"
echo "$table_name deleted successfully."