FROM ubuntu_base

USER root
WORKDIR /root

COPY start_mininet.sh /
COPY link-hosts.py /
RUN chmod +x /start_mininet.sh
RUN chmod 775 /link-hosts.py

ENTRYPOINT ["/start_mininet.sh"]
