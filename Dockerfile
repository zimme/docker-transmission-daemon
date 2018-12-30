FROM alpine

LABEL maintainer zimme

RUN apk add --no-cache --purge -uU \
  curl \
  shadow \
  tini \
  transmission-daemon \
  tzdata

COPY ./entrypoint.sh /
COPY ./settings.json /config/

RUN mkdir /downloads

RUN chown -R transmission:transmission /config /downloads

EXPOSE 9091 51413 51413/udp

VOLUME [ "/config", "/downloads" ]

HEALTHCHECK \
  --interval=30s \
  --timeout=30s \
  --start-period=5s \
  --retries=3 \
  CMD [ "curl", "http://localhost:9091" ]

ENV UID=2000
ENV GID=2000
ENV GIDS=
ENV TZDATA=

ENTRYPOINT [ "/sbin/tini", "--", "/entrypoint.sh" ]

CMD [ "transmission-daemon", "-g", "/config", "--foreground" ]
