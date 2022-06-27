# SDX API

## Purpose

* Along with Python and FastAPI, we'll use Docker to quickly set up our local development environment and simplify deployment. 
* We'll use pytest instead of unittest for writing unit and integration tests to test the API. 
* We'll store the code on a GitHub repository and utilize GitHub Actions to run tests before deploying to AWS.
* GitHub Actions is a continuous integration and delivery (CI/CD) solution, fully integrated with GitHub. 
* MONGODB

** 

## Goal

## Set Up

### Get Code From GitHub

```python 
git clone https://github.com/atlanticwave-sdx/sdx-api.git
cd sdx-api
```

### Install Dependencies

```python
$ python3.9 -m venv venv
$ source venv/bin/activate
$ export PYTHONPATH=$PWD
$ pip3 install -r requirements.txt
$ python3.9 -m pip install --upgrade pip
```

## PODMAN

### Installing Podman on Debian

 $ apt-get –y install podman

### Installing Podman on macOS

 $ brew install podman

``` To initialize the VM running the Linux box, run the following commands:
```

 $ podman machine init

 $ podman machine start

 $ pip3 install podman-compose

## Preparing your environment

```
$HOME/.config/containers/registries.conf is a TOML config file that can be used to customize whitelisted registries that are allowed to be searched and used as image sources
```

### Building static network


```
The pod_network.sh script creates the static network for mininet
```

podman network create --gateway "192.168.0.1" --subnet "192.168.0.0/24" kytos_network



### Building base containers


```
The pod_build.sh script creates all images below
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
