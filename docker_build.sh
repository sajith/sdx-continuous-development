#!/bin/sh
docker build -f Dockerfile -t os_base .
docker build -f app/Dockerfile -t sdx_api .
docker build -f amlight/Dockerfile -t amlight .
docker build -f sax/Dockerfile -t sax .
docker build -f tenet/Dockerfile -t tenet .
docker build -f mongo/Dockerfile -t mongo_db .
docker build -f proxy/Dockerfile -t nginx_ws .
docker build -f mininet/Dockerfile -t mininet .
docker build -f sdx-lc/Dockerfile -t sdx_lc .
