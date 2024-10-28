#!/usr/bin/env bash

mkdir -p certs

cat config/dynamic.yaml.template > config/dynamic.yaml

D="homelab.lan"

for i in $(ls certs/*.crt | grep -v "${D}")
do
 A=$(echo ${i} | sed -r -e 's/\.crt//g')

 ln -sf ${i} ${A}.${D}.crt
 ln -sf ${A}.key ${A}.${D}.key

 echo "      - certFile: /${A}.${D}.crt" >> config/dynamic.yaml
 echo "        keyFile: /${A}.${D}.key" >> config/dynamic.yaml
done
