#!/bin/sh
multipass launch 22.04 --name sdx -d 20G -m 8192M -c 2
multipass set client.primary-name=sdx
multipass list
multipass info sdx
echo "### Ubuntu update ###"
multipass exec sdx -- bash -c "sudo apt-get update --assume-yes"
multipass exec sdx sudo apt-get -y upgrade
echo "### dependencies install ###"
multipass exec sdx -- bash -c "sudo apt-get install --assume-yes --no-install-recommends \
                build-essential ca-certificates curl dirmngr dpkg-dev gcc git gnupg2 \
                gunicorn iputils-ping libbz2-dev libc6-dev libexpat1-dev libffi-dev \
		liblzma-dev libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev \
		libsqlite3-dev libssl-dev lsof make mininet net-tools netbase netcat \
		openvswitch-switch-dpdk podman software-properties-common uuid-dev wget \
		xz-utils zlib1g-dev"
echo "### install python 3.9 ###"
multipass exec sdx -- bash -c "sudo add-apt-repository -y ppa:deadsnakes/ppa"
multipass exec sdx -- bash -c "sudo apt-get install --assume-yes python3.9"
multipass exec sdx -- bash -c "sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1"
multipass exec sdx -- bash -c "sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2"
multipass exec sdx -- bash -c "sudo apt-get install --assume-yes --reinstall python3.9-distutils"
echo "### set mininet ###"
multipass exec sdx -- bash -c "sudo mn --version"
multipass exec sdx -- bash -c "sudo mn --switch ovsbr --test pingall"
multipass exec sdx -- bash -c "sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'"
multipass mount ./podman sdx:/podman
multipass exec sdx -- bash -c "sudo apt-get install python3-pip --assume-yes"
#multipass exec sdx -- bash -c "sudo bash -c /podman/requirements/preinstall.sh" 
#multipass exec sdx -- bash -c "pip3 install -r /podman/requirements/requirements.txt" 
