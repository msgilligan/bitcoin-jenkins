#!/bin/sh
set -x

# Build Bitcoin
cd bitcoin
./autogen.sh
./configure
make
cd ..

