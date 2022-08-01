#!/bin/sh
echo "### set dependencies for mongoDB ###"
multipass exec sdx -- bash -c "sudo apt-get install --assume-yes --no-install-recommends \
	dirmngr gnupg apt-transport-https ca-certificates software-properties-common"
echo "### Import the public key used by the package management system for mongoDB ###"
multipass exec sdx -- bash -c "wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -"
echo "### Create the /etc/apt/sources.list.d/mongodb-org-5.0.list file for Ubuntu 20.04 (Focal) ###"
multipass exec sdx -- bash -c "echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list"
echo "### Reload local package database ###"
multipass exec sdx -- bash -c "sudo apt-get update"
echo "### Install the MongoDB packages ###"
multipass exec sdx -- bash -c "sudo apt-get install -y mongodb-org"

