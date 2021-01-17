FROM python:3.9-alpine

RUN apk --no-cache add ffmpeg lame mpg123 vorbis-tools flac git
ARG SUPYSONIC_VERSION
ENV SUPYSONIC_VERSION=${SUPYSONIC_VERSION:-0.6.2}
RUN apk --no-cache add gcc musl-dev zlib-dev jpeg-dev libjpeg-turbo && \
    pip install gunicorn git+https://github.com/spl0k/supysonic@${SUPYSONIC_VERSION} && \
    apk del gcc musl-dev zlib-dev jpeg-dev

VOLUME [ "/data", "/music" ]

WORKDIR /app
COPY ./app /app
COPY supysonic.conf /etc/supysonic

EXPOSE 8000
CMD ["/app/entrypoint.sh"]
