#!/bin/sh
set -e

. ~/env.sh

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- node_exporter "$@"
fi

if [ "$1" = 'node_exporter' ]; then
	host_hostname=$(cat /rootfs/etc/hostname)
	echo "host{host=\"$host_hostname\"} 1" > /var/lib/prometheus/node-exporter/host.prom
fi

exec "$@"
