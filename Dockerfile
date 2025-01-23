FROM python:3.11-slim

# want all dependencies first so that if it's just a code change, don't have to
# rebuild as much of the container
ADD requirements.txt /opt/requestbin/
RUN pip install -r /opt/requestbin/requirements.txt \
    && rm -rf ~/.pip/cache

# the code
ADD requestbin  /opt/requestbin/requestbin/

ENV PORT=8000
EXPOSE 8000

WORKDIR /opt/requestbin

ENV WORKERS=1

CMD gunicorn -b 0.0.0.0:$PORT --worker-class gevent --workers $WORKERS --max-requests 1000 requestbin:app
