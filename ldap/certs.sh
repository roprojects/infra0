#!/usr/bin/env bash


#Generate certificates for ldap.homelab.internal

set -e

rm -rf certs && mkdir -p certs

KID=$(step ca provisioner list | grep "kid" | cut -d '"' -f 4)

echo "Type here your step admin password:"
T=$(step ca token --kid=${KID} ldap.homelab.internal)
step ca certificate --token ${T} ldap.homelab.internal certs/ldap.crt certs/ldap.key
cp -r ${HOME}/.step/certs/root_ca.crt certs/ldapCA.crt


exit 0
