FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

COPY check-port.sh /check-port.sh

RUN chmod +x /check-port.sh

ENTRYPOINT ["/check-port.sh"]
