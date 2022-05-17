# SDX API

## Purpose

* Along with Python and FastAPI, we'll use Docker to quickly set up our local development environment and simplify deployment. 
* We'll use pytest instead of unittest for writing unit and integration tests to test the API. 
* We'll store the code on a GitHub repository and utilize GitHub Actions to run tests before deploying to AWS.
* FastAPI is a modern, batteries-included Python web framework that's perfect for building RESTful APIs. It can handle both synchronous and asynchronous requests and has built-in support for data validation, JSON serialization, authentication and authorization, and OpenAPI (version 3.0.2 as of writing) documentation. 
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

Run the server from the "sdx-api" directory:

(venv)$ uvicorn main:app --reload --workers 1 --host 0.0.0.0 --port 8000

FastAPI automatically generates a schema based on the OpenAPI standard. 

view the raw JSON at http://localhost:8000/openapi.json.

view the interactive API documentation at http://localhost:8000/sdxapi

(env)$ export ENVIRONMENT=prod
(env)$ export TESTING=1

Run the server. Now, at http://localhost:8000/ping, you should see:

{
  "environment": "prod",
  "testing": true
}

Essentially, get_settings gets called for each request. 
Refactoring the config so that the settings were read from a file, instead of 
from environment variables, it would be much too slow.

Decorate get_settings with lru_cache to cache the settings so get_settings is only called once.


