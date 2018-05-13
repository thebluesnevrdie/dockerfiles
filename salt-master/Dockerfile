FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV SALT_VERSION 2018.3

ADD grains.patch /tmp/grains.patch
RUN curl -L http://repo.saltstack.com/apt/debian/8/amd64/${SALT_VERSION}/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb http://repo.saltstack.com/apt/debian/8/amd64/${SALT_VERSION} jessie main" > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && apt-get -y upgrade && \
    apt-get -y install salt-master && \
    patch /usr/lib/python2.7/dist-packages/salt/grains/core.py /tmp/grains.patch && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb && \
    rm -fr /tmp/*

COPY defaults.conf /etc/salt/master.d/defaults.conf
EXPOSE 4506 4505
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/bin/salt-master"]
