# pull os base image
FROM os_base

# set work directory
RUN mkdir -p /app
WORKDIR /app

# add app
COPY ./app /app/

# run server
COPY wsgi.py /wsgi.py
