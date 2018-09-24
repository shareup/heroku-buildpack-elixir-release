#!/usr/bin/env bash

set -e
set -x

cd $(dirname ${0:-})

export BUCKET="${BUCKET:-heroku-buildpack-elixir-release-default}"
export ACL="${ACL:-public-read}"

build_and_upload() {
  local otp_patch_version="$1"
  local otp_major_version=$(echo "$otp_patch_version" | cut -d'.' -f1)
  local patch_version="$2"
  local minor_version="$3"
  local filename="elixir-$patch_version-OTP-$otp_major_version.tar.gz"
  local s3_filename="s3://$BUCKET/$filename"

  ./build_version.sh "$otp_patch_version" "$patch_version"

  aws s3 cp "builds/$filename" "$s3_filename" --acl "$ACL"
  aws s3 cp "$s3_filename" "s3://$BUCKET/elixir-$minor_version-OTP-$otp_major_version.tar.gz" --acl "$ACL"
}

while IFS=, read -r otp_patch_version; do
  while IFS=, read -r patch_version minor_version; do
    build_and_upload "$otp_patch_version" "$patch_version" "$minor_version"
  done < versions.csv
done < ../otp/versions.csv
