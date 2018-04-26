#!/bin/ash
mongo --host mongodb1:27017 replicaset-setup.js

sh wait-until-mongodb1-primary-started.sh

mongo --host mongodb1:27017 --eval "rs.addArb('mongodbarbiter:27017');"

