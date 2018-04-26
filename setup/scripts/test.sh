#!/bin/ash
echo "$(date) - Starting mongodb1 testing..."
echo "$(date) - replicaset status:"
mongo --host mongodb1:27017 --eval "rs.status()"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').count({})"
mongo --host mongodb1:27017 --eval "db.isMaster().ismaster"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').createIndex({ name: 1},{sparse:true,background:true})"

echo "$(date) - Indexes:"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb2:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb3:27017 --eval "db.getCollection('contacts').stats().indexSizes"

echo "$(date) - Changing replicaset..."
mongo --host mongodb1:27017 --eval "cfg = rs.conf();cfg.members[0].priority = 0.5;cfg.members[1].priority = 1;cfg.members[2].priority = 0.5;rs.reconfig(cfg, { force: true });"

sh wait-until-mongodb2-primary-started.sh

mongo --host mongodb1:27017 --eval "rs.status()"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').count({})"
mongo --host mongodb1:27017 --eval "db.isMaster().ismaster"

echo "$(date) - Starting mongodb2 testing..."
mongo --host mongodb2:27017 --eval "db.getCollection('contacts').createIndex({ email: 1},{sparse:true,background:true})"
echo "$(date) - replicaset status:"
mongo --host mongodb2:27017 --eval "rs.status()"
mongo --host mongodb2:27017 --eval "db.getCollection('contacts').count({})"
mongo --host mongodb2:27017 --eval "db.isMaster().ismaster"

echo "$(date) - Indexes:"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb2:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb3:27017 --eval "db.getCollection('contacts').stats().indexSizes"


echo "$(date) - Changing replicaset..."
mongo --host mongodb2:27017 --eval "cfg = rs.conf();cfg.members[0].priority = 1;cfg.members[1].priority = 0.5;cfg.members[2].priority = 0.5;rs.reconfig(cfg, { force: true });"

sh wait-until-mongodb1-primary-started.sh

echo "$(date) - Starting mongodb1 testing..."
echo "$(date) - replicaset status:"
mongo --host mongodb1:27017 --eval "rs.status()"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').count({})"
mongo --host mongodb1:27017 --eval "db.isMaster().ismaster"
echo "$(date) - Indexes:"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb2:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb3:27017 --eval "db.getCollection('contacts').stats().indexSizes"


echo "$(date) - Starting mongodbarbiter testing..."
echo "$(date) - replicaset status:"
mongo --host mongodbarbiter:27017 --eval "rs.status()"

echo "$(date) - Starting mongodb4 testing..."
echo "$(date) - replicaset status:"
mongo --host mongodb4:27017 --eval "rs.status()"
mongo --host mongodb4:27017 insert-data.js
mongo --host mongodb4:27017 --eval "db.getCollection('contacts').createIndex({ name:1, email: 1},{sparse:true,background:true})"

echo "$(date) - Starting mongodb1 testing..."
echo "$(date) - replicaset status:"
mongo --host mongodb1:27017 --eval "rs.status()"

echo "$(date) - Adding mongodb4 to replicaset..."
mongo --host mongodb1:27017 --eval "rs.add( { host: 'mongodbd4:27017', priority: 0.5 } );"
sh wait-until-mongodb4-secondary.started.sh

echo "$(date) - replicaset status:"
mongo --host mongodb1:27017 --eval "rs.status()"

echo "$(date) - Indexes:"
mongo --host mongodb1:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb2:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb3:27017 --eval "db.getCollection('contacts').stats().indexSizes"
mongo --host mongodb4:27017 --eval "db.getCollection('contacts').stats().indexSizes"




