#!/bin/sh
set -e

. ~/env.sh

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- socat "$@"
fi

# default args
if [ "$1" = 'socat' ] && [ $# -eq 1 ]; then
	set -- socat \
		-d -d \
		TCP-L:${DOCKER_EXPORTER_PORT:-9323},fork TCP:${DOCKER_HOST}:${DOCKER_METRICS_PORT:-9323}
fi

exec "$@"
