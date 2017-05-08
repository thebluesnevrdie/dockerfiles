FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install dnsmasq && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb

EXPOSE 53 53/udp 69 69/udp
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/sbin/dnsmasq", "-k", "--log-facility=-", "-h", "-H", "/srv/dnsmasq-hosts"]
