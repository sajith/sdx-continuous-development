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
 
We will also use [Kyotos-NG](https://github.com/kytos-ng/) SDN
Platform (and thereby MongoDB), and RabittMQ, and
[mininet](http://mininet.org/).


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
stable, and maybe Fedora.


## Setting up for development

### Get Code From GitHub

``` shellsession
$ git clone https://github.com/atlanticwave-sdx/sdx-continuous-development.git
$ cd sdx-continuous-development
```

### Install Podman and Podman Compose

On Debian and Ubuntu, do this:

``` shellsession
$ sudo apt install podman
```

Podman Compose is not on official Debian and Ubuntu repositories yet;
installing it using [pipx](https://pypi.org/project/pipx/) seems to be
a good idea:

``` shellsession
$ sudo apt install python3-pip
$ python3 -m pip install --user --upgrade pip
$ python3 -m pip install --user --upgrade pipx
$ pipx install podman-compose
```

(See [podman-compose](https://github.com/containers/podman-compose)
documentation for alternatives.)

On Fedora, install podman and podman-compose with:

``` shellsession
$ sudo dnf install podman podman-compose
```

On macOS, do this:

``` shellsession
$ brew install podman podman-compose
```

On macOS, you will also need to initialize a virtual machine to run
Podman containers, with the following commands:


``` shellsession
$ podman machine init
$ podman machine start
```

### A note about registries

`$HOME/.config/containers/registries.conf` is a TOML config file that
can be used to customize whitelisted registries that are allowed to be
searched and used as image sources.


## Usage notes

### Building static network

The script `1_build_network.sh` creates the static network for
mininet, with this command:

``` shellsession
$ podman network create --gateway "192.168.0.1" --subnet "192.168.0.0/24" kytos_network
```

### Building base containers


 * The script `2_build_debian_base.sh` script creates a Debian base Image.
 * The script `3_build_ubuntu_base.sh` script creates an Ubuntu base Image.
 * The script `4_build_containers.sh` script creates Kytos Containers
   Images and Mininet.


### Using Podman

Creating a local Debian base image to be used for Kytos containers


``` shellsession
$ podman build -f ./os_base/debian_base/Dockerfile -t debian_base .
```

To access the image with bash:

``` shellsession
$ podman run -it debian_base /bin/bash
```

To list available images:

``` shellsession
$ podman images
```

To remove an image:

``` shellsession
$ podman image rm <image_id> 
```

To Create a local kytos images using the Debian base image:

``` shellsession
$ podman build -f ./container-amlight/Dockerfile -t amlight .
$ podman build -f ./container-sax/Dockerfile -t sax .
$ podman build -f ./container-tenet/Dockerfile -t tenet .
```

To create a local mongodb image:

``` shellsession
$ podman build -f ./container-mongo/Dockerfile -t mongo_db .
```

To create a local Ubuntu base image to be used for mininet container:

``` shellsession
$ podman build -f ./os_base/ubuntu_base/Dockerfile -t ubuntu_base .
```

To create a local mininet image:

``` shellsession
$ podman build -f ./container-mininet/Dockerfile -t mininet .
```

To start containers with podman-compose:

``` shellsession
$ podman-compose down
$ podman-compose --podman-run-args='--network kytos_network' up -d
```
