FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_VERSION 8u121
ENV JAVA_DEBIAN_VERSION 8u121-b13-1~bpo8+1
ENV CA_CERTIFICATES_JAVA_VERSION 20161107~bpo8+1
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    echo "path-exclude ${JAVA_HOME}/jre/man*" > /etc/dpkg/dpkg.cfg.d/no-java-docs && \
    apt-get update && apt-get -y install openjdk-8-jre-headless="$JAVA_DEBIAN_VERSION" ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb
