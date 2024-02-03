#!/bin/bash


select choice in create_database list_database connect_database drop_database
do 
case $choice in
create_database )
    echo "Creating database"
    source ./create_db.sh
    ;;
    list_database )
    echo "Listing databases"
    source ./list_db.sh
    ;;
    connect_database )
    echo "Connecting database"
    source ./connect_db.sh
    ;;
    drop_database )
    echo "Dropping database"
    source ./drop_db.sh
    ;; 
    esac
done
