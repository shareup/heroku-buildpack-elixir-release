#!/usr/bin/env bash

set -e
set -x

cd $(dirname ${0:-})

OTP_VERSION="$1"

if [[ -z "$OTP_VERSION" ]]; then
  echo "Must provide the OTP version as an argument"
  exit 1
fi

TAG="heroku-otp-build:$OTP_VERSION"
NAME="heroku-otp-build-$OTP_VERSION-container"
FILENAME="OTP-$OTP_VERSION.tar.gz"
TARPATH="/home/$FILENAME"
BUCKET="${BUCKET:-heroku-buildpack-elixir-release-default}"
ACL="${ACL:-public-read}"

mkdir -p ./builds/

docker build -t "$TAG" --build-arg OTP_VERSION="$OTP_VERSION" .
docker run --name="$NAME" "$TAG"

docker cp "$NAME:$TARPATH" ./builds/

docker stop "$NAME"
docker rm "$NAME"
