#!/bin/sh

python -m config
gunicorn app --worker-tmp-dir /dev/shm --bind 0.0.0.0:8000 -w ${WORKERS:-4} -t ${TIMEOUT:-180}
