#!/bin/sh
cd /opt/eosio/bin

DEFAULT_CONFIG_DIR="/eosforce/config/"
DEFAULT_DATA_DIR="/eosforce/data/"

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
    CONFIG_DIR=$DEFAULT_CONFIG_DIR
fi

CONFIG_DIR_PARAMS="--config-dir=$CONFIG_DIR"

cp /genesis.json $CONFIG_DIR/
cp /activeacc.json $CONFIG_DIR/

cp /contracts/*.wasm $CONFIG_DIR/
cp /contracts/*.abi $CONFIG_DIR/

if [ -f '$CONFIG_DIR/config.ini' ]; then
    echo
  else
    cp /config.ini $CONFIG_DIR/
fi


prog_exit()
{
    ps -ef | grep nodeos | grep -v grep | awk '{print $2}' | xargs kill -15
}
trap "prog_exit" 15

exec /opt/eosio/bin/nodeos $CONFIG_DIR_PARAMS --data-dir $DEFAULT_DATA_DIR $@
