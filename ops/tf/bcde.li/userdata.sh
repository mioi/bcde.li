#! /bin/bash

echo "Add an enrollment token"

# TODO(mioi): add an enrollment token for your team?
sudo mkdir -p /var/lib/sftd
echo "eyJzIjoiYjQ5YTE1OTctNzUwNS00MDJlLWE5YjEtYzhmZTNmN2NhMTJhIiwidSI6Imh0dHBzOi8vYXBwLnNjYWxlZnQuY29tIn0=" | sudo tee /var/lib/sftd/enrollment.token

export DEBIAN_FRONTEND=noninteractive

echo "Add the ScaleFT apt repo to your /etc/apt/sources.list system config file"
echo "deb http://pkg.scaleft.com/deb linux main" | sudo tee -a /etc/apt/sources.list

echo "Trust the repository signing key"
curl -C - https://www.scaleft.com/dl/scaleft_deb_key.asc | sudo apt-key add -

echo "Retrieve information about new packages"
sudo apt-get update

echo "Install sftd"
sudo apt-get install scaleft-server-tools