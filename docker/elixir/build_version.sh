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

if [[ ! $(docker image ls | grep "heroku-otp-build:${OTP_VERSION}" > /dev/null) ]]; then
  ../otp/build_version.sh "$OTP_VERSION"
fi

mkdir -p ./builds/

docker build -t "$TAG" --build-arg OTP_VERSION="$OTP_VERSION" --build-arg ELIXIR_VERSION="$ELIXIR_VERSION" .

docker container ls | grep $NAME > /dev/null && {
  docker container rm $NAME
}

docker run --name="$NAME" "$TAG"

docker cp "$NAME:$TARPATH" ./builds/

mkdir -p ../../sums
shasum -a 256 ./builds/$FILENAME > ../../sums/$FILENAME.sha256

docker stop "$NAME"
docker rm "$NAME"
