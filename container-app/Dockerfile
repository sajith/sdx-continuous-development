# pull os base image
FROM debian_base

# set work directory
RUN mkdir -p /app
WORKDIR /app

# add app
COPY ./container-app /app/

ENTRYPOINT ["./gunicorn.sh"]
