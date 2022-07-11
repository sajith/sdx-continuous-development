#!/bin/sh
multipass launch --name mininet -d 20G -m 8192M -c 2
multipass set client.primary-name=mininet
multipass list
multipass info mininet
multipass exec mininet sudo apt-get update
multipass exec mininet sudo apt-get upgrade
multipass exec mininet sudo apt install net-tools
multipass exec mininet sudo apt-get install mininet
multipass exec mininet -- bash -c "sudo mn --version"
multipass exec mininet -- bash -c "sudo mn --switch ovsbr --test pingall"
