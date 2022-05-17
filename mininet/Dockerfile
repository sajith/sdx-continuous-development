# pull os base image
FROM os_base

# set work directory
RUN mkdir /var/lib/kytos
RUN mkdir /var/run/kytos
RUN mkdir /var/tmp/kytos
RUN mkdir /etc/kytos

RUN mkdir -p /usr/src/kytos
WORKDIR /usr/src/kytos

# add app
COPY kytos_install.sh .
RUN chmod 755 /usr/src/kytos/kytos_install.sh
ENTRYPOINT ["./kytos_install.sh"]
