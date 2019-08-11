#!/bin/bash

cd $(dirname ${0:-})
cd tests
docker-compose build
