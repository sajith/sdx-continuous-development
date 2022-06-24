#!/bin/sh

docker build -f ./os_base/debian_base/Dockerfile -t debian_base .
docker build -f ./os_base/amlight_base/Dockerfile -t amlight_base .
docker build -f ./os_base/ubuntu_base/Dockerfile -t ubuntu_base .
docker build -f ./app/Dockerfile -t sdx_api .
docker build -f ./container-amlight/Dockerfile -t amlight .
docker build -f ./container-sax/Dockerfile -t sax .
docker build -f ./container-tenet/Dockerfile -t tenet .
docker build -f ./container-mongo/Dockerfile -t mongo_db .
docker build -f ./container-mininet/Dockerfile -t mininet .
docker build -f ./container-sdx-lc/Dockerfile -t sdx_lc .
