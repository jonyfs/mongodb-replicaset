#!/bin/sh

cd /root/scripts

pwd

sh wait-until-started.sh

echo "$(date) - Starting setup..."

if [ ! -f "/root/scripts/replicaset-setup.sh.success" ]; then
  #add users
  echo "$(date) - running replicaset-setup.sh..."
  sh replicaset-setup.sh
  echo "" > /root/replicaset-setup.sh.success
fi

if [ ! -f "/root/scripts/add-user.sh.success" ]; then
  #add users
  echo "$(date) - running add-user.sh..."
  sh add-users.sh
  echo "" > /root/scripts/add-user.sh.success
fi

if [ ! -f "/root/scripts/insert-data.sh.success" ]; then
  #add users
  echo "$(date) - running insert-data.sh..."
  sh insert-data.sh
  echo "" > /root/scripts/insert-data.sh.success
fi

if [ ! -f "/root/scripts/test.sh.success" ]; then
  #add users
  echo "$(date) - running test.sh..."
  sh test.sh
  echo "" > /root/scripts/test.sh.success
fi