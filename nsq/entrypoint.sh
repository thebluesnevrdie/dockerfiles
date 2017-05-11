#!/bin/bash
set -e

if [[ -z "$1" ]]; then
    exec "/bin/nsqd"
else
    exec "$@"
fi

exit 0
