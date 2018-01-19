FROM thebluesnevrdie/base
LABEL maintainer "Cody Crawford <me@codycrawford.net>"
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y --no-install-recommends install gcc libffi-dev \
    libssl-dev ca-certificates python-dev python && \
    curl -fSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && rm get-pip.py && \
    pip install --no-cache-dir --upgrade ndg-httpsclient && \
    pip install --no-cache-dir --upgrade pip && \
    apt-get -y purge --auto-remove gcc && \
    apt-get -y autoremove && rm -f /var/cache/apt/archives/*.deb
