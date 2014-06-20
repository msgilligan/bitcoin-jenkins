#!/bin/sh
set -x

# Run Bitcoin in regtest mode
BTCD=bitcoin/src/bitcoind
mkdir -p regtest-datadir
cp bitcoin.conf regtest-datadir
mkdir logs
$BTCD -server -regtest -datadir=regtest-datadir -debug > logs/bitcoin.log &

# Run integration tests
cd bitcoin-spock
./gradlew test

