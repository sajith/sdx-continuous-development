#!/bin/sh
multipass launch 20.04 --name sdx -d 20G -m 8192M -c 2
multipass set client.primary-name=sdx
multipass list
multipass info sdx
echo "### Ubuntu update ###"
multipass exec sdx -- bash -c "sudo apt-get update --assume-yes"
multipass exec sdx sudo apt-get -y upgrade
echo "### dependencies install ###"
multipass exec sdx -- bash -c "sudo apt-get install --assume-yes --no-install-recommends \
                build-essential \
		ca-certificates \
		dirmngr \
		dpkg-dev \
		gcc \
                git \
		gnupg \
                gunicorn \
                iputils-ping \
		libbz2-dev \
		libc6-dev \
		libexpat1-dev \
		libffi-dev \
		liblzma-dev \
                libncurses5-dev \
                libgdbm-dev \
                libnss3-dev \
                libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
                lsof \
		make \
                mininet \
		net-tools \
		netbase \
                netcat \
                software-properties-common \
		uuid-dev \
		wget \
		xz-utils \
		zlib1g-dev"
echo "### install python 3.9 ###"
multipass exec sdx -- bash -c "sudo add-apt-repository ppa:deadsnakes/ppa -y"
multipass exec sdx -- bash -c "sudo apt install python3.9 --assume-yes"
multipass exec sdx -- bash -c "sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1"
multipass exec sdx -- bash -c "sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.9 2"
multipass exec sdx -- bash -c "sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1"
multipass exec sdx -- bash -c "sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2"
multipass exec sdx -- bash -c "sudo apt install python3-pip --assume-yes"
multipass exec sdx -- bash -c "sudo apt-get purge --assume-yes --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
sudo rm -rf /var/lib/apt/lists/*"
