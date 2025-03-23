# Smallest base image
FROM alpine:3.9

MAINTAINER ValeryKardel<valerykardel@gmail.com>

ADD VERSION .

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache openssl easy-rsa openvpn iptables bash && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

RUN mkdir -p /dev/net && \
     mknod /dev/net/tun c 10 200 
