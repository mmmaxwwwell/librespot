FROM alpine:edge

RUN \
  apk -U add cargo portaudio-dev protobuf-dev \
  && cargo install librespot \
  && mv /root/.cargo/bin/librespot /bin \
  && mkdir -p /data \
  && mkfifo /data/fifo \
  && apk --purge del curl cargo portaudio-dev protobuf-dev \
  && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/.cargo

CMD librespot -n "$SPEAKER_NAME" --initial-volume $INIT_VOL --device /data/fifo --zeroconf-port $ZEROCONF_PORT "$LIBRESPOT_ARGS"