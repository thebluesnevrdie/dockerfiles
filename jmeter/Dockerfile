FROM thebluesnevrdie/java
ENV ETCD_VERSION 2.3.8
ENV ETCDCTL_ENDPOINT "http://etcd:2379"
ENV JMETER_VERSION 3.2
ENV JMETER_URL http://apache.mirrors.tds.net//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_MD5 04a0119f3c66ec157d78725135f79863

RUN curl -L ${JMETER_URL} -o apache-jmeter-${JMETER_VERSION}.tgz && \
    echo "${JMETER_MD5} apache-jmeter-${JMETER_VERSION}.tgz" | md5sum -c && \
    tar -xzf apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm -f apache-jmeter-${JMETER_VERSION}.tgz && \
    curl -L https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -o /tmp/etcd.tgz && \
    tar xvf /tmp/etcd.tgz -C /tmp/ && \
    mv /tmp/etcd-v*-linux-amd64/etcdctl /bin/ && \
    rm -fr /tmp/*

ENV PATH $PATH:/opt/apache-jmeter-${JMETER_VERSION}/bin
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN mkdir /load_tests

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
