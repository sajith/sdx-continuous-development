#!/bin/sh
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
		netbase \
                netcat \
                software-properties-common \
		uuid-dev \
		wget \
		xz-utils \
		zlib1g-dev"
multipass exec sdx -- bash -c "sudo apt install python3-pip --assume-yes"
multipass exec sdx -- bash -c "sudo apt-get purge --assume-yes --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
sudo rm -rf /var/lib/apt/lists/*"
multipass exec sdx -- bash -c "pip3 install --upgrade pip"
# multipass exec sdx -- bash -c "pip3 install six==1.16.0"
multipass exec sdx -- bash -c "pip3 install wheel==0.37.0"
multipass exec sdx -- bash -c "pip3 install grpcio==1.41.0"
multipass exec sdx -- bash -c "pip3 install networkx==2.5.1"
multipass exec sdx -- bash -c "pip3 install eventlet==0.33.0"
multipass exec sdx -- bash -c "pip3 install black==20.8b0"
