#!/bin/sh
set -x

# Assume bitcoind built elsewhere and coied by Jenkins Copy Artifact plugin
BTCD=copied-artifacts/src/bitcoind
chmod +x $BTCD

# Run Bitcoin in regtest mode
mkdir -p regtest-datadir
cp bitcoin.conf regtest-datadir
mkdir logs
$BTCD -server -regtest -datadir=regtest-datadir -debug > logs/bitcoin.log &

# Run integration tests
cd bitcoin-spock
./gradlew test

