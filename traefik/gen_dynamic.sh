#!/usr/bin/env bash

mkdir -p certs

cat config/dynamic.yaml.template > config/dynamic.yaml

D="homelab.lan"

cd certs

for i in $(ls *.crt | grep -v "${D}")
do
 A=$(echo ${i} | sed -r -e 's/\.crt//g')

 ln -f ${i} ${A}.${D}.crt
 ln -f ${A}.key ${A}.${D}.key

 echo "    - certFile: /certs/${A}.${D}.crt" >> ../config/dynamic.yaml
 echo "      keyFile: /certs/${A}.${D}.key" >> ../config/dynamic.yaml
done
