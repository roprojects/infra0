#!/usr/bin/env bash

set -e

sudo rm -rf step
mkdir -p step
chmod 777 step

if command -v docker-compose 2>&1 >/dev/null
then
 docker-compose up -d
elif command -v docker 2>&1 >/dev/null
then
 docker compose up -d
else
 echo "Docker not installed! Aborting..."
fi

sleep 10

docker logs ca 2> /dev/stdout | grep -Ei "(CA administrative|Root Fingerprint)" | grep -v "^20" | tee password.txt

cp -r ca.json step/config/

docker compose exec ca step ca provisioner add acme --type ACME

docker compose restart

sleep 10

./gen_certs.sh install

#Not needed if we have auto cert generation in traefik
#./gen_certs.sh certs
