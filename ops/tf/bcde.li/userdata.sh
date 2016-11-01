#! /bin/bash

echo "Add an enrollment token"
echo "Token 61b03f88-be6d-42c2-bd98-99f2464b3f91 in project bcde.li issued 2016-11-01T05:47:23.903185Z"

sudo mkdir -p /var/lib/sftd
echo "eyJzIjoiNjFiMDNmODgtYmU2ZC00MmMyLWJkOTgtOTlmMjQ2NGIzZjkxIiwidSI6Imh0dHBzOi8vYXBwLnNjYWxlZnQuY29tIn0=" | sudo tee /var/lib/sftd/enrollment.token

echo "Add a basic configuration"
sftcfg=<EOF
---
# altname - An altname for the server
AltNames:            ["${altname}"]
EOF

sudo mkdir -p /etc/sft/
echo -e "$sftcfg" | sudo tee /etc/sft/sftd.yaml

export DEBIAN_FRONTEND=noninteractive

echo "Add the ScaleFT apt repo to your /etc/apt/sources.list system config file"
echo "deb http://pkg.scaleft.com/deb linux main" | sudo tee -a /etc/apt/sources.list

echo "Trust the repository signing key"
curl -C - https://www.scaleft.com/dl/scaleft_deb_key.asc | sudo apt-key add -

echo "Retrieve information about new packages"
sudo apt-get update

echo "Install sftd"
sudo apt-get install scaleft-server-tools
