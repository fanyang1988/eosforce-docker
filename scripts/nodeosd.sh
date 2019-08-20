#!/bin/sh
cd /opt/eosio/bin

cp /genesis.json /opt/eosio/bin/data-dir
cp /activeacc.json /opt/eosio/bin/data-dir

cp /contracts/System.wasm /opt/eosio/bin/data-dir
cp /contracts/System.abi /opt/eosio/bin/data-dir
cp /contracts/System01.wasm /opt/eosio/bin/data-dir
cp /contracts/System01.abi /opt/eosio/bin/data-dir
cp /contracts/System02.wasm /opt/eosio/bin/data-dir
cp /contracts/System02.abi /opt/eosio/bin/data-dir
cp /contracts/eosio.token.wasm /opt/eosio/bin/data-dir
cp /contracts/eosio.token.abi /opt/eosio/bin/data-dir
cp /contracts/eosio.msig.wasm /opt/eosio/bin/data-dir
cp /contracts/eosio.msig.abi /opt/eosio/bin/data-dir
cp /contracts/eosio.lock.wasm /opt/eosio/bin/data-dir
cp /contracts/eosio.lock.abi /opt/eosio/bin/data-dir

if [ -f '/opt/eosio/bin/data-dir/config.ini' ]; then
    echo
  else
    cp /config.ini /opt/eosio/bin/data-dir
fi


while :; do
    case $1 in
        --config-dir=?*)
            CONFIG_DIR=${1#*=}
            ;;
        *)
            break
    esac
    shift
done

if [ ! "$CONFIG_DIR" ]; then
    CONFIG_DIR="--config-dir=/opt/eosio/bin/data-dir"
else
    CONFIG_DIR=""
fi

prog_exit()
{
    ps -ef | grep nodeos | grep -v grep | awk '{print $2}' | xargs kill -15
}
trap "prog_exit" 15

exec /opt/eosio/bin/nodeos $CONFIG_DIR $@