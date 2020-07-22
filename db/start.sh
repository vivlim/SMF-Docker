#!/bin/bash

mysqld &
pid=$!

#wait for socket to exist
while [ ! -f /var/run/mysqld/mysqld.sock ]; do echo "Waiting for mysqld socket..."; sleep 1; done

for i in `ls /in/*.create`
do
    dbname=${i%.create}
    echo "Creating database $i"
    mysql < $dbname.create
    echo "Importing data for $i"
    mysql -p $dbname < $dbname.sql
done;

wait $pid
