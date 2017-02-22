FROM debian:jessie-slim
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DUMBINIT_VERSION 1.2.0
ENV SALT_VERSION 2016.3

RUN apt-get update && apt-get -y install curl apt-transport-https procps && \
    curl -L https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_amd64.deb -o /tmp/dumb-init.deb && \
    dpkg -i /tmp/dumb-init.deb && rm -f /tmp/dumb-init.deb && \
    curl -L http://repo.saltstack.com/apt/debian/8/amd64/${SALT_VERSION}/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb http://repo.saltstack.com/apt/debian/8/amd64/${SALT_VERSION} jessie main" > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && apt-get -y upgrade && \
    apt-get -y install salt-master && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb

COPY defaults.conf /etc/salt/master.d/defaults.conf
EXPOSE 4506 4505
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/bin/salt-master"]
