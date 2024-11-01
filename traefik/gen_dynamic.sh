#!/usr/bin/env bash

cat config/dynamic.yaml.template > config/dynamic.yaml

D="homelab.lan"

cd certs

for i in $(ls *.crt 2> /dev/null | grep -v "${D}")
do
 A=$(echo ${i} | sed -r -e 's/\.crt//g')

 ln -f ${i} ${A}.${D}.crt
 ln -f ${A}.key ${A}.${D}.key

 echo "    - certFile: /certs/${A}.${D}.crt" >> ../../traefik/config/dynamic.yaml
 echo "      keyFile: /certs/${A}.${D}.key" >> ../../traefik/config/dynamic.yaml
done
