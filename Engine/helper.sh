
tables=(`ls -p | grep -v /`)

select_table() {
    echo "-----Select your table number from the list-----" >&2
    select choice in "${tables[@]}"
    do
        if [ "$REPLY" -gt "${#tables[@]}" ]
        then
            echo "$REPLY is not on the list" >&2
            continue
        else
            echo "You selected ${tables[$((REPLY-1))]} table" >&2
            table_name=${tables[$((REPLY-1))]}
            break
        fi
    done
    echo $table_name
}

get_column_names(){
    read -r column_names < ./metadata/$table_name
    IFS=',' read -r -a split_column_names <<< "$column_names"
    echo ${split_column_names[@]}
}

get_column_types(){
    column_types=$(sed -n '2p' ./metadata/$table_name)
    IFS=',' read -r -a split_column_types <<< "$column_types"
    echo ${split_column_types[@]}
}

select_column() {
    echo "-----Which column would you like to fitler by?-----" >&2
    select choice in ${column_names[*]}
    do
        if [ $REPLY -gt ${#column_names[*]} ]
        then
        echo "$REPLY is not on the list" >&2
        continue
        else
        echo "You will filter by ${column_names[${REPLY}-1]} column" >&2
        filter_column=${column_names[${REPLY}-1]}
        filter_index=$(($REPLY-1))
        break
        fi
    done
    echo $filter_column
    echo $filter_index
}

insert_value_with_validation(){

    insert_value=""

    for ((i=0; i<${#column_names[@]}; ++i)); do
        name=${column_names[i]}
        type=${column_types[i]}

        while true; do
            read -p "Column Name: $name, Column Type: $type, Insert value: " input_value
            case $type in
                string)
                    if [[ $input_value =~ ^[a-zA-Z]*$ ]]; then
                        break
                    else
                        echo "Invalid input. Please enter a string." >&2
                    fi
                    ;;
                integer)
                    if [[ $input_value =~ ^-?[0-9]+$ ]]; then
                        break
                    else
                        echo "Invalid input. Please enter an integer." >&2
                    fi
                    ;;
                *)
                    echo "Please try again." >&2
                    ;;
            esac
        done

        insert_value+=$input_value","
    done
    echo $insert_value
}