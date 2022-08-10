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
Multipass Ubuntu 22.04


## Install Multipass on Linux

$ sudo snap install multipass --classic --stable

## Install Multipass on MacOS

$ brew install multipass

## Find out what versions of Ubuntu images are available:

$ multipass find

## Set Up

## Run the script 1_multipass_setup.sh

## This script will Launch and setup a Multipass Ubuntu 22.04 LTS instance:

$ multipass launch 22.04 --name sdx -d 8G -m 1024M -c 1

## List the installed instance

$ multipass list

$ multipass info sdx

$ multipass help

## connect to the instance

multipass shell sdx

## mount a local drive inside the instance

multipass mount ./podman sdx:/podman

## stop instance

$ multipass stop sdx

## delete instance

$ multipass delete sdx


