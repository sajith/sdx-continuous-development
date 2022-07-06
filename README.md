# CI/CD for AtlanticWave-SDX project

## What is this?

This repository is meant to continuously test the integration of
various [AtlanticWave-SDX](https://www.atlanticwave-sdx.net/) project
components, and for code to be deployed in the test environment
quicker.

Atlanticwave-SDX is composed of several components:

 * [kytos-sdx-topology](https://github.com/atlanticwave-sdx/kytos-sdx-topology) 
 * [sdx-controller](https://github.com/atlanticwave-sdx/sdx-controller)
 * [sdx-controller-client](https://github.com/atlanticwave-sdx/sdx-controller-client)
 * [sdx-lc](https://github.com/atlanticwave-sdx/sdx-lc)
 * [sdx-lc-client](https://github.com/atlanticwave-sdx/sdx-lc-client)
 * [pce](https://github.com/atlanticwave-sdx/pce)
 * [datamodel](https://github.com/atlanticwave-sdx/datamodel)
 
We will also use [Kyotos-NG](https://github.com/kytos-ng/) (and
thereby MongoDB), and RabittMQ.


## Approach

Things are in an exploratory stage right now.  This is the approach we
taking, at the moment anyway:

* Along with Python and FastAPI, we will use Podman to quickly set up
  our local development environment, and to simplify deployment.
  
* We will use pytest instead of unittest for writing unit and
  integration tests.
  
* Since our code is on GitHub, to the extent possible, we will use
  GitHub Actions to run tests before deploying.


## Requirements

 * Python 3.9
 * [Podman](https://podman.io/)
 * [Podman Compose](https://github.com/containers/podman-compose)

We will try to have our setup running on macOS and current Debian
stable.


## Setting up for development

### Get Code From GitHub

``` shellsession
$ git clone https://github.com/atlanticwave-sdx/sdx-continuous-development.git
$ cd sdx-continuous-development
```

### Install podman

On Debian and Ubuntu, do this:

``` shellsession
$ sudo apt-get –y install podman
```

On Fedora, do this:

``` shellsession
$ sudo dnf install podman
```

On macOS, do this:

``` shellsession
$ brew install podman
```

On macOS, you will also need to initialize a virtual machine to run
Podman containers, with the following commands:


``` shellsession
$ podman machine init
$ podman machine start
```

## Install podman-compose

See documentation of
[podman-compose](https://github.com/containers/podman-compose)
project.

 * On macOS, install it using `brew install podman-compose`.
 * On Debian/Ubuntu, install it using `pipx install podman-compose`.
 * On Fedora, install it using `sudo dnf install podman-compose`.

## Preparing your environment

```
$HOME/.config/containers/registries.conf is a TOML config file that can be used to customize whitelisted registries that are allowed to be searched and used as image sources
```

### Building static network

```
The 1_build_network.sh script creates the static network for mininet
```

podman network create --gateway "192.168.0.1" --subnet "192.168.0.0/24" kytos_network

### Building base containers

```
The 2_build_debian_base.sh script creates Debian base Image
The 3_build_ubuntu_base.sh script creates Ubuntu base Image
The 4_build_containers.sh script creates Kytos Containers Images and Mininet
```

```
Create a local Debian base image to be used for kytos containers
```

 $ podman build -f ./os_base/debian_base/Dockerfile -t debian_base .

```
Access the image with bash
```

 $ podman run -it debian_base /bin/bash


```
Access the image id
```

 $ podman images


```
Removing the image
```

 $ podman image rm <image_id> 


```
Create a local kytos images using the Debian base image 
```

 $ podman build -f ./container-amlight/Dockerfile -t amlight .
 $ podman build -f ./container-sax/Dockerfile -t sax .
 $ podman build -f ./container-tenet/Dockerfile -t tenet .


```
Create a local mongodb image 
```

podman build -f ./container-mongo/Dockerfile -t mongo_db .

```
Create a local Ubuntu base image to be used for mininet container
```

podman build -f ./os_base/ubuntu_base/Dockerfile -t ubuntu_base .

```
Create a local mininet image 
```

podman build -f ./container-mininet/Dockerfile -t mininet .

```
The 5_pod_compose.sh Start containers with podman-compose 
```

 $ podman-compose down
 $ podman-compose --podman-run-args='--network kytos_network' up -d

