FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV NSQ_VERSION 1.0.0-compat

RUN curl -L https://s3.amazonaws.com/bitly-downloads/nsq/nsq-${NSQ_VERSION}.linux-amd64.go1.8.tar.gz -o /tmp/nsq.tgz && \
    tar xvf /tmp/nsq.tgz -C /tmp/ && \
    cp /tmp/nsq-*.linux-amd64*/bin/* /bin/ && \
    rm -fr /tmp/nsq* && \
    mkdir /data && mkdir /etc/nsq

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
