FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV GOGS_VERSION 0.9.128-1486604973.afab38b.jessie

RUN curl -L https://deb.packager.io/key | apt-key add - && \
    echo "deb https://deb.packager.io/gh/pkgr/gogs jessie pkgr" > /etc/apt/sources.list.d/gogs.list && \
    apt-get update && apt-get -y upgrade && \
    apt-get -y install gogs=${GOGS_VERSION} && \
    apt-get -y install supervisor openssh-server nginx-light && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb && \
    mkdir -p /var/run/sshd && \
    # See https://github.com/docker/docker/issues/5663
    sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd && \
    groupmod -g 999 gogs && usermod -u 999 -g 999 gogs && \
    chown -R 999:999 /etc/gogs /var/log/gogs /var/db/gogs /opt/gogs && \
    # See http://arlimus.github.io/articles/usepam/
    usermod -p "*" gogs && \
    rm /etc/nginx/sites-available/default && \
    rm /etc/supervisor/supervisord.conf

ADD sshd_config /etc/ssh/sshd_config
ADD nginx.conf /etc/nginx/sites-available/default
ADD supervisord.conf /etc/supervisord.conf
ADD ssh.supervisor /etc/supervisor/conf.d/ssh.conf
ADD nginx.supervisor /etc/supervisor/conf.d/nginx.conf
ADD gogs.supervisor /etc/supervisor/conf.d/gogs.conf

EXPOSE 80 22
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
