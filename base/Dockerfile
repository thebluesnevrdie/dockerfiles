FROM debian:jessie-slim
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DUMBINIT_VERSION 1.2.0

RUN apt-get update && apt-get -y install curl apt-transport-https procps && \
    curl -L https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_amd64.deb -o /tmp/dumb-init.deb && \
    dpkg -i /tmp/dumb-init.deb && rm -f /tmp/dumb-init.deb && \
    apt-get update && apt-get -y upgrade && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb
