FROM alpine:3.6

RUN apk add --no-cache --virtual .persistent-deps \
		socat

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENV ENV /root/.shinit
COPY env.sh /root/
RUN \
	{ \
		echo '. ~/env.sh'; \
	} >> /root/.shinit

ENTRYPOINT ["docker-entrypoint"]
CMD ["socat"]
