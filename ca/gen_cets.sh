#!/usr/bin/env bash

if [ "${1}" == "install" ]
then
 wget https://dl.smallstep.com/gh-release/cli/gh-release-header/v0.27.4/step_linux_0.27.4_amd64.tar.gz
 tar -zxvf step_linux_0.27.4_amd64.tar.gz
 sudo mv step_0.27.4/bin/step /bin/
 rm -rf step_0.27.4 step_linux_0.27.4_amd64.tar.gz
 step --version
elif [ "${1}" == "certs" ]
then
 set +e

 echo -n "Enter fingerprint: "

 read FF

 step ca bootstrap --ca-url https://ca.homelab.internal:9000 --fingerprint ${FF} --install

 mkdir -p certs

 for i in router firewall proxmox switch ap0 ap1 ap2 traefik ca pihole vpn gitlab files wiki mattermost bugs deployment grafana metrics
 do
  step ca token ${i}.homelab.lan

  echo -n "Copy and paste long alphanumerical string from line above here: "

  read TT

  echo ${TT} > certs/${i}.token

  step ca certificate --token ${TT} ${i}.homelab.lan certs/${i}.crt certs/${i}.key
else
 echo "USAGE: ${0} <install|certs>"
fi
