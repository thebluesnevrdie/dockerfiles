FROM debian:jessie-slim
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DUMBINIT_VERSION 1.2.0
ENV GOGS_VERSION 0.9.128-1486604973.afab38b.jessie

RUN apt-get update && apt-get -y install curl apt-transport-https procps && \
    curl -L https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_amd64.deb -o /tmp/dumb-init.deb && \
    dpkg -i /tmp/dumb-init.deb && rm -f /tmp/dumb-init.deb && \
    curl -L https://deb.packager.io/key | apt-key add - && \
    echo "deb https://deb.packager.io/gh/pkgr/gogs jessie pkgr" > /etc/apt/sources.list.d/gogs.list && \
    apt-get update && apt-get -y upgrade && \
    apt-get -y install gogs=${GOGS_VERSION} && \
    apt-get -y install supervisor openssh-server nginx-light && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb && \
    mkdir -p /var/run/sshd && \
    rm /etc/nginx/sites-available/default && \
    rm /etc/supervisor/supervisord.conf

ADD nginx.conf /etc/nginx/sites-available/default
ADD supervisord.conf /etc/supervisord.conf
ADD ssh.supervisor /etc/supervisor/conf.d/ssh.conf
ADD nginx.supervisor /etc/supervisor/conf.d/nginx.conf
ADD gogs.supervisor /etc/supervisor/conf.d/gogs.conf

EXPOSE 80 22
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
