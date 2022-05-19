# pull os base image
FROM os_base

RUN mkdir -p /usr/src/mininet
WORKDIR /usr/src/mininet

# add app
COPY link-hosts.py .
RUN chmod 755 /usr/src/mininet/link-hosts.py
COPY start_mininet.sh .
RUN chmod 755 /usr/src/mininet/start_mininet.sh
# ENTRYPOINT ["./start_mininet.sh"]
