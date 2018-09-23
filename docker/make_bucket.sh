#!/usr/bin/env bash

set -e
set -x

BUCKET="${BUCKET:-heroku-buildpack-elixir-release-default}"
REGION="${REGION:-us-west-1}"

aws s3 mb "s3://$BUCKET" --region "$REGION"
