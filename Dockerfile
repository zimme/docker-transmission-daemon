FROM alpine:3.18.0

LABEL maintainer zimme

RUN apk add --no-cache --purge -uU \
  curl \
  transmission-daemon \
  tzdata

RUN mkdir /config /downloads

RUN chown -R transmission:transmission /config /downloads

COPY --chown=transmission:transmission ./settings.json /config/

VOLUME [ "/config", "/downloads" ]

EXPOSE 9091 51413 51413/udp

HEALTHCHECK \
  --interval=30s \
  --timeout=30s \
  --start-period=5s \
  --retries=3 \
  CMD [ "curl", "http://localhost:9091" ]

USER transmission

ENTRYPOINT [ "transmission-daemon" ]

CMD [ "--config-dir", "/config", "--foreground" ]
