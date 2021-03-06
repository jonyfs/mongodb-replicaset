#!/bin/ash
# Wait for mongodb to elect a primary
while [ "$RESULT" != "true" ]; do
   RESULT=$(mongo --host mongodb1 --quiet --eval 'db.isMaster().ismaster');
   echo "$(date) - Is mongodb1 primary? $RESULT"
   sleep 5;
done
echo "$(date) - The primary is elected."

echo "$(date) - Replicaset Configuration: "
mongo --host mongodb1 --quiet --eval 'db.isMaster()'