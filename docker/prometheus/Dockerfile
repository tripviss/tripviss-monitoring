FROM alpine:3.6 as downloader

RUN apk add --no-cache --virtual .persistent-deps \
		ca-certificates \
		curl

ENV CONFD_VERSION 0.11.0

RUN curl -fSL https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o /usr/local/bin/confd \
	&& chmod +x /usr/local/bin/confd

FROM quay.io/prometheus/prometheus

COPY --from=downloader /usr/local/bin/confd /usr/local/bin/confd

COPY confd /usr/local/etc/confd/

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENV ENV /root/.shinit
COPY env.sh /root/
RUN \
	{ \
		echo '. ~/env.sh'; \
	} >> /root/.shinit

ENTRYPOINT ["docker-entrypoint"]
CMD [ \
	"-config.file=/etc/prometheus/prometheus.yml", \
	"-storage.local.path=/prometheus", \
	"-web.console.libraries=/usr/share/prometheus/console_libraries", \
	"-web.console.templates=/usr/share/prometheus/consoles" \
]
