#!/bin/sh
multipass launch 20.04 --name sdx -d 20G -m 8192M -c 2
multipass set client.primary-name=sdx
multipass list
multipass info sdx
echo "### Ubuntu Update ###"
multipass exec sdx sudo apt-get update
multipass exec sdx sudo apt-get upgrade
echo "### mininet install ###"
multipass exec sdx sudo apt install net-tools
multipass exec sdx sudo apt-get install mininet
multipass exec sdx -- bash -c "sudo mn --version"
multipass exec sdx -- bash -c "sudo mn --switch ovsbr --test pingall"
multipass exec sdx -- bash -c "echo 'deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
multipass exec sdx -- bash -c "curl -L 'https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key' | sudo apt-key add -"
