FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV NODE_VERSION 9.3.0
ENV PATH $PATH:/nodejs/bin

RUN apt-get update && apt-get install -y xz-utils && mkdir /nodejs && \
    curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz | tar xvJf - -C /nodejs --strip-components=1 && \
    npm install ldapjs ldif && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb

ADD ldap-server.js /root
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["node","/root/ldap-server.js"]
