#!/bin/ash
until nc -z mongodb1 27017
do
	echo "$(date) - Waiting for mongodb1 startup"
    sleep 2
done
echo "$(date) - The mongodb1 is started."