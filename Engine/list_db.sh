#!/bin/bash

echo "----------Already existing databases----------"

cd ../database
ls -F | grep / | tr / " "

cd &>~/../../dev/null
