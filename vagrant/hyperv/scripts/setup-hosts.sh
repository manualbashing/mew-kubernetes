#!/bin/bash
set -e
IFNAME=$1
ADDRESS=$2

# TODO: Figure out, why Kodekloud was doing this...
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu entry
sed -e '/^.*ubuntu-.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
# TODO: Dynamically set the IPs
cat >> /etc/hosts <<EOF
192.168.0.201  kubemaster
192.168.0.204  kubenode01
192.168.0.205  kubenode02
EOF

# We use netplan, as hyer-v ignores vagrant's config.network settings
cat > /etc/netplan/00-vagrant.yaml <<EOF
network:
  version: 2
  ethernets:
    eth0:
      addresses:
      - {ADDRESS}/24
      gateway4: 192.168.0.1
      nameservers:
        addresses:
        - 8.8.8.8
EOF
sed -e "s/{ADDRESS}/$ADDRESS/g" -i /etc/netplan/00-vagrant.yaml
netplan apply