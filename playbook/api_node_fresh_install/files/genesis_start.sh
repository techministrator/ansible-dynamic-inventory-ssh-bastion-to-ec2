#!/bin/bash
DATADIR="./canchain"

# Peers List
# * Only select the Peer BP which this BP network system is connected to based on the CAN Chain Mainnet Global Deployment Map
# * Connect to the nearest 4-5 BPs should be enough.
GENESIS=10.231.2.250  # Singapore Genesis BP
SGPBP=10.231.2.20  # Singapore BP
HKGBP=10.232.2.20  # Hong Kong BP
KORBP=10.233.2.20  # Seoul BP
JPNBP=10.234.2.20  # Tokyo BP
INDBP=10.235.2.20  # Mumbai BP
AUSBP=10.236.2.20  # Sydney BP
BHRBP=10.237.2.20  # Bahrain BP
BRABP=10.238.2.20  # Sao Paulo BP
USAVIRBP=10.239.2.20 # N. Virginia BP
USAOHIOBP=10.240.2.20 # Ohio BP
USACALIBP=10.241.2.20 # N. California
CANBP=10.242.2.20 # Canada BP
GBRLDNBP=10.244.2.20 # London BP
DEUBP=10.243.2.20 # Frankfurt BP
SWEBP=10.245.2.20 # Stockholm BP

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi

nodeos \
--genesis-json $DATADIR"/../genesis.json" \
--plugin eosio::chain_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::http_client_plugin \
--plugin eosio::net_api_plugin \
--plugin eosio::net_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--http-server-address 0.0.0.0:8888 \
--p2p-listen-endpoint 0.0.0.0:9010 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
--p2p-peer-address $USACALIBP:9010 \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"
