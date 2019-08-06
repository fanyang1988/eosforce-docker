#!/bin/sh
VERSION_STR="1.7.0"
IMAGE_NAME="eosforce/eosapi:$VERSION_STR"
DEFAULT_EOSFORCE_ROOT="$HOME/Projects/eosforce/eosforce"
HTTP_PROXY=""

EOSFORCE_ROOT=${EOSFORCE_ROOT}
if [ "$EOSFORCE_ROOT" != "" ]; then
   printf "EOSForce root path : %s\\n" $EOSFORCE_ROOT
else
   printf "No Found EOSFORCE_ROOT use default"
   EOSFORCE_ROOT=$DEFAULT_EOSFORCE_ROOT
fi

printf "EOSForce root path : %s\\n" $EOSFORCE_ROOT

BIN_PATH="$EOSFORCE_ROOT/build/bin"
GENESIS_CONTRACT_PATH="../genesis-contracts"
GENESIS_DATAS_PATH="../genesis-datas"

printf "BIN PATH: %s\\n" $BIN_PATH
printf "CONTRACT PATH: %s\\n" $GENESIS_CONTRACT_PATH

# make eosforce path files

DOCKER_ROOT="../eosforce-fast"

mkdir -p "$DOCKER_ROOT/genesis-contracts"
cp -r $GENESIS_CONTRACT_PATH/* $DOCKER_ROOT/genesis-contracts/

mkdir -p "$DOCKER_ROOT/genesis-datas"
cp -r $GENESIS_DATAS_PATH/* $DOCKER_ROOT/genesis-datas/

cp -r ../scripts/nodeosd.sh $DOCKER_ROOT/
cp -r ../config/config.ini $DOCKER_ROOT/

mkdir -p "$DOCKER_ROOT/bin"
cp -r $BIN_PATH/* $DOCKER_ROOT/bin/

docker build $DOCKER_ROOT --build-arg https_proxy=$HTTP_PROXY --build-arg http_proxy=$HTTP_PROXY -t $IMAGE_NAME