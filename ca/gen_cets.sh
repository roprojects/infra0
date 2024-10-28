#!/usr/bin/env bash

if [ "${1}" == "install" ]
then
 set +e

 wget https://dl.smallstep.com/gh-release/cli/gh-release-header/v0.27.4/step_linux_0.27.4_amd64.tar.gz
 tar -zxvf step_linux_0.27.4_amd64.tar.gz

 sudo mv step_0.27.4/bin/step /bin/

 rm -rf step_0.27.4 step_linux_0.27.4_amd64.tar.gz

 step --version

 echo -n "Enter fingerprint: "

 read FF

 step ca bootstrap --ca-url https://ca.homelab.internal:9000 --fingerprint ${FF} --install
elif [ "${1}" == "certs" ]
then
 set +e

 mkdir -p certs

 for i in router firewall proxmox switch ap0 ap1 ap2 traefik ca pihole vpn gitlab files wiki mattermost bugs deployment grafana metrics
 do
  step ca token ${i}.homelab.lan | tee certs/${i}.token

  step ca certificate --token $(cat certs/${i}.token) ${i}.homelab.lan certs/${i}.crt certs/${i}.key
 done
else
 echo "USAGE: ${0} <install|certs>"
fi
