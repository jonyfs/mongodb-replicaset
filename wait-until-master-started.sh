#!/bin/ash
# Wait for mongodb to elect a primary
(mongo --host mongodb1 --eval 'rs.isMaster().ismaster'|grep true > /dev/null)
while [ $? != 0 ] ; do
	echo "Waiting for mongodb to elect a primary."
	sleep 2
	(mongo --quiet --eval 'rs.isMaster().ismaster'|grep true > /dev/null)
done
echo "The primary is elected."