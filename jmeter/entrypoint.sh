#!/bin/bash
set -e

export JVM_ARGS="-Xmn512m -Xms512m -Xmx512m"

JMETER_LOG="jmeter-server.log" && touch $JMETER_LOG && tail -f $JMETER_LOG &

exec jmeter-server \
     -D "server_port=${OURPORT}" \
     -D "server.rmi.localport=${OURPORT}" \
     -D "java.rmi.server.hostname=${OURIP}"
