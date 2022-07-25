# SDX API

## Purpose

* Along with Python, Mininet and Kytos, we'll use Multipass to quickly set up our local development environment and simplify deployment. 
* We'll use pytest instead of unittest for writing unit and integration tests to test the API. 
* We'll store the code on a GitHub repository and utilize GitHub Actions to run tests before deploying to AWS.
* GitHub Actions is a continuous integration and delivery (CI/CD) solution, fully integrated with GitHub. 
* MONGODB

** 

### Get Code From GitHub

```python 
git clone https://github.com/atlanticwave-sdx/sdx-continuous-development.git
cd sdx-continuous-development
```

## Requirements

Python 3.9
Multipass Ubuntu 20

## Set Up

## Install Multipass on Linux

$ sudo snap install multipass --classic --stable

## Install Multipass on MacOS

$ brew install multipass

## Find out what versions of Ubuntu images are available:

$ multipass find

## Launch a Multipass Ubuntu 20.04 LTS instance:

$ multipass launch 20.04 --name sdx -d 8G -m 1024M -c 1

## List the installed instance

$ multipass list

$ multipass sdx info

$ multipass help

## connect to the instance

multipass shell sdx

## stop and delete instance

$ multipass stop sdx

$ multipass delete sdx

## mount a local drive inside the instance

multipass mount ~/sdx-continuous-development sdx:/sdx-continuous-development

## create ubuntu sdx instance, update, and install mininet

$ multipass launch --name sdx -d 20G -m 8192M -c 2

$ multipass set client.primary-name=sdx

$ multipass list

$ multipass info sdx

$ multipass exec sdx sudo apt-get update

$ multipass exec sdx sudo apt-get upgrade

$ multipass exec sdx sudo apt install net-tools

$ multipass exec sdx sudo apt-get install mininet

$ multipass exec sdx -- bash -c "sudo mn --version"

$ multipass exec sdx -- bash -c "sudo mn --switch ovsbr --test pingall"

$ multipass exec sdx -- bash -c "echo 'deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"

$ multipass exec sdx -- bash -c "curl -L 'https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key' | sudo apt-key add -"
