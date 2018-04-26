#!/bin/ash
until nc -z mongodb1 27017
do
	echo "Waiting for mongodb1 startup"
    sleep 2
done