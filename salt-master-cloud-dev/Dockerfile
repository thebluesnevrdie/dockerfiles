FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

ADD grains.patch /tmp/grains.patch
RUN apt-get update && \
    apt-get -y install python2.7-minimal && \
    ln -s /usr/bin/python2.7 /bin/python && \
    curl -sSL https://bootstrap.pypa.io/get-pip.py | /bin/python && \
    curl -sSL https://bootstrap.saltstack.com | sh -s -- -P -M -L -X git && \
    patch /usr/lib/python2.7/dist-packages/salt/grains/core.py /tmp/grains.patch && \
    /usr/local/bin/pip install python-etcd && \
    apt-get -y install supervisor && rm /etc/supervisor/supervisord.conf && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb && \
    rm -fr /tmp/*

ADD supervisord.conf /etc/supervisord.conf
ADD master.supervisor /etc/supervisor/conf.d/master.conf
ADD minion.supervisor /etc/supervisor/conf.d/minion.conf

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
