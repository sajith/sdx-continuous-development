###### NGINX BASE #####
FROM nginx:latest

RUN rm /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf

COPY ./proxy/nginx.conf /etc/nginx/nginx.conf
COPY ./proxy/default.conf /etc/nginx/conf.d/default.conf
