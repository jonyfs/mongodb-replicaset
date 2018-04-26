#!/bin/sh

cd /root
pwd

sh wait-until-started.sh
sh wait-until-master-started.sh

echo "Starting setup..."

cd /root/scripts

pwd

if [ ! -f "/root/scripts/add-user.sh.success" ]; then
  #add users
  echo "running add-user.sh..."
  sh add-user.sh
  echo "" > /root/scripts/add-user.sh.success
fi

if [ ! -f "/root/scripts/replicaset-setup.sh.success" ]; then
  #add users
  echo "running replicaset-setup.sh..."
  sh replicaset-setup.sh
  echo "" > /root/replicaset-setup.sh.success
fi

if [ ! -f "/root/scripts/insert-data.sh.success" ]; then
  #add users
  echo "running insert-data.sh..."
  sh insert-data.sh
  echo "" > /root/scripts/insert-data.sh.success
fi