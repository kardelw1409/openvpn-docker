# Smallest base image
FROM alpine:3.18

MAINTAINER ValeryKardel <valerykardel@gmail.com>

ADD VERSION .

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    openssl \
    easy-rsa \
    openvpn \
    iptables \
    bash \
    curl \
    git \
    go \
    make \
    build-base \
    tar \
    xz && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

RUN git clone https://github.com/jkroepke/openvpn-auth-oauth2.git /opt/openvpn-auth-oauth2 && \
    cd /opt/openvpn-auth-oauth2 && \
    make build && \
    mv openvpn-auth-oauth2 /usr/local/bin/openvpn-auth-oauth2 && \
    chmod +x /usr/local/bin/openvpn-auth-oauth2

RUN mkdir -p /dev/net && \
     mknod /dev/net/tun c 10 200 && \
     chmod 600 /dev/net/tun