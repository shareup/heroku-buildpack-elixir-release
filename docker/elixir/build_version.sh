#!/usr/bin/env bash

set -e
set -x

cd $(dirname ${0:-})

OTP_VERSION="$1"
ELIXIR_VERSION="$2"

if [[ -z "$OTP_VERSION" ]]; then
  echo "Must provide the OTP version as an argument"
  exit 1
fi

if [[ -z "$ELIXIR_VERSION" ]]; then
  echo "Must provide the elixir version as an argument"
  exit 1
fi

TAG="heroku-elixir-build:$ELIXIR_VERSION"
NAME="heroku-elixir-build-$ELIXIR_VERSION-container"
FILENAME="elixir-$ELIXIR_VERSION-OTP-$OTP_VERSION.tar.gz"
TARPATH="/home/$FILENAME"
BUCKET="${BUCKET:-heroku-buildpack-elixir-release-default}"
ACL="${ACL:-public-read}"

../otp/build_version.sh "$OTP_VERSION"

mkdir -p ./builds/

docker build -t "$TAG" --build-arg OTP_VERSION="$OTP_VERSION" --build-arg ELIXIR_VERSION="$ELIXIR_VERSION" .
docker run --name="$NAME" "$TAG"

docker cp "$NAME:$TARPATH" ./builds/

docker stop "$NAME"
docker rm "$NAME"
