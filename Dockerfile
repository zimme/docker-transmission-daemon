FROM alpine

LABEL maintainer zimme

RUN apk add --no-cache --purge -uU \
  curl \
  transmission-daemon \
  tzdata

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

USER transmission

ENTRYPOINT [ "transmission-daemon" ]

CMD [ "-g", "/config", "--foreground" ]
