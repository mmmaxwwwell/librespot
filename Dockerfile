FROM alpine:edge

RUN apk -U add cargo portaudio-dev alsa-lib protobuf-dev llvm-libunwind libgcc
RUN cargo install librespot
RUN mv /root/.cargo/bin/librespot /bin
RUN mkdir -p /data
RUN mkfifo /data/fifo

#cleanup
RUN apk --purge del curl cargo portaudio-dev protobuf-dev
RUN rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/.cargo

CMD mkfifo /data/fifo && librespot \
  --name "$SPEAKER_NAME" \
  --bitrate $BITRATE \
  --volume-ctrl linear \
  --initial-volume=$INIT_VOL \
  --backend pipe \
  --device /data/fifo \
  --zeroconf-port $ZEROCONF_PORT \
  --cache /var/cache/librespot \
  --enable-volume-normalisation \
  --autoplay
