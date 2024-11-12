#!/usr/bin/env bash

if command -v docker-compose 2>&1 >/dev/null
then
 docker-compose down
elif command -v docker 2>&1 >/dev/null
then
 docker compose down
else
 echo "Docker not installed! Aborting..."
fi

sudo rm -rf gitlab-runner
