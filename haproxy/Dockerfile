FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV HAPROXY_MAJOR 1.7
ENV HAPROXY_VERSION 1.7.4
ENV HAPROXY_MD5 dfdb293217f5077696d034564043a3ae
ENV HAPROXY_URL "http://www.haproxy.org/download/${HAPROXY_MAJOR}/src/haproxy-${HAPROXY_VERSION}.tar.gz"

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    buildDeps='gcc libc6-dev liblua5.3-dev libpcre3-dev libssl-dev make' && \
    apt-get update && apt-get install -y liblua5.3-0 libpcre3 libssl1.0.0 ${buildDeps} && \
    curl -L ${HAPROXY_URL} -o haproxy.tar.gz && \
    echo "${HAPROXY_MD5} *haproxy.tar.gz" | md5sum -c && mkdir -p /usr/src/haproxy && \
    tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 && \
    rm haproxy.tar.gz && makeOpts='TARGET=linux2628 USE_LUA=1 \
    LUA_INC=/usr/include/lua5.3 USE_OPENSSL=1 USE_PCRE=1 PCREDIR= USE_ZLIB=1' && \
    make -C /usr/src/haproxy -j4 all ${makeOpts} && \
    make -C /usr/src/haproxy install-bin ${makeOpts} && \
    mkdir -p /usr/local/etc/haproxy && \
    cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors && \
    rm -rf /usr/src/haproxy && apt-get purge -y --auto-remove ${buildDeps} && \
    curl -ksL "https://github.com/prometheus/haproxy_exporter/releases/download/v0.7.1/haproxy_exporter-0.7.1.linux-amd64.tar.gz" | tar fxz - -C /tmp && \
    mv /tmp/haproxy_exporter-*linux-amd64/haproxy_exporter /sbin && rm -fr /tmp/haproxy_exporter-* && \
    apt-get -y install supervisor && rm /etc/supervisor/supervisord.conf && \
    apt-get -y install socat && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb

ADD pysyslog.py /sbin
ADD supervisord.conf /etc/supervisord.conf
ADD haproxy.supervisor /etc/supervisor/conf.d/haproxy.conf
ADD pysyslog.supervisor /etc/supervisor/conf.d/pysyslog.conf
ADD exporter.supervisor /etc/supervisor/conf.d/exporter.conf

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
