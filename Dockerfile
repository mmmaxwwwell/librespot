FROM alpine:edge

RUN apk -U add cargo portaudio-dev protobuf-dev
RUN cargo install librespot
RUN mkdir -p /data
RUN mkfifo /data/fifo

CMD librespot -n "$SPEAKER_NAME" --device /data/fifo