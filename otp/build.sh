#!/usr/bin/env bash

set -e
set -x

OTP_VERSION="${1:-21.0.9}"
TAG="heroku-otp-build-$OTP_VERSION"
NAME="$TAG-container"
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

aws s3 cp "builds/$FILENAME" "s3://$BUCKET/$FILENAME" --acl "$ACL"
