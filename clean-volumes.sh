#!/bin/bash

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro -v /var/lib/docker:/var/lib/docker martin/docker-cleanup-volumes
