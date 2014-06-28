#!/bin/bash
set -x

function cleanup {
    kill $BTCPID
}
trap cleanup EXIT

# Assume bitcoind built elsewhere and coied by Jenkins Copy Artifact plugin
BTCD=copied-artifacts/src/bitcoind
chmod +x $BTCD

# Run Bitcoin in regtest mode
mkdir -p regtest-datadir
cp bitcoin.conf regtest-datadir
mkdir -p logs
$BTCD -server -regtest -datadir=regtest-datadir -debug > logs/bitcoin.log &
BTCPID=$!

# Run integration tests
cd bitcoin-spock
./gradlew test

exit $?

