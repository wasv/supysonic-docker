FROM python:3.9-alpine

LABEL org.opencontainers.image.source https://github.com/wasv/supysonic-docker

RUN apk --no-cache add ffmpeg lame mpg123 vorbis-tools flac libjpeg-turbo postgresql-libs
ARG SUPYSONIC_VERSION
ENV SUPYSONIC_VERSION=${SUPYSONIC_VERSION:-0.6.2}
RUN apk --no-cache add git gcc musl-dev zlib-dev jpeg-dev postgresql-dev && \
    pip install psycopg2-binary gunicorn git+https://github.com/spl0k/supysonic@${SUPYSONIC_VERSION} && \
    apk del git gcc musl-dev zlib-dev jpeg-dev postgresql-dev

VOLUME [ "/data", "/music" ]

WORKDIR /app
COPY ./app /app
COPY supysonic.conf /etc/supysonic

EXPOSE 8000
CMD ["/app/entrypoint.sh"]
