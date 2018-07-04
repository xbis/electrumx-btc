FROM python:3.6-alpine3.6

COPY ./bin /usr/local/bin
COPY ./ electrumx/
COPY electrumx.conf /etc/electrumx.conf

RUN chmod a+x /usr/local/bin/* && \
    apk add --no-cache build-base openssl && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing leveldb-dev && \
    pip3 install aiohttp pylru plyvel && \
    cd electrumx && \
    python3 setup.py install && \
    apk del build-base && \
    rm -rf /tmp/*

VOLUME ["/data"]
ENV HOME /data
ENV ALLOW_ROOT 1
ENV DB_DIRECTORY /data 
ENV COIN=BitcoinSegwit
ENV NET=regtest
ENV PEER_DISCOVERY=
ENV HOST= 
ENV TCP_PORT=19500
ENV RPC_HOST= 
ENV RPC_PORT=19501
ENV SSL_PORT=19502 
ENV SSL_CERTFILE ${DB_DIRECTORY}/server.crt 
ENV SSL_KEYFILE ${DB_DIRECTORY}/server.key
WORKDIR /data

EXPOSE 19501
EXPOSE 19502

CMD ["init"]
