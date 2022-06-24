#!/bin/sh

docker build -f ../os_base/debian_base/Dockerfile -t debian_base .
docker build -f ../os_base/amlight_base/Dockerfile -t amlight_base .
docker build -f ../os_base/ubuntu_base/Dockerfile -t ubuntu_base .
docker build -f ../app/Dockerfile -t sdx_api .
docker build -f ../amlight/Dockerfile -t amlight .
docker build -f ../sax/Dockerfile -t sax .
docker build -f ../tenet/Dockerfile -t tenet .
docker build -f ../mongo/Dockerfile -t mongo_db .
docker build -f ../mininet/Dockerfile -t mininet .
docker build -f ../sdx-lc/Dockerfile -t sdx_lc .
