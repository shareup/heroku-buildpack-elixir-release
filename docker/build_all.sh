#!/bin/bash

cd $(dirname ${0:-})

cd otp
./build_all.sh

cd ../elixir
./build_all.sh

