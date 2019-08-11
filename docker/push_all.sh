#!/bin/bash

cd $(dirname ${0:-})

cd otp
./push_all.sh

cd ../elixir
./push_all.sh

