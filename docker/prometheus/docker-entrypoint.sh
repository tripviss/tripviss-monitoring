#!/bin/sh
set -e

. ~/env.sh

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- prometheus "$@"
fi

if [ "$1" = 'prometheus' ]; then
	confd --onetime --confdir /usr/local/etc/confd --backend env
fi

exec "$@"
