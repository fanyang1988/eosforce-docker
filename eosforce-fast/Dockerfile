FROM ubuntu:18.04

# 1. install some deps
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl libgcc1 libcurl4-gnutls-dev libusb-1.0-0-dev && rm -rf /var/lib/apt/lists/*

# 2. copy datas

# this is just a fast build dockerfile, use builded binrarys
COPY bin /opt/eosio/bin

COPY nodeosd.sh /opt/eosio/bin/nodeosd.sh
COPY config.ini /

COPY genesis-datas/genesis.json /
COPY genesis-datas/activeacc.json /

COPY genesis-contracts /contracts

# 3. set env
ENV EOSIO_ROOT=/opt/eosio
RUN chmod +x /opt/eosio/bin/nodeosd.sh
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /opt/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
