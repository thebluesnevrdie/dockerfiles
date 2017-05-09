#!/bin/bash
set -e

export JVM_ARGS="-Xmn512m -Xms512m -Xmx512m"

JMETER_LOG="jmeter.log" && touch $JMETER_LOG && tail -f $JMETER_LOG &

if [[ ${ROLE} == "server" ]]
then
    exec jmeter-server \
	 -D "server_port=${OURPORT}" \
	 -D "server.rmi.localport=${OURPORT}" \
	 -D "java.rmi.server.hostname=${OURIP}"
elif [[ ${ROLE} == "client" ]]
then
    export TIME=$(/bin/date +%b-%d_%H-%M)
    if [[ -z ${PLAN+x} ]]
    then
	export PLAN="test-plan.jmx"
    fi
    export PLAN_FILE=/load-tests/${PLAN}
    if [[ ! -e ${PLAN_FILE} ]]
    then
	echo "ERROR: Test plan file does not exist. Exiting..."
	exit 1
    fi
    if [[ ! -r ${PLAN_FILE} ]]
    then
	echo "ERROR: Test plan file is not readable. Exiting..."
	exit 1
    fi
    if [[ -s ${PLAN_FILE} ]]
    then
	echo "ERROR: Test plan file is empty. Exiting..."
	exit 1
    fi
    cp ${PLAN_FILE} /load_tests/test-plan_${TIME}.jmx
    exec jmeter --nongui \
	 -D "java.rmi.server.hostname=${OURIP}" \
	 -D "client.rmi.localport=1099" \
	 -t "/load_tests/test-plan_${TIME}.jmx" \
	 -l "/load_tests/test-plan_${TIME}.jtl" \
	 -R ${REMOTE_HOSTS}
fi    
fi
