#!/usr/bin/env bash

docker build \
  -f Dockerfile.tests \
  -t heroku-buildpack-elixir-release-tests \
  --build-arg OTP_VERSION="21.0" \
  --build-arg ELIXIR_VERSION="1.7" \
  --build-arg REPO_URL="https://github.com/shareup-app/example_phoenix_app_for_heroku.git" \
  .
