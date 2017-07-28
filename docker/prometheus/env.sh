#!/bin/sh

if [ -z "$DOCKER_HOST" ]; then
	export DOCKER_HOST
	DOCKER_HOST=$(ip ro | awk '$1 == "default" {print $3}' ORS='')
	[ -n "$DOCKER_HOST" ] || { echo 'Could not determine DOCKER_HOST'; exit 1; }
fi
