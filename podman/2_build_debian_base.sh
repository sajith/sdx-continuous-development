#!/bin/sh
cd /podman
podman build -f ./os_base/debian_base/Dockerfile -t debian_base .
