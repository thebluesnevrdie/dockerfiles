FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV TDAGENT_VERSION 2.3.4-0

RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add - && \
    echo "deb http://packages.treasuredata.com/2/debian/jessie/ jessie contrib" > /etc/apt/sources.list.d/td.list && \
    apt-get update && apt-get install -y td-agent=${TDAGENT_VERSION} && \
    /opt/td-agent/embedded/bin/gem install fluent-plugin-elasticsearch && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/td-agent/usr/sbin/td-agent"]
