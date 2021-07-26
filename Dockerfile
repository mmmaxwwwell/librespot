FROM alpine:edge

RUN apk -U add cargo portaudio-dev protobuf-dev
RUN cargo install librespot
RUN mv /root/.cargo/bin/librespot /bin
RUN mkdir -p /data
RUN mkfifo /data/fifo

#cleanup
RUN apk --purge del curl cargo portaudio-dev protobuf-dev
RUN rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/.cargo

CMD librespot -n "$SPEAKER_NAME" --initial-volume $INIT_VOL --device /data/fifo --zeroconf-port $ZEROCONF_PORT "$LIBRESPOT_ARGS"