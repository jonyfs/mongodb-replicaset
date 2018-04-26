#!/bin/sh
mongo --host mongodb1:27017 <<EOF
use testdb
	db.createUser(
		{
			"user": "${MONGODB_USER}",
			"pwd": "${MONGODB_PASSWORD}",
			"roles": [{
				"role": "readWrite",
				"db": "${MONGODB_DB}"
			}]
		}
	);
	
EOF
