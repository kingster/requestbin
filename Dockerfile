FROM python:3.9-alpine

RUN apk update && apk upgrade && \
    apk add \
        gcc g++ python3-dev libffi-dev gcc musl-dev make \
        # greenlet
        musl-dev \
        # sys/queue.h
        bsd-compat-headers \
        # event.h
        libevent-dev \
    && rm -rf /var/cache/apk/*

# want all dependencies first so that if it's just a code change, don't have to
# rebuild as much of the container
ADD requirements.txt /opt/requestbin/
RUN pip install -r /opt/requestbin/requirements.txt \
    && rm -rf ~/.pip/cache

# the code
ADD requestbin  /opt/requestbin/requestbin/

EXPOSE 8000

WORKDIR /opt/requestbin

ENV WORKERS=1
CMD gunicorn -b 0.0.0.0:8000 --worker-class gevent --workers $WORKERS --max-requests 1000 requestbin:app


