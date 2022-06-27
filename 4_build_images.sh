#!/bin/sh

podman build -f ./os_base/debian_base/Dockerfile -t debian_base .
podman build -f ./container-amlight/Dockerfile -t amlight .
podman build -f ./container-sax/Dockerfile -t sax .
podman build -f ./container-tenet/Dockerfile -t tenet .
podman build -f ./container-mongo/Dockerfile -t mongo_db .
podman build -f ./os_base/ubuntu_base/Dockerfile -t ubuntu_base .
podman build -f ./container-mininet/Dockerfile -t mininet .
# podman build -f ./container-sdx-lc/Dockerfile -t sdx_lc .
podman build -f ./app/Dockerfile -t sdx_api .
