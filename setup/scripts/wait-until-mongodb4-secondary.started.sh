#!/bin/ash
# Wait for mongodb to elect a primary
while [ "$RESULT" != "true" ]; do
   RESULT=$(mongo --host mongodb4 --quiet --eval 'db.isMaster().secondary');
   echo "$(date) - Is mongodb4 secondary? $RESULT"
   sleep 5;
done
echo "$(date) - The secondary is elected."